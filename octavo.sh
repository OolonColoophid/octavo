#!/usr/bin/env bash

# This file:
#
#  - Renders documents from Markdown using Pandoc templates 
#
# Usage:
#
#  LOG_LEVEL=7 ./main.sh -f /tmp/x -d (change this for your script)
#
# Based on a template by BASH3 Boilerplate v2.3.0
# http://bash3boilerplate.sh/#authors
#
# The MIT License (MIT)
# Copyright (c) 2013 Kevin van Zonneveld and contributors
# You are not obligated to bundle the LICENSE file with your b3bp projects as long
# as you leave these references intact in the header comments of your source files.

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
# set -o xtrace

# Any error set to 77 will exit the whole script. Useful if an error
# is called inside a subshell. However, this doesn't work for interpolated
# commands like:
# echo "$(exit 77)"
# However, it's the best I can do at the moment
trap '[ "$?" -ne 77 ] || exit 77' ERR

if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
	__i_am_main_script="0" # false

	if [[ "${__usage+x}" ]]; then
		if [[ "${BASH_SOURCE[1]}" = "${0}" ]]; then
			__i_am_main_script="1" # true
		fi

		__b3bp_external_usage="true"
		__b3bp_tmp_source_idx=1
	fi
else
	__i_am_main_script="1" # true
	[[ "${__usage+x}" ]] && unset -v __usage
	[[ "${__helptext+x}" ]] && unset -v __helptext
fi

# Set magic variables for current file, directory, os, etc.
__dir="$(cd "$(dirname "${BASH_SOURCE[${__b3bp_tmp_source_idx:-0}]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[${__b3bp_tmp_source_idx:-0}]}")"
__base="$(basename "${__file}" .sh)"


# Define the environment variables (and their defaults) that this script depends on
LOG_LEVEL="${LOG_LEVEL:-}" # 7 = debug -> 0 = emergency
NO_COLOR="${NO_COLOR:-}"    # true = disable color. otherwise autodetected


### Functions
##############################################################################

function __b3bp_log () {
	local log_level="${1}"
	shift

	# shellcheck disable=SC2034
	local color_debug="\x1b[35m"
	# shellcheck disable=SC2034
	local color_info="\x1b[32m"
	# shellcheck disable=SC2034
	local color_notice="\x1b[34m"
	# shellcheck disable=SC2034
	local color_warning="\x1b[33m"
	# shellcheck disable=SC2034
	local color_error="\x1b[31m"
	# shellcheck disable=SC2034
	local color_critical="\x1b[1;31m"
	# shellcheck disable=SC2034
	local color_alert="\x1b[1;33;41m"
	# shellcheck disable=SC2034
	local color_emergency="\x1b[1;4;5;33;41m"

	local colorvar="color_${log_level}"

	local color="${!colorvar:-${color_error}}"
	local color_reset="\x1b[0m"

	if [[ "${NO_COLOR:-}" = "true" ]] || [[ "${TERM:-}" != "xterm"* ]] || [[ "${TERM:-}" != "screen-256color"* ]] || [[ ! -t 2 ]]; then
		if [[ "${NO_COLOR:-}" != "false" ]]; then
			# Don't use colors on pipes or non-recognized terminals
			color=""; color_reset=""
		fi
	fi

	# all remaining arguments are to be printed
	local log_line=""

	while IFS=$'\n' read -r log_line; do
		echo -e "$(date -u +"%Y-%m-%d %H:%M:%S GMT") ${color}$(printf "[%9s]" "${log_level}")${color_reset} ${log_line}" 1>&2
	done <<< "${@:-}"
}

function emergency () {                                __b3bp_log emergency "${@}"; exit 1; }
function alert ()     { [[ "${LOG_LEVEL:-0}" -ge 1 ]] && __b3bp_log alert "${@}"; true; }
function critical ()  { [[ "${LOG_LEVEL:-0}" -ge 2 ]] && __b3bp_log critical "${@}"; true; }
function error ()     { [[ "${LOG_LEVEL:-0}" -ge 3 ]] && __b3bp_log error "${@}"; true; }
function warning ()   { [[ "${LOG_LEVEL:-0}" -ge 4 ]] && __b3bp_log warning "${@}"; true; }
function notice ()    { [[ "${LOG_LEVEL:-0}" -ge 5 ]] && __b3bp_log notice "${@}"; true; }
function info ()      { [[ "${LOG_LEVEL:-0}" -ge 6 ]] && __b3bp_log info "${@}"; true; }
function debug ()     { [[ "${LOG_LEVEL:-0}" -ge 7 ]] && __b3bp_log debug "${@}"; true; }

function help () {
	echo "" 1>&2
	echo " ${*}" 1>&2
	echo "" 1>&2
	echo "  ${__usage:-No usage available}" 1>&2
	echo "" 1>&2

	if [[ "${__helptext:-}" ]]; then
		echo " ${__helptext}" 1>&2
		echo "" 1>&2
	fi

	exit 1
}


### Parse commandline options
##############################################################################

# Commandline options. This defines the usage page, and is used to parse cli
# opts & defaults from. The parsing is unforgiving so be precise in your syntax
# - A short option must be preset for every long option; but every short option
#   need not have a long option
# - `--` is respected as the separator between options and arguments
# - We do not bash-expand defaults, so setting '~/app' as a default will not resolve to ${HOME}.
#   you can use bash variables to work around this (so use ${HOME} instead)

# shellcheck disable=SC2015
[[ "${__usage+x}" ]] || read -r -d '' __usage <<-'EOF' || true # exits non-zero when EOF encountered
usage: octavo.sh -f <file> [-c <file>] [-ybvdhn]

-f --file [arg]    Markdown file to process. Required.
-b --bash          Print Bash variables to standard output
-c --config [arg]  Specify a configuration Yaml file. Default is .octavoConfig.yml in the script directory.
-d --debug         Enables debug mode
-n --no-color      Disable color output
-o --output        Print processed Markdown
-p --pandocverbose Verbose Pandoc output to standard output
-u --dummy         Dummy run
-v --verbose       Enable verbose mode; print script as it is executed
-y --yaml          Print Yaml of Markdown file to standard output
-h --help          This page
EOF

# shellcheck disable=SC2015
[[ "${__helptext+x}" ]] || read -r -d '' __helptext <<-'EOF' || true # exits non-zero when EOF encountered
Octavo: Markdown to rendered documents using Pandoc.

Created by Ian Hocking <ihocking@gmail.com>
EOF

# Translate usage string -> getopts arguments, and set $arg_<flag> defaults
while read -r __b3bp_tmp_line; do
	if [[ "${__b3bp_tmp_line}" =~ ^- ]]; then
		# fetch single character version of option string
		__b3bp_tmp_opt="${__b3bp_tmp_line%% *}"
		__b3bp_tmp_opt="${__b3bp_tmp_opt:1}"

		# fetch long version if present
		__b3bp_tmp_long_opt=""

		if [[ "${__b3bp_tmp_line}" = *"--"* ]]; then
			__b3bp_tmp_long_opt="${__b3bp_tmp_line#*--}"
			__b3bp_tmp_long_opt="${__b3bp_tmp_long_opt%% *}"
		fi

		# map opt long name to+from opt short name
		printf -v "__b3bp_tmp_opt_long2short_${__b3bp_tmp_long_opt//-/_}" '%s' "${__b3bp_tmp_opt}"
		printf -v "__b3bp_tmp_opt_short2long_${__b3bp_tmp_opt}" '%s' "${__b3bp_tmp_long_opt//-/_}"

		# check if option takes an argument
		if [[ "${__b3bp_tmp_line}" =~ \[.*\] ]]; then
			__b3bp_tmp_opt="${__b3bp_tmp_opt}:" # add : if opt has arg
			__b3bp_tmp_init=""  # it has an arg. init with ""
			printf -v "__b3bp_tmp_has_arg_${__b3bp_tmp_opt:0:1}" '%s' "1"
		elif [[ "${__b3bp_tmp_line}" =~ \{.*\} ]]; then
			__b3bp_tmp_opt="${__b3bp_tmp_opt}:" # add : if opt has arg
			__b3bp_tmp_init=""  # it has an arg. init with ""
			# remember that this option requires an argument
			printf -v "__b3bp_tmp_has_arg_${__b3bp_tmp_opt:0:1}" '%s' "2"
		else
			__b3bp_tmp_init="0" # it's a flag. init with 0
			printf -v "__b3bp_tmp_has_arg_${__b3bp_tmp_opt:0:1}" '%s' "0"
		fi
		__b3bp_tmp_opts="${__b3bp_tmp_opts:-}${__b3bp_tmp_opt}"
	fi

	[[ "${__b3bp_tmp_opt:-}" ]] || continue

	if [[ "${__b3bp_tmp_line}" =~ (^|\.\ *)Default= ]]; then
		# ignore default value if option does not have an argument
		__b3bp_tmp_varname="__b3bp_tmp_has_arg_${__b3bp_tmp_opt:0:1}"

		if [[ "${!__b3bp_tmp_varname}" != "0" ]]; then
			__b3bp_tmp_init="${__b3bp_tmp_line##*Default=}"
			__b3bp_tmp_re='^"(.*)"$'
			if [[ "${__b3bp_tmp_init}" =~ ${__b3bp_tmp_re} ]]; then
				__b3bp_tmp_init="${BASH_REMATCH[1]}"
			else
				__b3bp_tmp_re="^'(.*)'$"
				if [[ "${__b3bp_tmp_init}" =~ ${__b3bp_tmp_re} ]]; then
					__b3bp_tmp_init="${BASH_REMATCH[1]}"
				fi
			fi
		fi
	fi

	if [[ "${__b3bp_tmp_line}" =~ (^|\.\ *)Required\. ]]; then
		# remember that this option requires an argument
		printf -v "__b3bp_tmp_has_arg_${__b3bp_tmp_opt:0:1}" '%s' "2"
	fi

	printf -v "arg_${__b3bp_tmp_opt:0:1}" '%s' "${__b3bp_tmp_init}"
done <<< "${__usage:-}"

# run getopts only if options were specified in __usage
if [[ "${__b3bp_tmp_opts:-}" ]]; then
	# Allow long options like --this
	__b3bp_tmp_opts="${__b3bp_tmp_opts}-:"

	# Reset in case getopts has been used previously in the shell.
	OPTIND=1

	# start parsing command line
	set +o nounset # unexpected arguments will cause unbound variables
	# to be dereferenced
	# Overwrite $arg_<flag> defaults with the actual CLI options
	while getopts "${__b3bp_tmp_opts}" __b3bp_tmp_opt; do
		[[ "${__b3bp_tmp_opt}" = "?" ]] && help "Invalid use of script: ${*} "

		if [[ "${__b3bp_tmp_opt}" = "-" ]]; then
			# OPTARG is long-option-name or long-option=value
			if [[ "${OPTARG}" =~ .*=.* ]]; then
				# --key=value format
				__b3bp_tmp_long_opt=${OPTARG/=*/}
				# Set opt to the short option corresponding to the long option
				__b3bp_tmp_varname="__b3bp_tmp_opt_long2short_${__b3bp_tmp_long_opt//-/_}"
				printf -v "__b3bp_tmp_opt" '%s' "${!__b3bp_tmp_varname}"
				OPTARG=${OPTARG#*=}
			else
				# --key value format
				# Map long name to short version of option
				__b3bp_tmp_varname="__b3bp_tmp_opt_long2short_${OPTARG//-/_}"
				printf -v "__b3bp_tmp_opt" '%s' "${!__b3bp_tmp_varname}"
				# Only assign OPTARG if option takes an argument
				__b3bp_tmp_varname="__b3bp_tmp_has_arg_${__b3bp_tmp_opt}"
				printf -v "OPTARG" '%s' "${@:OPTIND:${!__b3bp_tmp_varname}}"
				# shift over the argument if argument is expected
				((OPTIND+=__b3bp_tmp_has_arg_${__b3bp_tmp_opt}))
			fi
			# we have set opt/OPTARG to the short value and the argument as OPTARG if it exists
		fi
		__b3bp_tmp_varname="arg_${__b3bp_tmp_opt:0:1}"
		__b3bp_tmp_default="${!__b3bp_tmp_varname}"

		__b3bp_tmp_value="${OPTARG}"
		if [[ -z "${OPTARG}" ]] && [[ "${__b3bp_tmp_default}" = "0" ]]; then
			__b3bp_tmp_value="1"
		fi

		printf -v "${__b3bp_tmp_varname}" '%s' "${__b3bp_tmp_value}"
		debug "cli arg ${__b3bp_tmp_varname} = (${__b3bp_tmp_default}) -> ${!__b3bp_tmp_varname}"
	done
	set -o nounset # no more unbound variable references expected

	shift $((OPTIND-1))

	if [[ "${1:-}" = "--" ]] ; then
		shift
	fi
fi


### Automatic validation of required option arguments
##############################################################################

for __b3bp_tmp_varname in ${!__b3bp_tmp_has_arg_*}; do
	# validate only options which required an argument
	[[ "${!__b3bp_tmp_varname}" = "2" ]] || continue

	__b3bp_tmp_opt_short="${__b3bp_tmp_varname##*_}"
	__b3bp_tmp_varname="arg_${__b3bp_tmp_opt_short}"
	[[ "${!__b3bp_tmp_varname}" ]] && continue

	__b3bp_tmp_varname="__b3bp_tmp_opt_short2long_${__b3bp_tmp_opt_short}"
	printf -v "__b3bp_tmp_opt_long" '%s' "${!__b3bp_tmp_varname}"
	[[ "${__b3bp_tmp_opt_long:-}" ]] && __b3bp_tmp_opt_long=" (--${__b3bp_tmp_opt_long//_/-})"

	help "Option -${__b3bp_tmp_opt_short}${__b3bp_tmp_opt_long:-} requires an argument"
done


### Cleanup Environment variables
##############################################################################

for __tmp_varname in ${!__b3bp_tmp_*}; do
	unset -v "${__tmp_varname}"
done

unset -v __tmp_varname


### Externally supplied __usage. Nothing else to do here
##############################################################################

if [[ "${__b3bp_external_usage:-}" = "true" ]]; then
	unset -v __b3bp_external_usage
	return
fi


### Signal trapping and backtracing
##############################################################################

function __b3bp_cleanup_before_exit () {

	#removeTempFiles

	debug "Cleaning up. Done"
}
trap __b3bp_cleanup_before_exit EXIT

# requires `set -o errtrace`
__b3bp_err_report() {
	local error_code
	error_code=${?}
	error "Error in ${__file} in function ${1} on line ${2}"
	exit ${error_code}
}

# export LOG_LEVEL=7 # Shows INFO and DEBUG
# export LOG_LEVEL=6 # Shows INFO


# All of these go to STDERR, so you can use STDOUT for piping machine readable information to other software
#debug "Info useful to developers for debugging the application, not useful during operations
#info "Normal operational messages - may be harvested for reporting, measuring throughput, etc. - no action required."
#notice "Events that are unusual but not error conditions - might be summarized in an email to developers or admins to spot potential problems - no immediate action required."
#warning "Warning messages, not an error, but indication that an error will occur if action is not taken, e.g. file system 85% full - each item must be resolved within a given time. This is a debug message"
#error "Non-urgent failures, these should be relayed to developers or admins; each item must be resolved within a given time."
#critical "Should be corrected immediately, but indicates failure in a primary system, an example is a loss of a backup ISP connection."
#alert "Should be corrected immediately, therefore notify staff who can fix the problem. An example would be the loss of a primary ISP connection."
#emergency "A \"panic\" condition usually affecting multiple apps/servers/sites. At this level it would usually notify all tech staff on call."


function checkSet () {

	# This function inspects certain default variables (set in yaml by the user)
	# and ensures that there are set, if needs be. If they are set, directory 
	# or file targets are verified to exist


	# Ingore 'unbound' errors for the time being
	set +o nounset

	# shellcheck disable=SC2154
	if [ -z "${templatedir+x}" ]; then

		error "Required yaml variable \$templatedir has not been set." 
		exit 77	 
	elif  [ ! -d "$templatedir" ]; then

		error "The directory of templates files is set to $templatedir. However, this directory does not seem to exist."
		exit 77

	fi


	# shellcheck disable=SC2154
	if [ -z "${includedir+x}" ]; then

		error "Required yaml variable \$includedir has not been set." 
		exit 77	 
	elif  [ ! -d "$includedir" ]; then

		error "The directory of 'include' files is set to $includedir. However, this directory does not seem to exist."
		exit 77

	fi

	# shellcheck disable=SC2154
	if [ -z "${deployto+x}" ]; then

		error "Required yaml variable \$deployto has not been set." 
		exit 77	 
	elif  [ ! -d "$includedir" ]; then

		error "The directory where Octavo will put output files is set to $deployto. However, this directory does not seem to exist."
		exit 77

	fi




	# shellcheck disable=SC2154
	if [ -z "${headimage+x}" ]; then
		:
	elif [ ! -f "$headimage.png" ]; then
		error "$headimage.png: This file has been specified as the value for \$headimage, but the file does not exist"
		exit 77
	fi

	# shellcheck disable=SC2154
	if [ -z "${bibliography+x}" ]; then
		:
	elif [ ! -f "$bibliography" ]; then
		error "$bibliography: This file has been specified as the value for \$bibliography, but the file does not exist"
		exit 77
	fi




	# No more unbound errors expected
	set -o nounset


}


function randomString () {

	debug "Function: generateID"

	# This function generates a random (ish) five-character mixture
	# of upper and lower case characters

	#shellcheck disable=SC2004
	seed=$(($(date +%s%n) + $RANDOM)) 
	echo $seed | md5 | base64 | head -c 5

}


function splice () {

	debug "Function: splice"

	# Insert [multi-line] REPLACEMENT string
	# into [multi-line] SOURCE string
	# after the line matched by PATTERN


	# - takes the arguments:
	#   source, pattern, replacement
	# - returns multi-line text

	sourceText="$1"
	pattern="$2"
	replacement="$3"
	mode="$4"




	while read -r line; do
		if test "${line#*$pattern}" != "$line"; then
			if [[ "$mode" == "insert" ]]; then
				echo "$line"
			fi

			#shellcheck disable=SC2001
			echo "$line" | sed "s@$pattern@$replacement@g" 

			continue	
		fi
		echo "$line"
	done < <(echo "$sourceText" )

	debug "Function: splice completed for pattern $pattern"

}

function insertIncludes () {

	debug "Function: insertIncludes"

	# Insert [multi-line] REPLACEMENT string
	# into [multi-line] SOURCE string
	# overwriting the line matched by PATTERN


	# - takes a multi-line string
	# from standard input

	# Variable $includedir in set in .octavoConfig.yml

	# In the source Markdown, includes should take this format
	# and be on one line (this will inserts 'licence.markdown':
	# <include>licence</include>

	pipedInput="$(cat)" # Capture multi-line input from Stdin
	sourceText="$pipedInput"

	pattern="<include>"

	while read -r line; do
		if test "${line#*$pattern}" != "$line"; then
			#shellcheck disable=SC2001
			includeFile=$(echo "$line" | sed 's/<[^>]*>//g') # Get filename
			#shellcheck disable=SC2154
			cat "$includedir/${includeFile}.markdown" 
			continue	     
		fi
		echo "$line"
	done < <(echo "$sourceText" )

	debug "Function: splice completed for pattern $pattern"

}


### Parse Yaml
##############################################################################


# This function copied from https://gist.github.com/pkuczynski/8665367
yamlParseToBashVars() {

	debug "Function yamlParseToBashVars"

	# Parse yaml and produce bash-compatible variable-value pairs
	# - takes a filename
	# - returns file text

	local prefix=$1
	local s
	local w
	local fs
	s='[[:space:]]*'
	w='[a-zA-Z0-9_]*'
	fs="$(echo @|tr @ '\034')"
	sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
		-e "s|^\($s\)\($w\)$s[:-]$s\(.*\)$s\$|\1$fs\2$fs\3|p" "$1" |
	awk -F"$fs" '{
	indent = length($1)/2;
	vname[indent] = $2;
	for (i in vname) {if (i > indent) {delete vname[i]}}
		if (length($3) > 0) {
			vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
			printf("%s%s%s=(\"%s\")\n", "'"$prefix"'",vn, $2, $3);
		}
	}' | sed "s/_=/+=/g; s%$1%%g; s/\"\"/\"/g" 
}

function yamlMakeSafeForBashVars () {

	debug "Function: yamlMakeSafeForBashVars"

	# Replace hyphens in some variables name with underscores
	# - takes file text
	# - returns file text

	# Improvements: make this work for all variable names with underscores,
	# move it to the end of the yamlParseToBashVariables function

	pipedInput="$(cat)" # Capture multi-line input from Stdin

	# Make yaml keys suitable for use as Bash variables:
	echo "$pipedInput" | sed 's/link-citations:/link_citations:/g; s/citation-style:/citation_style:/g; s/toc-depth:/toc_depth:/g; s/title-meta:/title_meta:/g'

}

function yamlSplitFromMarkdown () {

	debug "Function: yamlSplitFromMarkdown"

	# Take Markdown file and extract only the yaml portion
	# - takes file text
	# - returns file text


	pipedInput="$(cat)" # Capture multi-line input from Stdin

	echo "$pipedInput" | sed -n '/^---$/,/^---$/p' | sed '/^---$/d'

	}

function yamlAddCustomYaml () {

	debug "Function yamlAddCustomYaml"

	# Locate 'includeyaml' key in yaml and splice in a yaml file
	# as specified in the key value

	# - takes file text
	# - returns file text

	# Improvements:
	# - Verify that this behaves sensibly if there is more than one includeyaml key

	pipedInput="$(cat)" # Capture multi-line input from Stdin


	case "$pipedInput" in
		*includeyaml:*)
			debug "Found yaml to include"
			includeYamlFilename="$(echo "$pipedInput" | egrep "includeyaml" | sed 's/includeyaml: *//g; s/\"//g')"
			debug "Extra yaml to add: $includeYamlFilename"

			if [ ! -f "$includeYamlFilename" ]; then
				error "$includeYamlFilename: This file, a referenced external .yml file, does not exist"
				exit 77
			fi

			#shellcheck disable=SC2034
			includeYaml="$(cat "$includeYamlFilename")"
			echo "$pipedInput" | awk -v includeYamlFilename="$includeYamlFilename" '/includeyaml/{system("cat " includeYamlFilename);next}1' 

			;;
		*)
			debug "No request to include yaml"
			echo "$pipedInput"
			;;

		esac
	}

	function yamlRemoveComments () {

		debug "Function yamlRemoveComments"

		# Locate comments - denoted by hashes - in yaml 
		# and strip them

		# Example:
		# title: "Document" # Change this later

		# - takes file text
		# - returns file text

		pipedInput="$(cat)" # Capture multi-line input from Stdin

		# Find comments marked with a hash and remove them.
		#shellcheck disable=SC2001
		echo "$pipedInput" | \
			sed 's/ *#.*//g'

		# If user requests yaml print out
		if [[ "${arg_y:?}" = "1" ]]; then

			while read -r line; do info "$line"; done <<< "$pipedInput"

			fi

		}

		######################################################################################

		function createSpokenVersion () {

			debug "Function: createSpokenVersion"

			# - takes multiline source text
			# - writes a spoken version file

			# Improvements: make this work for all variable names with underscores,
			# move it to the end of the yamlParseToBashVariables function

			pipedInput="$(cat)" # Capture multi-line input from Stdin


			# Here is what worked in the original version of Octavo:
			# octavoSpoken, "spoken format", sed "s@& documentFormat &@$deployDescription[$counter]@g" | pandoc  $customfilterfour --filter="$OCTAVOPATH/filters/filterDivToLatex.py" $customfilterone $customfiltertwo $customfilterthree "$numberSections" | pandoc -f html -t plain | sed 's/_//g' | sed 's/↩//g' | say --voice='Alex'--quality=127 --file-format='mp4f' -o "$deployto/$basenameSourceFile$element$mdFive.mp4",.mp4

			for indexReq in "${!deployFormatRequestedStatus[@]}" # Loop through the available templates


			do


				if [[ "${deployFormatRequestedStatus[indexReq]}" == *"true"* ]]; then

					templateName=$(echo "$indexReq" | templateNumToTemplate)

					if [[ "$templateName" == "octavoSpokenMacOs" ]]; then


						filters=$(echo "$indexReq" | templateNumToFilters)

						_format="$(echo "$indexReq" | templateNumToFormat)"

						name="$(echo "$indexReq" | templateNumToTemplate)"

					fi
				fi
			done

			# Note that the code to generate the filename is copied from templateNumToPandocCommand 
			markdownSourceFileBasename="$(basename "$markdownSourceFile")"
			filenameSourceFile="${markdownSourceFileBasename%.*}" # trim extension

			# shellcheck disable=SC2154
			if [[ "${mdfivehashset}" == "true" ]]; then
				filenameSourceFile+="_$mdFiveHashOutput"
			fi

			filenameSourceFile="$filenameSourceFile$name"



			#shellcheck disable=SC2089
			spokenCommand="pandoc $filters | pandoc -f html -t plain | sed 's/_//g' | sed 's/↩//g' | say --voice='Alex' --quality=127 --file-format='mp4f' -o \"$localStagingDir/$filenameSourceFile.$_format\""


			if [[ "$DUMMY_RUN" == true ]]; then

				echo "Pandoc command (not executed):"
				echo
				echo "$spokenCommand"
			else

				#shellcheck disable=SC2116
				echo "$pipedInput" | eval "$(echo "$spokenCommand")"

			fi
		}

		function addDeploymentText () {
			debug "Function: addDeploymentText"

			# Receives entire text of file; outputs entire text of file

			# Replace & deployments & string with a helpful paragraph
			# giving the reader links to other versions of the document

			# - takes text # - returns multiline text 
			pipedInput="$(cat)" # Capture multi-line input from Stdin

			# Now we should generate the text that tells the reader about
			# alternative versions

			# To do: Add the hash to the final file if requeste

			# shellcheck disable=SC2154
			IFS=' ' read -r -a deployFormatRequested <<< "$formats"

			for indexReq in "${!deployFormatRequested[@]}" 
			do

				deploymentTextBody+="$(buildDeploymentText "${deployFormatRequested[indexReq]}")"

			done

			deploymentTextBody="$(echo "$deploymentTextBody" | rev | sed 's/ ,//' | sed 's/ ,/ dna /' | rev)" # Add the final 'and' to the list of names

			deploymentTextAll="This document is available in $deploymentTextBody."

			splice "$pipedInput" "<replace>deployments</replace>" "$deploymentTextAll" "overwrite"

		}

		function buildDeploymentText () {
			debug "Function: buildDeploymentText"
			# Receives a format (e.g. ocatvoDocx)
			# Returns a piece of the 'deployment' text telling the user
			# which formats the document exists in

			availableFormat="$1"


			textBody+="["
			textBody+="$(echo "$availableFormat" | formatToTemplateName | sed 's/,//g')"
			textBody+="]"
			textBody+="("
			# shellcheck disable=SC2154
			textBody+="$httpdestination"
			textBody+="$sourceFileBasename"

			if [[ "$mdfivehashset" == "true" ]]; then

				textBody+="_$mdFiveHashOutput"

			fi

			# shellcheck disable=SC2001
			textBody+="$(echo "$availableFormat" | sed 's/,//g')"
			textBody+="."
			textBody+="$(echo "$availableFormat" | formatToTemplateExtension | sed 's/,//g')"
			textBody+=")"

			# The script will be less fragile
			# if 'and' is used here when it's
			# the last loop
			textBody+=", "
			debug "Text body is $textBody"	
			echo "$textBody"

		}

		function expandStrings () {

			debug "Function: expandStrings"

			# Locate strings - e.g. $HOME - in yaml 
			# and expand them

			# Example:
			# title: "Document" # Change this later

			# - takes a filename
			# - returns multiline text

			# Improvements:
			# What other shell variables might the user want expanded?

			dateOutput="$(date "+%D %T")"
			# Note computerOutput only works for MacOS in this form
			hostName="$(hostname -s | sed 's/\.local//g' | sed 's/\b./\u&/g')"
			# shellcheck disable=SC2086
			hostName="$(tr '[:lower:]' '[:upper:]' <<< ${hostName:0:1})${hostName:1}" # Trick to upper case hostname

			sed "s@\$HOME@$HOME@g; s@\$octavoPath@$octavoPath@g" \
				| sed "s@<replace>date</replace>@$dateOutput@g" \
				| sed "s@<replace>computer</replace>@$hostName@g" \
				| sed "s@<replace>mdfive</replace>@$mdFiveHashOutput@g" \
				| sed 's/<task>/<div latex="true" class="task" id="Task">/g' \
				| sed 's/<journal>/<div latex="true" class="journal" id="Journal">/g' \
				| sed 's/<answer>/<div latex="true" class="answer" id="Answer">/g' \
				| sed 's/<remember>/<div latex="true" class="highlight" id="Remember">/g' \
				| sed 's/<highlight>/<div latex="true" class="highlight" id="Highlight">/g' \
				| sed 's/<\/task>/<\/div>/g' \
				| sed 's/<\/journal>/<\/div>/g' \
				| sed 's/<\/remember>/<\/div>/g' \
				| sed 's/<\/highlight>/<\/div>/g' \
				| sed 's/<\/answer>/<\/div>/g' \
				| sed 's/<do>/<span class="inlineDo">/g ' \
				| sed 's/<pop>/<span class="inlinePopout">/g ' \
				| sed 's/<key>/<span class="inlineKeyword">/g ' \
				| sed 's/<\/do>/<\/span>/g' \
				| sed 's/<\/pop>/<\/span>/g' \
				| sed 's/<\/key>/<\/span>/g' \
				| sed 's/formats:.*"all"/formats: "octavoTuftePdf, octavoNormalPdf, octavoTufteSolarisedPdf, octavoOpenDyslexicPdf, octavoLargePdf, octavoDocx, octavoHtml, octavoSpokenMacOs"/g'

		}



		function sourceOctavoConfig() {

			debug "Function sourceOctavoConfig"

			# Load configuration and set corresponding Bash 
			# variables for use with this script

			# Note that 'source' requires an unusual form of process substitution
			# http://stackoverflow.com/questions/32596123/why-source-command-doesnt-work-with-process-substitution-in-bash-3-2
			source /dev/stdin <<<"$(yamlParseToBashVars <(cat "$1" | 
			expandStrings | 
			yamlAddCustomYaml | 
			yamlRemoveComments | 
			yamlMakeSafeForBashVars))" &&
				debug "Config yaml parsed and loaded as bash variables"




			# If user requests bash print out
			if [[ "${arg_b:?}" = "1" ]]; then

				# shellcheck disable=SC2002
				yamlParseToBashVars <(cat "$1" | 
				expandStrings | 
				yamlAddCustomYaml | 
				yamlRemoveComments | 
				yamlMakeSafeForBashVars)

			fi


		}


		function sourceMarkdownFileYaml() {

			debug "Function: sourceMarkdownFileYaml"

			# Read the ayml in the Markdown source file
			# and set them as Bash variables for use with
			# this script

			source /dev/stdin <<<"$(yamlParseToBashVars <(cat "$1" | 
			expandStrings | 
			yamlSplitFromMarkdown |
			yamlAddCustomYaml | 
			yamlRemoveComments | 
			yamlMakeSafeForBashVars))" &&
				debug "Markdown file yaml parsed and loaded as bash variables"

			# shellcheck disable=SC2154
			# debug "title is $title"

			# If user requests bash print out
			if [[ "${arg_b:?}" = "1" ]]; then

				# shellcheck disable=SC2002
				yamlParseToBashVars <(cat "$1" | 
				expandStrings | 
				yamlSplitFromMarkdown |
				yamlAddCustomYaml | 
				yamlRemoveComments | 
				yamlMakeSafeForBashVars)

			fi



		}

		function parseMarkdownSource() {

			# Get text of Markdown Source File

			# Receives: 
			# Markdown filename
			# Export preference (body/yaml)

			sourceFile="$1"
			exportPreference="$2"


			# Return 

			debug "Function: parseMarkdownSource"

			# shellcheck disable=SC2002
			sourceYaml="$(cat "$sourceFile" | sed -n '/^---$/,/^---$/p')"
			# shellcheck disable=SC2002
			sourceBody="$(cat "$sourceFile" | sed '/^---$/,/^---$/{//!d;}' | sed '/^---$/d')"

			case "$exportPreference" in
				yaml) echo "$sourceYaml" | expandStrings | yamlAddCustomYaml | yamlRemoveComments
					;;
				body) echo "$sourceBody" | \
					expandStrings
				;;

			esac

		}

		function getMarkdownFileBody() {

			# Receives:
			# Markdown file text
			# Returns:
			# The body (i.e. without Yaml) as string

			debug "Function: getMarkdownFileBody"

			pipedInput="$(cat)" # Capture multi-line input from Stdin

			parseMarkdownSource "$pipedInput" "body" 

		}

		function getMarkdownFileYaml() {

			# Receives:
			# Markdown file text
			# Returns:
			# The Yaml (i.e. without body) as string

			debug "Function: getMarkdownFileYaml"

			pipedInput="$(cat)" # Capture multi-line input from Stdin
			parseMarkdownSource "$pipedInput" "yaml" 

		}

		function getRequestedDeployFormats() {

			# Get text of Markdown Source File

			# Receives: 
			# Formats requested for deployment (i.e. production by Pandoc
			# in the Yaml variable (and now Bash variable):
			# $format
			#
			# Produces:
			# A single line of true/false statements that correspond to
			# the formats in .octavoConfig.yml. True means that the user
			# wishes to have that format produced

			debug "Function: getRequestedDeployFormats"

			# shellcheck disable=SC2154
			IFS=' ' read -r -a deployFormatsRequested <<< "$formats" # break formats into array
			deployFormatsRequested=( "${deployFormatsRequested[@]/,}" ) # remove commas from formats
			availableFormatCount="$(templateCount)" # get number of elements available 


			for ((indexAvail=0;indexAvail<=availableFormatCount-1;indexAvail++)); # Loop for each format available
			do

				storedFormat="template$indexAvail"
				currentFormat="${!storedFormat}" # Echo variable of, e.g., template1
				_templateRequested[indexAvail]=false

				for indexReq in "${!deployFormatsRequested[@]}"
				do

					# Here, check if the available format has been requested from the user; if so, created a variable called template$i_requested=true
					if [[ "${deployFormatsRequested[indexReq]}" == "$currentFormat" ]]; then
						_templateRequested[indexAvail]=true
					fi
				done

			done

			echo "${_templateRequested[@]}"

		}

		function markdownSourcePrepare() {

			echo "$markdownSourceFile" | \
				getMarkdownFileYaml

			echo "$markdownSourceFile" | \
				getMarkdownFileBody | \
				insertIncludes | \
				expandStrings | \
				addDeploymentText


		}

		function templateCount () {

			# Receives nothing
			# Pipes back the number of available templates
			# in .octavoConfig.yml

			debug "Function: templateCount"

			egrep -o "name: " "$octavoPath/.octavoConfig.yml" | wc -l

		}


		function formatToTemplateExtension () {

			debug "Function: formatToTemplateExtension"

			# Receives a format, e.g. docx
			# Pipes back the file extension, e.g. .docx
			pipedInput="$(cat)" # Capture input from Stdin
			# shellcheck disable=SC2034
			requestedFormat="$pipedInput"

			# Ingore 'unbound' errors for the time being
			set +o nounset

			availableFormatCount="$(templateCount)" # get number of elements available 

			# Iterate through all templates
			# Check, e.g. template7_format="docx"
			# If match, pipe back template7_name
			for ((indexAvail=0;indexAvail<=availableFormatCount-1;indexAvail++)); # Loop for each format available
			do
				storedFormat="template$indexAvail"
				currentFormat="${!storedFormat}" # Echo variable of, e.g., template1


				storedFormat_ext="template$indexAvail"
				storedFormat_ext+="_format"
				currentFormat_ext="${!storedFormat_ext}" # Echo variable of, e.g., template1_name

				if [[ $requestedFormat == *"$currentFormat"* ]]; then
					# shellcheck disable=SC2001
					format_ext="$(echo "$requestedFormat" | sed "s/$currentFormat/$currentFormat_ext/g")"
				fi

			done


			echo "$format_ext" 

			# Restore 'unbound' error checking 
			set -o nounset

		}

		function formatToTemplateName () {

			debug "Function: formatToTemplateName"

			# Receives a format, e.g. docx
			# Pipes back the full name of the template
			pipedInput="$(cat)" # Capture input from Stdin
			# shellcheck disable=SC2034
			requestedFormat="$pipedInput"

			# Ingore 'unbound' errors for the time being
			set +o nounset

			availableFormatCount="$(templateCount)" # get number of elements available 

			# Iterate through all templates
			# Check, e.g. template7_format="docx"
			# If match, pipe back template7_name
			for ((indexAvail=0;indexAvail<=availableFormatCount-1;indexAvail++)); # Loop for each format available
			do
				storedFormat="template$indexAvail"
				currentFormat="${!storedFormat}" # Echo variable of, e.g., template1


				storedFormat_name="template$indexAvail"
				storedFormat_name+="_name"
				currentFormat_name="${!storedFormat_name}" # Echo variable of, e.g., template1_name

				if [[ $requestedFormat == *"$currentFormat"* ]]; then
					# shellcheck disable=SC2001
					format_Name="$(echo "$requestedFormat" | sed "s/$currentFormat/$currentFormat_name/g")"
				fi

			done


			echo "$format_Name" 

			# Restore 'unbound' error checking 
			set -o nounset

		}

		function templateNumToTemplate () {

			debug "Function: templateNumToTemplate"

			# Receives a template number, 0+
			# Pipes back the name of the template
			pipedInput="$(cat)" # Capture input from Stdin
			number="$pipedInput"

			# Ingore 'unbound' errors for the time being
			set +o nounset

			storedTemplate="template$number"
			echo "${!storedTemplate}"

			# Restore 'unbound' error checking 
			set -o nounset

		}

		function templateNumToName () {

			debug "Function: templateNumToName"

			# Receives a template number, 0+
			# Pipes back the name of the template
			pipedInput="$(cat)" # Capture input from Stdin
			number="$pipedInput"

			# Ingore 'unbound' errors for the time being
			set +o nounset

			storedTemplate="template$number"
			prefix=$storedTemplate
			affix="_name"
			storedName="$prefix$affix"

			echo "${!storedName}"

			# Restore 'unbound' error checking 
			set -o nounset

		}	

		function templateNumToFormat () {

			debug "Function: templateNumToFormat"

			# Receives a template number, 0+
			# Pipes back the name of the format
			pipedInput="$(cat)" # Capture input from Stdin
			number="$pipedInput"

			# Ingore 'unbound' errors for the time being
			set +o nounset

			storedTemplate="template$number"
			prefix=$storedTemplate
			affix="_format"
			storedFormat="$prefix$affix"

			echo "${!storedFormat}"

			# Restore 'unbound' error checking 
			set -o nounset

		}	

		function templateNumToExecutable () {

			debug "Function: templateNumToExecutable"

			# Receives a template number, 0+
			# Pipes back the name of the executable 
			pipedInput="$(cat)" # Capture input from Stdin
			number="$pipedInput"

			# Ingore 'unbound' errors for the time being
			set +o nounset

			storedTemplate="template$number"
			prefix=$storedTemplate
			affix="_executable"
			storedExecutable="$prefix$affix"

			# Check executable against whitelist
			if [ -z "${_executable+x}" ]; then 
				:
			else

				case $_executable in 
					pandoc|say)
						:
						;;
					*)
						error "Octavo will only build documents using commands 'pandoc' or 'say'. A command called '$_executable' was specified."
						exit 77
						;;
				esac
			fi					


			echo "${!storedExecutable}"

			# Restore 'unbound' error checking 
			set -o nounset

		}	


		function templateNumToExtension () {

			debug "Function: templateNumToExtension"

			# Receives a template number, 0+
			# Pipes back the name of the template extension 
			pipedInput="$(cat)" # Capture input from Stdin
			number="$pipedInput"

			# Ingore 'unbound' errors for the time being
			set +o nounset

			storedTemplateExtension="template$number"
			prefix=$storedTemplateExtension
			affix="_templateextension"
			storedExtension="$prefix$affix"


			echo "${!storedExtension}"


			# Restore 'unbound' error checking 
			set -o nounset

		}	

		function templateNumToArguments () {

			debug "Function: templateNumToArguments"

			# Ingore 'unbound' errors for the time being
			set +o nounset

			# Receives a template number, 0+
			# Pipes back the arguments associated with the
			# executable
			pipedInput="$(cat)" # Capture input from Stdin
			number="$pipedInput"

			storedTemplate="template$number"
			prefix=$storedTemplate
			affix="_executable_arguments"
			# shellcheck disable=SC1087
			storedArguments="$prefix$affix[@]"
			debug "storedArguments are ${!storedArguments}"

			echo "${!storedArguments}"

			# Restore 'unbound' error checking 
			set -o nounset


		}

		function templateNumToFilters () {

			debug "Function: templateNumToFilters"

			# Ingore 'unbound' errors for the time being
			set +o nounset

			# Receives a template number, 0+
			# Pipes back the filters associated with the
			# executable
			pipedInput="$(cat)" # Capture input from Stdin
			number="$pipedInput"

			storedTemplate="template$number"
			prefix=$storedTemplate
			affix="_executable_arguments__filters"
			# shellcheck disable=SC1087
			storedFilters="$prefix$affix[@]"

			__filterstring="${!storedFilters}"

			IFS=' ' read -r -a __filters <<< "$__filterstring"
			
			# Add custom filters, if found
			# shellcheck disable=SC2154
			if [ -z "${customfilters+x}" ]; then 
				:
			else 
				IFS=' ' read -r -a __customfilters <<< "${customfilters//,}" # create array
				__filters=("${__filters[@]}" "${__customfilters[@]}")
			fi


			# Add '--filter=' to each of the requested filters
			for indexF in "${!__filters[@]}"
			do

				case ${__filters[indexF]} in
					*pandoc-citeproc*)
						__filters[indexF]="--filter=\"pandoc-citeproc\""
						;;
					*pandoc-crossref*)
						__filters[indexF]="--filter=\"pandoc-crossref\""
						;;
					*pandoc-csv2table*)
						__filters[indexF]="--filter=\"pandoc-csv2table\""
						;;
					*)
						__filters[indexF]="--filter=\"$octavoPath/filters/${__filters[indexF]}\""
						;;

					esac

				done

			# Prepend a redaction filter, if requested
			# shellcheck disable=SC2154
			if [[ $redact = "true" ]] ; then 
			
				# shellcheck disable=SC2145
				echo "--filter=\"$octavoPath/filters/filterRedactions.py\" ${__filters[@]}" 
			
			else
			
				echo "${__filters[@]}"
			
			fi




				# Restore 'unbound' error checking 
				set -o nounset


			}

			function templateFormatToName () {

				# Before I do this, I might want to rationalise the name/format/blank reference issue
				# in the Yaml

				# Function is passed 'name'

				# Bash variables look like this:
				# template6=("octavoHtml")
				# teplate6_name=("Webpage")

				# Get number of available formats

				# Iterate through them

				# When 'name' finds a match, return the 'format'

				:

			}



			function templateNumToPandocCommand () {


				debug "Function: templateNumToPandocCommand"

				# Ingore 'unbound' errors for the time being
				set +o nounset

				# Receives a template number, 0+
				# Pipes back the pandoc command to produce that
				# version
				pipedInput="$(cat)" # Capture input from Stdin
				number="$pipedInput"

				_template="$(echo "$number" | templateNumToTemplate)"
				# shellcheck disable=SC2034
				_name="$(echo "$number" | templateNumToName)"
				_format="$(echo "$number" | templateNumToFormat)"
				_executable="$(echo "$number" | templateNumToExecutable)"
				_templateExtension="$(echo "$number" | templateNumToExtension)"


				_arguments="$(echo "$number" | templateNumToArguments)"

				IFS=' ' read -r -a _filters <<< "$(echo "$number" | templateNumToFilters)" # break formats into array

				markdownSourceFileBasename="$(basename "$markdownSourceFile")"

				# shellcheck disable=SC2086
				filenameSourceFile="${markdownSourceFileBasename%.*}" # trim extension

				# shellcheck disable=SC2154
				if [[ "${mdfivehashset}" == "true" ]]; then
					filenameSourceFile+="_$mdFiveHashOutput"
				fi

				name="$(echo "$number" | templateNumToTemplate)"

				# Build up deployment command

				filenameSourceFile="$filenameSourceFile$name"
				deployAction="$_executable "

				# shellcheck disable=SC2124
				if [ -z "${_filters[0]+x}" ]; then : ; else deployAction+="${_filters[@]} "; fi
				deployAction+="--template=\"$octavoPath/templates/$_template$_templateExtension\" "
				deployAction+="$_arguments "
				# deployAction+="--verbose "
				deployAction+="-o "
				deployAction+="$localStagingDir/$filenameSourceFile.$_format"

				
			if [[ "$PANDOC_VERBOSE" == true ]]; then

				deployAction+=" --verbose"

			fi


				debug "filters are ${_filters[*]}"
				debug "deployAction is $deployAction"
				echo "$deployAction"

			}

			pandocDeploy() {

				debug "Function: pandocDeploy"


				# Receives:
				# A single line of true/false statements that correspond to
				# the formats in .octavoConfig.yml. True means that the user
				# wishes to have that format produced

				pipedInput="$(cat)" # Capture multi-line input from Stdin

				echo "$pipedInput" | egrep --quiet "true" || 
				{ error "Requested formats not found"; exit 77 ;} 

				# shellcheck disable=SC2034
				IFS=' ' read -r -a deployFormatRequestedStatus <<< "$pipedInput" # put true/false request status for each available template into array

				for indexReq in "${!deployFormatRequestedStatus[@]}" # Loop through the available templates


				do


					if [[ "${deployFormatRequestedStatus[indexReq]}" == "true" ]]; then

						pandocCommand="$(echo "$indexReq" | templateNumToPandocCommand)"

						markdownSourceTemp="$markdownSourcePrepared"

						# shellcheck disable=SC2154
						markdownSourcePrepared="$(splice "$markdownSourceTemp" "<replace>version</replace>" "$version" "overwrite")"

						wordCount="$(wc -w <(echo "$markdownSourcePrepared") | sed 's/\/.*$//g' | sed 's/ //g')"
						markdownSourcePrepared="$(splice "$markdownSourcePrepared" "<replace>wordCount</replace>" "$wordCount" "overwrite")"

						templateName="$(echo "$indexReq" | templateNumToName)"
						# shellcheck disable=SC2086
						templateName="$(tr '[:lower:]' '[:upper:]' <<< ${templateName:0:1})${templateName:1}" # Uppercase initial character
						markdownSourcePrepared="$(splice "$markdownSourcePrepared" "<replace>documentFormat</replace>" "$templateName" "overwrite")"


						if [[ "$DUMMY_RUN" == true ]]; then

							if [[ "$pandocCommand" == *"SpokenMacOs"* ]]; then

								echo "$markdownSourcePrepared" | createSpokenVersion

								continue

							fi

							echo "Pandoc command (not executed) would be:"
							echo
							echo "$pandocCommand"
							echo

						else

							# shellcheck disable=SC2086
							if [[ "$markdownSourceFile" != "$(basename "$markdownSourceFile")" ]]; then cd "$(dirname $markdownSourceFile)"; fi

							if [[ "$pandocCommand" == *"SpokenMacOs"* ]]; then

								echo "$markdownSourcePrepared" | createSpokenVersion

							else

								# shellcheck disable=SC2116
								echo "$markdownSourcePrepared" | eval "$(echo "$pandocCommand")"

							fi

							if [[ "$markdownSourceFile" != "$(basename "$markdownSourceFile")" ]]; then cd "$__dir"; fi

						fi

					fi


				done

				# No more unbound errors expected
				set -o nounset

			}

			function printOutputIfAsked {

				# Echoes back finalised (ish) version of Markdown with
				# all changes made

				debug "Function: printOutputIfAsked"

				if [[ "${arg_o:?}" = "1" ]]; then
					echo "$markdownSourcePrepared"
				fi
			}

			function ftpUploadIfAsked {

				# If requested (in yaml) then upload via FTP

				debug "Function: ftpUploadIfAsked"

				# shellcheck disable=SC2154
				if [[ "$ftpdeploy" == "no" ]]; then

					:

				else


					# Begin FTP if required

					if [[ -a "$HOME/.netrc" ]] ; then

						cd "$localStagingDir"

						if [[ "$DUMMY_RUN" != true ]]; then

							ftp -i -v "$remoteserver" > "/dev/null" <<ENDOFCOMMANDS

							cd $remotedirectory
							mput *.*
							quit

ENDOFCOMMANDS
fi

else

	echo "Could not find ~/.netrc file for FTP session"


fi


	fi



}

function moveFilesFromStagingToDeployDir {

	debug "Function: moveFilesFromStagingToDeployDir"

	# Move files out of staging area to the directory
	# where the user requested they be put

	if [[ "$DUMMY_RUN" != true ]]; then

		cp -R "$localStagingDir/" "$deployto/" && rm -r "$localStagingDir"

	fi

}


# Check arguments

[[ "${arg_f:-}" ]]     || help      "Setting a filename with -f or --file is required"

debug "__i_am_main_script: ${__i_am_main_script}"
debug "__file: ${__file}"
debug "__dir: ${__dir}"
debug "__base: ${__base}"
debug "OSTYPE: ${OSTYPE}"

debug "arg_f: ${arg_f}"
# shellcheck disable=SC2154
debug "arg_c: ${arg_c}"
debug "arg_y: ${arg_y}"
# shellcheck disable=SC2154
debug "arg_v: ${arg_v}"
# shellcheck disable=SC2154
debug "arg_h: ${arg_h}"
# shellcheck disable=SC2154
debug "arg_b: ${arg_b}"
# shellcheck disable=SC2154
debug "arg_o: ${arg_o}"



### Command-line argument switches (like -d for debugmode, -h for showing helppage)
##############################################################################

# debug mode
if [[ "${arg_d:?}" = "1" ]]; then
	# set -o xtrace
	LOG_LEVEL="7"
	# Enable error backtracing
	trap '__b3bp_err_report "${FUNCNAME:-.}" ${LINENO}' ERR
else
	LOG_LEVEL="6"
fi

[[ "${LOG_LEVEL:-}" ]] || emergency "Cannot continue without LOG_LEVEL. "

# verbose mode
if [[ "${arg_v:?}" = "1" ]]; then
	set -o verbose
fi

# no color mode
if [[ "${arg_n:?}" = "1" ]]; then
	NO_COLOR="true"
fi

# help mode
if [[ "${arg_h:?}" = "1" ]]; then
	# Help exists with code 1
	help "Help using ${0}"
fi

# Do we have a source file?
if [ ! -f "${arg_f}" ]; then
	error "Specified Markdown source not found"
	exit 77
fi

# Is this a dummy run?
if [[ "${arg_u:?}" = "1" ]]; then
	DUMMY_RUN="true"
else
	DUMMY_RUN="false"
fi

# Ask pandoc to be verbose if requested
if [[ "${arg_p:?}" = "1" ]]; then
	PANDOC_VERBOSE="true"
else
	PANDOC_VERBOSE="false"
fi



debug "Setting markdownSourceFile"

declare -x markdownSourceFile="${arg_f}"

markdownSourceFileWithoutPath="$(basename "$markdownSourceFile")"
sourceFileBasename="${markdownSourceFileWithoutPath%.*}" 
debug "sourceFileBasename = $sourceFileBasename"
debug "markdownSourceFile = $markdownSourceFile"

# Ubuntu: mdFiveHashOutput="$(md5sum "$markdownSourceFile | awk '{print $1;}')"
mdFiveHashOutput="$(md5 -q "$markdownSourceFile")"


# Set the path to the Octavo directory, containing
# config file, templates, and so on

# If user has not specified a config file, use default location,
# which is the path to this script

if [[ "${arg_c:-}" ]]; then
	if [ ! -f "${arg_c}" ]; then
		error "Specified Octavo config file not found"
		exit 77
	fi

	declare -x octavoPath=${arg_c}

else
	declare -x octavoPath=${__dir}
fi	





######################################################################################
######################################################################################

#  MAIN

######################################################################################
######################################################################################

sourceOctavoConfig "$octavoPath/.octavoConfig.yml" # Set Bash variables from global yaml

sourceMarkdownFileYaml "$markdownSourceFile"       # Set Bash variables from Markdown source yaml

checkSet                                           # Verify variables are set appropriately


localStagingDir="$deployto/.$(randomString)"       # Set a local staging directory for deployed files

mkdir "$localStagingDir"                           # Create it

markdownSourcePrepared="$(markdownSourcePrepare)"  # Finalised Markdown for deployment

getRequestedDeployFormats | pandocDeploy           # Execute pandoc as necessary

printOutputIfAsked                                 # Maybe print finalised (ish) Markdown

ftpUploadIfAsked                                   # Maybe send files to web server

moveFilesFromStagingToDeployDir                    # Move files to final destination

