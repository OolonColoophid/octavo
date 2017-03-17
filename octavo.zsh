#!/bin/zsh

#################################################################################################
#################################################################################################

# Octavo 

# Ian Hocking
# https://github.com/OolonColoophid/octavo

#################################################################################################
#################################################################################################

# Read Configuration Variables

if [ -n "${OCTAVOPATH+x}" ] # Has the path to the Octavo directory been set by the user?

then 

	source "$OCTAVOPATH/.octavoConfig.sh" || { echoCli "Fatal error: Could not source .octavoConfig.sh. Is \$OCTAVOPATH correct? It needs to point to the directory containing Octavo and its support files. This currently set to: $OCTAVOPATH" } # Source the global configuration file

elif [[ -a "$HOME/octavo" ]] # Not set, but does Octavo appear in the $HOME directory?

then

	export OCTAVOPATH="$HOME/octavo"

else # Path isn't set and doesn't exist in the home directory

	{ echoCli "Fatal error: Variable \$OCTAVOPATH has not been set. Make sure it is set in your .bash_profile. For example: export \$OCTAVOPATH=\"/foo/bar/octavo\"" ; exit 1 }

fi





# Functions

checkDependencies() # Exit if certain dependencies aren't met
{

	# Pandoc is needed
	command -v pandoc >/dev/null || { echoCli "Fatal error: I require Pandoc but it's not installed.See http://pandoc.org/installing.html."; exit 1; }

	# Latex is needed
	command -v kpsepath >/dev/null || { echoCli "Fatal error: I require a Latex distribution but it's not installed. See https://www.latex-project.org/get/ for general information or http://www.tug.org/texlive/quickinstall.html for a minimal Unix install recipe."; exit 1; }

# Pandoc-citeproc etc? See installUbuntu

}

cleanUp() # Delete temporary files 
{

	# Try to create a dir for the deployed files
	mkdir -p "$deployto/archive"

	# Move the deployed files to the archive
	mv "$deployto"/*.* "$deployto/archive"

	# Finally, delete all intermediate files
	rm -r $octavoTempDirectory && { echoLog "Deleted temporary directory $octavoTempDirectory" }	
}


setBashVarsFromYaml() # Read YAML block at top of Markdown file and create shell variable equivalents; and store them to disk
{

	scriptName=setBashVarsFromYaml_func

	touch "$octavoTempDirectory/envVariableTemp"

	inYamlZone="0"

	while IFS= read -r line # IFS method maintains white space

	do

		if [[ $inYamlZone == "1" ]] # Are we in a YAML block?

		then
			if [[ $line != "$yamlEndMarker" ]] # Make sure this isn't the YAML end marker

			then

				IFS=': ' read -r varKey varValue <<< "$line"

				if [[ $varKey != *"-"* ]] 

				then	


					if [[ "$varKey" == "" ]]; then echoCli "setBashVarsFromYaml: Yaml error. Is there an illegal blank line in the Yaml?"; cleanUp > /dev/null 2>&1 ; exit 1; fi



					# varValueTrimmed="${varValue//\"//}"

					varValueTrimmed=$(echo "$varValue" | sed 's/\"//g')
					declare ${varKey}="$varValueTrimmed"

					declare -p ${varKey} >> "$octavoTempDirectory/envVariableTemp"


				fi

			fi

		fi

		lineCount=$((lineCount + 1))

		if [[ $line == "$yamlBeginMarker" ]] # Are we entering the YAML block? 

		then

			inYamlZone="1"

		fi

		if [[ $line == $yamlEndMarker* ]] # Are we exiting the YAML block?

		then

			inYamlZone="0"

			break
		fi

	done < "${1:-/dev/stdin}" # This means read from Standard Input
}


preProcessMarkdownVariables() 
{

	scriptName=preProcessMarkdownVariables

	echoLog "preProcessMarkdownVariables called"

	# Source the variables that were in the Markdown's YAML
	# shellcheck source=/Users/ianuser/Dropbox/.temp/envVariableTemp
	source "$octavoTempDirectory/envVariableTemp"

	# Set defaults
	preTempFileStepOne="$octavoTempDirectory/preProcessedOne" ## Temporary output
	preTempFileStepTwo="$octavoTempDirectory/preProcessedTwo.markdown" ## Temporary output

	touch "$preTempFileStepOne"
	touch "$preTempFileStepTwo"

	# To deal with raw latex, lines of which begin with a backslash
	# we need to temporarily replace these with an unusual character
	# like ☖
	cat "$markdownSourceFile" > "$preTempFileStepOne" || echoCli "Cat alpha failed"
	sed -i.bak 's/\\/☖/g' "$preTempFileStepOne" && echoLog "Sed replaced a backslash with a safe character"

	while IFS= read -r line 

	do

		if [[ $line == *$includeMarkerString* ]] # Does the current line contain the replacement marker?

		then

			includeFile=$(echo "$line" | awk '{print $2}') # Get filename

			echoLog "Found text to substitute called $includeFile"

			includeResult=$(echo $includedir/$includeFile.markdown) # Add path to filename

			echoLog "Attempting to splice in $includeResult, adding to $preTempFileStepTwo"

			cat "$includeResult" >> "$preTempFileStepTwo" || echoCli "Cat Charlie failed"

		else

			echo "$line" >> "$preTempFileStepTwo"

		fi

	done < "$preTempFileStepOne"


	# Revert any backslashes to backslashes, to help
	# raw latex work

	sed -i.bak 's/☖/\\/g' "$preTempFileStepTwo" && echoLog "Sed replaced a safe character with a backslash"

	cat "$preTempFileStepTwo" || echoCli "Cat delta failed" # Cat the finished, expanded text file to Standard Output
}



echoLog() { # This function notes things in a log directory

	# Usage:
	# echoLog [text] 
	now=$(date +"%A %T")

	if [[ $1 = *[!\ ]* ]] # Function has been passed text

	then

		echo "$now: $1" >> "$logFile"

	else

		echo " " >> "$logFile"
	fi

}

echoCli() { # This function notes things in a log directory

	# Usage:
	# echoCli [text] 
	if [[ $1 = *[!\ ]* ]] # Function has been passed text

	then

		cliText="$1"

	else

		cliText=" "

	fi

	if [[ $suppressmessages != "yes" ]] # If suppressmessages set, keep quiet

	then
		echo $cliText

	fi

}


# contains(string, substring)
#
# Returns 0 if the specified string contains the specified substring,
# otherwise returns 1.
# (This function from http://stackoverflow.com/questions/2829613/how-do-you-tell-if-a-string-contains-another-string-in-unix-shell-scripting)



contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}


#############################
# Main routine begins
#############################


# Check certain critical dependencies

checkDependencies

# export suppressmessages="yes"

# Verify that the script has received a text file

if [[ $1 = *[!\ ]* ]]; then

	# All good; carry on
	: 

else
	echoCli "Fatal error: You need to specify the Markdown source file."
	cleanUp > /dev/null 2>&1 
	exit 1
fi

logFile="$HOME/.octavo.log"

# What platform?

systemInfo=$(uname -a)

contains $systemInfo "Ubuntu" && platform="Ubuntu"
contains $systemInfo "Darwin" && platform="Mac"
 


# Set temp directory
if [[ $platform == "Mac" ]]

then

octavoTempDirectory="$TMPDIR/`md5 -q $1`$RANDOM"
mdFiveHash=$(md5 -q $1)


else

octavoTempDirectory="/var/tmp/`md5sum $1 | awk '{print $1;}'`$RANDOM"
mdFiveHash=$(md5sum $1)

fi 
 

# Create this new directory
mkdir $octavoTempDirectory || { rm -r $octavoTempDirectory ; mkdir $octavoTempDirectory }

# Define simple variables
tempWorkingFile="$octavoTempDirectory/deployTempFile.markdown"

counter=0

# Define arrays
declare -a deployShortCode
declare -a deployDescription
declare -a appCommand
declare -a deployExtension

# Give current script a label for the log
scriptName=deploy.zsh


# Opening statement for the command line

	echoCli "" 
	echoCli "---------------------------------------"
	echoCli "This is Octavo saying 'To me'"
	echoCli "---------------------------------------"
	echoCli ""

echoLog
echoLog
echoLog "--------------------"
echoLog "Beginning deployment"
echoLog "--------------------"

#####################################################################################

markdownSourceFile=$1 # Name of the current document (presumably a Markdown file)

#####################################################################################

# Set variables from $1

basenameSourceFile=$(echo $markdownSourceFile | sed 's/.markdown//g')
touch "$tempWorkingFile" # Create our temp file if it doesn't already exist

#####################################################################################
#####################################################################################

# 1. Process YAML

echoLog "1. Process YAML: Launching setBashVarsFromYaml"

# Pass file to be processed to the function that gets variables from the Yaml block
# at the head of the markdown file (sed command substitutes $HOME for the shell
# variable contents of $HOME, as well as $OCTAVOPATH for directory where Octavo lives)
cat $markdownSourceFile | sed "s@\$HOME@$HOME@g" | sed "s@\$OCTAVOPATH@$OCTAVOPATH@g" | setBashVarsFromYaml 

# At this point, variables specified in the YAML of the
# markdown file and are stored in file $octavoTempDirectory/envVariableTemp

# Let's get those variables
source "$octavoTempDirectory/envVariableTemp"

# Does the user want all formats?
if [[ $formats == "all" ]]; then

	formats="octavoTuftePdf, octavoNormalPdf, octavoTufteSolarisedPdf, octavoOpenDyslexic, octavoLargePdf, octavoDocx, octavoHtml, octavoSpoken"

fi


# Does the user want numbered sections?
if [[ $numbersections == "yes" ]]; then

	numberSections="--number-sections"

fi

# Tell the user where the deployed files will end up
echoCli "Deploying to $deployto" 


# If there is a Yaml variable called 'refreshcalendar' and it is set to yes
# run the updateTimeTablesFromiCal.zsh script to generate markdown tables
# based on particular calendar searches (for lists of lectures, seminars
# and assessment deadlines)



if [[ $refreshcalendar == "yes" ]]; then

	echoCli "Refreshing calendar"

	updateTimeTablesFromiCal.zsh # This script must be in your $PATH

fi

#####################################################################################
#####################################################################################

# 2. Preprocess Markdown

echoLog "2. Preprocess Markdown: Launching preProcessMarkdownVariables"

# The following script does basic substitution of text in the markdown file.
# Useful for contact details, and so on. (sed command substitutes $HOME for the shell
# variable contents of $HOME)

cat "$markdownSourceFile" | sed "s@\$HOME@$HOME@g" | sed "s@\$OCTAVOPATH@$OCTAVOPATH@g" | preProcessMarkdownVariables > "$tempWorkingFile" || echoCli "preProcessMarkdownVariables reported an error" 


# If a Yaml variable called 'spokendeploy' has value 'no' then
# suppress the spoken word version

if [[ $spokendeploy == "no" ]]; then

	formats=$(echo $formats | sed 's/, octavoSpoken//g')
	# formats=${formats//, octavoSpoken//}

	echoCli "(Suppressing spoken word version)"

fi



httpDestination="$httpdestination" # Remote web-accessible path
remoteServer="$remoteserver" # Remote server name, eg. cccupsychology.com
ftpDeploy="$ftpdeploy" # Yes to deploy via FTP, no to surpress
spokendeploy="$spokendeploy" # Yes for spoken word version, not to suppress
formatsTrimmed=$(echo $formats | sed 's/,//g') # Trim out commas, leaving space delimiters, tidier for processing
deployFormat=(${=formatsTrimmed}) # Make an array

deployConfig=$deployconfig # The user can specify their own config file in the Yaml
deployFormatNumber=${#deployFormat[*]} # Get the number of deploy formats requested
# Tweak 'version' variable from Yaml so that it is safe to use for filenames
# version=$(echo $version | sed 's/\./_/g')


echoLog "deployFormatNumber is $deployFormatNumber"


counter=0 # Reset counter

while [[ $counter < $deployFormatNumber ]] # Step through each deploy format

do
	counter=$((counter+1))

	# Find that format, capture (from the config file) ShortCode,
	# Description and Command
	deployShortCode[$counter]=$(cat "$deployConfig" | egrep $deployFormat[$counter] | awk -F, '{print $1}')

	# The 'sed' in the following trims out the " characters, 
	# leading space character and ending space characters
	deployDescription[$counter]=$(cat "$deployConfig" | egrep  $deployFormat[$counter] | awk -F, '{print $2}' | sed 's/"//g' | sed 's/^ //g' | sed 's/ $//g') 	
	appCommand[$counter]=$(cat $deployConfig | egrep $deployFormat[$counter] | awk -F, '{print $3}')

	deployExtension[$counter]=$(cat "$deployConfig" | egrep $deployFormat[$counter] | awk -F, '{print $4}')

done


if [[ $mdfivehashset = "yes" ]]

then 

	mdFive=$mdFiveHash

else

	mdFive=""

fi


echoCli "MD5: $mdFiveHash"

# Now we should generate the text that tells the reader about
# alternative versions

counter=0 # Reset our counter

while [[ $counter < $deployFormatNumber ]]

do
	counter=$((counter+1))

	conjunction=", "

	if [[ $counter == $((deployFormatNumber-1)) ]]; then

		conjunction=" and "
	fi

	deploymentTextBody="$deploymentTextBody"["$deployDescription[$counter]"]"($httpDestination$basenameSourceFile$element$deployShortCode[$counter]$mdFive$deployExtension[$counter])$conjunction"

done

deploymentTextBody=$(echo $deploymentTextBody | sed 's/\, $//g') # Trim the trailing comma
deploymentTextAll="$deploymentTextHead $deploymentTextBody. $deploymentTextFoot" # Put it all together

# The following is a really fun bit where
# I'm santising the string I pass to sed 
# so that when the shell expands it, all
# the sed wildcards are escaped

# start with the original pattern
escaped="$deploymentTextAll"
# escape all backslashes first
escaped="${escaped//\\/\\\\}"
# escape slashes
escaped="${escaped//\//\\/}"
# escape asterisks
escaped="${escaped//\*/\\*}"
# escape full stops
escaped="${escaped//./\\.}"    
# escape [ and ]
escaped="${escaped//\[/\\[}"
escaped="${escaped//\]/\\]}"
# escape ^ and $
escaped="${escaped//^/\\^}"
escaped="${escaped//\$/\\\$}"
# remove newlines
escaped="${escaped//[$'\n']/}"
# Now, "$escape" should be safe as part of a normal sed pattern.
# Note that it is NOT safe if the -r option is used.

sed -i.bak "s%& deployments &%$escaped%g" $tempWorkingFile || echoCli "SED not happy" # Insert finalised 'deployments' string

# Let's also update the version as displayed in
# in the document

sed -i.bak "s%& version &%$version%g" "$tempWorkingFile" || echoCli "SED grumpy"

#####################################################################################

# Go through the file and execute any in-place
# commands that want to output their text into
# the document

tempSubworkingFileOne=$(echo $octavoTempDirectory/deployTempSubFileOne.markdown) # Create a new temp file (1)

tempSubworkingFileTwo=$(echo $octavoTempDirectory/deployTempSubFileTwo.markdown) # Create a new temp file (2)



echo "" > "$tempSubworkingFileOne"
echo "" > "$tempSubworkingFileTwo"

cat "$tempWorkingFile" > "$tempSubworkingFileOne" || echoCli "Cat Foxtrot failed"


touch "$tempSubworkingFileOne"
touch "$tempSubworkingFileTwo"

sed -i.bak 's/\\/☖/g' $tempSubworkingFileOne && echoLog "Sed replaced a backslash with a safe character"
echoLog "Attempting command substitution in file called $tempSubworkingFileOne"

while IFS= read -r line 

do

	if [[ $line == *cmd* ]]

	then


		commandToRun=$(echo $line | egrep -o "&cmd.*cmd&" | sed "s/&cmd//g" | sed "s/cmd&//g")
		commandOutput=$(eval "$commandToRun")
		newLine=$(echo $line | sed "s@&cmd.*cmd&@$commandOutput@g")

		echo "$newLine" >> "$tempSubworkingFileTwo"

	else
		echo "$line" >> "$tempSubworkingFileTwo"
	fi
done < "$tempSubworkingFileOne"


# Revert any backslashes to backslashes, to help
# raw latex work

sed -i.bak 's/☖/\\/g' "$tempSubworkingFileTwo" && echoLog "Sed replaced safe characters with backslash"


cat "$tempSubworkingFileTwo" | sed "s@\$HOME@$HOME@g" | sed "s@\$OCTAVOPATH@$OCTAVOPATH@g" > "$tempWorkingFile"

if [[ $redact = "yes" ]]

then 

	customfilterfour="filterRedactions.py"

else

	:

fi


######################################################################################
######################################################################################

# 3. Pandoc

# Check whether custom filters have been requested in YAML
# If so, format them nicley for Pandoc
if [[ $customfilterone != "" ]]; then customfilterone="--filter=$customfilterone"; fi
if [[ $customfiltertwo != "" ]]; then customfiltertwo="--filter=$customfiltertwo"; fi
if [[ $customfilterthree != "" ]]; then customfilterthree="--filter=$customfilterthree"; fi
if [[ $customfilterfour != "" ]]; then customfilterfour="--filter=$customfilterfour"; fi

counter=0 # Reset the counter

while [[ $counter < $deployFormatNumber ]]


do
	counter=$((counter+1))

	element=$deployShortCode[$counter]

	echoLog "Creating version in $element..."
	echoCli "Creating version in $element..."

	if [[ $element == *octavoSpoken* ]] 

	then
		makeSpoken="yep"
		spokenCommandWithArgs="$appCommand[$counter]"
		spokenExtension="$deployExtension[$counter]"
		spokenFormat="$element"


	else

		if [[ $deployExtension[$counter] == *docx ]] 
		then	
			# Replace div tags with something that makes more
			# sense to Word: headers! 

			cat "$tempWorkingFile" \
				| sed 's/<div*.*highlight.*/## Remember/g' \
				| sed 's/<div*.*task.*/## Task/g' \
				| sed 's/<div*.*journal.*/## Journal/g' \
				| sed 's/<div*.*answer.*/## Answer/g' \
				| sed 's/<\/div>//g' > "$octavoTempDirectory/WorkingFileCleanedOfLatexBlocksForDocx.markdown"

			eval "cat "$octavoTempDirectory/WorkingFileCleanedOfLatexBlocksForDocx.markdown" | $appCommand[$counter]" && if [[ "$preview" == *"$element"* ]]; then open "$deployto/$basenameSourceFile$element$mdFive$deployExtension[$counter]"; fi || echoCli Failed comm was "$appCommand[$counter]" 


		elif [[ $deployExtension[$counter] == *pdf ]]
		then

			cat $tempWorkingFile | eval $appCommand[$counter] && if [[ "$preview" == *"$element"* ]]; then open "$deployto/$basenameSourceFile$element$mdFive$deployExtension[$counter]"; fi


		elif [[ $deployExtension[$counter] = *html ]]
		then

			eval "cat "$tempWorkingFile" | $appCommand[$counter]" && if [[ "$preview" == *"$element"* ]]; then open "$deployto/$basenameSourceFile$element$mdFive$deployExtension[$counter]"; fi || echoCli Failed comm was "$appCommand[$counter]" 


		else
			eval "cat $tempWorkingFile | $appCommand[$counter]" && if [[ "$preview" == *"$element"* ]]; then open "$deployto/$basenameSourceFile$element$mdFive$deployExtension[$counter]"; fi || echoCli Failed comm was "$appCommand[$counter]" 

		fi	
	fi

done

# Does the user want a spoken version? Try to give
# 'say' a clean bit of text to work with

if [[ $makeSpoken == *yep* ]] 

then

	echoCli "Creating spoken version..."

	echoCli "$title-meta by $author" > "$octavoTempDirectory/spokenIntro"
	echoCli "End of document $title-meta by $author" > "$octavoTempDirectory/spokenOutro"

	eval "cat '$octavoTempDirectory/spokenIntro' '$tempWorkingFile' '$octavoTempDirectory/spokenOutro' | $spokenCommandWithArgs" && if [[ "$preview" == *"$element"* ]]; then open "$deployto/$basenameSourceFile$element$deployExtension[$counter]"; fi || echoCli Failed comm was "$appCommand[$counter]"


	fileSizeKb=`du -k "$deployto/$basenameSourceFile$element$mdFiveHash$deployExtension[$counter]" | cut -f1`	

	echoCli "Spoken file is $fileSizeKb KB"

fi



# Render a special plain text version?

# Render the spoken version based on that plain text
# octavoSpoken, "spoken word", say --voice='Alex' --quality=127 --file-format='mp4f' -f /$tempWorkingFile -o "$deployto/$basenameSourceFile$element.mp4",.mp4


# Upload to FTP server - if this is request in the Yaml
if [[ $ftpDeploy == "yes" ]]; then

	cd "$deployto" || exit

	#	if [[ $deployPurgeOlderThan != "0" ]]; then
	#
	#		echoLog "Looking to clean up files older than $deployPurgeOlderThan days"
	#		find . -mtime +"$deployPurgeOlderThan" -exec rm {} \; || echoLog "Attempt to delete files exited with error" 
	#
	#	fi


	echoLog "Upoading all files to FTP..."

	echoCli "FTP is uploading to $httpDestination..."

	# The most important command is put <source> <destination>
	# The below should use the login credentials in a file called
	# '.netrc' which needs to be in the user directory
	# Note that the following block has nonstandard indentation;
	# when indented properly, this scripts failw with a parse error
	# possibly caused by ENDOFCOMMANDS not being flush left. Go figure

	ftp -i -v $remoteServer &> "$logPath"  <<ENDOFCOMMANDS

	cd $remotedirectory
	mput *.*
	quit

ENDOFCOMMANDS

else
	echoCli "Suppressing FTP upload"


fi

# Clean up

cleanUp > /dev/null 2>&1 

echoLog
echoLog "-----------------------"
echoLog "Octavo deployment ended"
echoLog "-----------------------"
echoLog

echoCli "Octavo made a successful run." > "$OCTAVOPATH/.octavoLastRunStatus"

echoCli "" 
echoCli "---------------------------------------"
echoCli "This is Octavo saying 'To you'"
echoCli "---------------------------------------"
echoCli ""

echoCli "Execution time"
times


