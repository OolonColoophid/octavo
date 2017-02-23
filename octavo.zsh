#!/bin/zsh

# This script 'deploys', or publishes, finalised
# documents based on a markdown source file

###############################################################

# Variables

# shellcheck source=/Users/ianuser/.octavoConfig.sh
source "$HOME/.octavoConfig.sh" || echo "Could not source .octavoConfig.sh, which should be in the home directory" # Source the global configuration file





# Functions

cleanUp() # Delete temporary files (fail silently)
{

	# Try to create a dir for the deployed files
        mkdir -p "$deployto/archive"

	# Move the deployed files to the archive
        mv "$deployto"/*.* "$deployto/archive"

	# Finally, delete all intermediate files
	rm -r $octavoTempDirectory	
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


				if [[ "$varKey" == "" ]]; then echo "setBashVarsFromYaml: Yaml error. Is there an illegal blank line in the Yaml?"; cleanUp > /dev/null 2>&1 ; exit 1; fi

				
				
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

	logThis scriptName "preProcessMarkdownVariables called"

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
	cat "$markdownSourceFile" > "$preTempFileStepOne" || echo "Cat alpha failed"
	sed -i.bak 's/\\/☖/g' "$preTempFileStepOne" && logThis $scriptName "Sed replaced a backslash with a safe character"

	while IFS= read -r line 

do

	if [[ $line == *$includeMarkerString* ]] # Does the current line contain the replacement marker?

	then

		includeFile=$(echo "$line" | awk '{print $2}') # Get filename

		logThis $scriptName "Found text to substitute called $includeFile"

		includeResult=$(echo $includedir/$includeFile.markdown) # Add path to filename

		logThis $scriptName "Attempting to splice in $includeResult, adding to $preTempFileStepTwo"

		cat "$includeResult" >> "$preTempFileStepTwo" || echo "Cat Charlie failed"

	else

		echo "$line" >> "$preTempFileStepTwo"

	fi

done < "$preTempFileStepOne"


# Revert any backslashes to backslashes, to help
# raw latex work

sed -i.bak 's/☖/\\/g' "$preTempFileStepTwo" && logThis "$scriptName" "Sed replaced a safe character with a backslash"

cat "$preTempFileStepTwo" || echo "Cat delta failed" # Cat the finished, expanded text file to Standard Output
}



logThis() { # This function notes things in a log directory

	# Usage:
	# logThis "scriptName" ["Message"]
	now=$(date +"%A %T")

	if [[ $2 = *[!\ ]* ]] # Function has been passed a message

	then

		echo "$1 ($HOST) -- on $now: $2" >> "$LOGFILE"

	else

		echo "$1 ($HOST) -- on $now: Just saying hello" >> "$LOGFILE"
	fi

}





#############################
# Main routine begins
#############################

# Verify that the script has received a text file

if [[ $1 = *[!\ ]* ]]; then

	# All good; carry on
	: 

else
	echo "Fatal error: You need to specify the Markdown source file."
	cleanUp > /dev/null 2>&1 
	exit 1
fi


if [ -n "${TEMPDIRECTORY+1}" ]; then # Is the environment variable TEMPDIRECTORY set?

	:

else

	echo "Environment variable TEMPDIRECTORY, which is a path to a"
	echo "temporary directory, must be set. I'd suggest adding this"
	echo "to your ~/.bash_profile, like this:"
	echo
	echo '"export TEMPDIRECTORY="$HOME/Dropbox/.temp"'
	cleanUp > /dev/null 2>&1 
	exit 1

fi

# Specify a unique directory within the $TEMPDIRECTORY
# path, so that multiple instances of Octavo won't conflict
octavoTempDirectory="$TEMPDIRECTORY/`md5 -q $1`"

# Create this new directory
mkdir $octavoTempDirectory || exit 1

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


if [[ $suppressmessages != "yes" ]]

then
	echo "" 
	echo "---------------------------------------"
	echo "This is Octavo saying 'To me'"
	echo "---------------------------------------"
	echo ""

fi

logThis $scriptName "Beginning deployment"

#####################################################################################

markdownSourceFile=$1 # Name of the current document (presumably a Markdown file)

#####################################################################################

# Set variables from $1

basenameSourceFile=$(echo $markdownSourceFile | sed 's/.markdown//g')
touch "$tempWorkingFile" # Create our temp file if it doesn't already exist

#####################################################################################
#####################################################################################

# 1. Process YAML

logThis $scriptName "1. Process YAML: Launching setBashVarsFromYaml"

# Pass file to be processed to the function that gets variables from the Yaml block
# at the head of the markdown file (sed command substitutes $HOME for the shell
# variable contents of $HOME)
cat $markdownSourceFile | sed "s@\$HOME@$HOME@g" | setBashVarsFromYaml || echo setBashVarsFromYaml reported an error 

# At this point, variables specified in the YAML of the
# markdown file and are stored in file $octavoTempDirectory/envVariableTemp

# Let's get those variables
source "$octavoTempDirectory/envVariableTemp"

# Does the user want all formats?
if [[ $formats == "all" ]]; then

	formats="octavoTuftePdf, octavoNormalPdf, octavoTufteSolarisedPdf, octavoOpenDyslexic, octavoLargePdf, octavoHtml, octavoSpoken"

fi


# Does the user want numbered sections?
if [[ $numbersections == "yes" ]]; then

	numberSections="--number-sections"

fi

# Tell the user where the deployed files will end up
if [[ $suppressmessages != "yes" ]]; then 
	
	echo "Deploying to $deployto"; 

fi


# If there is a Yaml variable called 'refreshcalendar' and it is set to yes
# run the updateTimeTablesFromiCal.zsh script to generate markdown tables
# based on particular calendar searches (for lists of lectures, seminars
# and assessment deadlines)



if [[ $refreshcalendar == "yes" ]]; then

	if [[ $suppressmessages != "yes" ]]; then echo "Refreshing calendar"; fi

	updateTimeTablesFromiCal.zsh # This script must be in your $PATH

fi

#####################################################################################
#####################################################################################

# 2. Preprocess Markdown

logThis $scriptName "2. Preprocess Markdown: Launching preProcessMarkdownVariables"

# The following script does basic substitution of text in the markdown file.
# Useful for contact details, and so on. (sed command substitutes $HOME for the shell
# variable contents of $HOME)

cat "$markdownSourceFile" | sed "s@\$HOME@$HOME@g" | preProcessMarkdownVariables > "$tempWorkingFile" || echo "preProcessMarkdownVariables reported an error" 


# If a Yaml variable called 'spokendeploy' has value 'no' then
# suppress the spoken word version

if [[ $spokendeploy == "no" ]]; then

	formats=$(echo $formats | sed 's/, octavoSpoken//g')
	# formats=${formats//, octavoSpoken//}

	if [[ $suppressmessages != "yes" ]]; then echo "(Suppressing spoken word version)"; fi

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


logThis $scriptName "deployFormatNumber is $deployFormatNumber"


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

	mdFive=$(md5 -q $tempWorkingFile)

else

	mdFive=""

fi



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

sed -i.bak "s%& deployments &%$escaped%g" $tempWorkingFile || echo SED not happy # Insert finalised 'deployments' string

# Let's also update the version as displayed in
# in the document

sed -i.bak "s%& version &%$version%g" "$tempWorkingFile" || echo SED grumpy

#####################################################################################

# Go through the file and execute any in-place
# commands that want to output their text into
# the document

tempSubworkingFileOne=$(echo $octavoTempDirectory/deployTempSubFileOne.markdown) # Create a new temp file (1)

tempSubworkingFileTwo=$(echo $octavoTempDirectory/deployTempSubFileTwo.markdown) # Create a new temp file (2)



echo "" > "$tempSubworkingFileOne"
echo "" > "$tempSubworkingFileTwo"

cat "$tempWorkingFile" > "$tempSubworkingFileOne" || echo "Cat Foxtrot failed"


touch "$tempSubworkingFileOne"
touch "$tempSubworkingFileTwo"

sed -i.bak 's/\\/☖/g' $tempSubworkingFileOne && logThis $scriptName "Sed replaced a backslash with a safe character"
logThis $scriptName "Attempting command substitution in file called $tempSubworkingFileOne"

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

sed -i.bak 's/☖/\\/g' "$tempSubworkingFileTwo" && logThis $scriptName "Sed replaced safe characters with backslash"


cat "$tempSubworkingFileTwo" | sed "s@\$HOME@$HOME@g" > "$tempWorkingFile"

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

	logThis $scriptName "Creating $element..."
	if [[ $suppressmessages != "yes" ]]; then echo "Creating $element..."; fi

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

			eval "cat "$octavoTempDirectory/WorkingFileCleanedOfLatexBlocksForDocx.markdown" | $appCommand[$counter]" && if [[ "$preview" == *"$element"* ]]; then open "$deployto/$basenameSourceFile$element$mdFive$deployExtension[$counter]"; fi || echo Failed comm was "$appCommand[$counter]" 

		elif [[ $deployExtension[$counter] == *pdf ]]
		then

			cat $tempWorkingFile | eval $appCommand[$counter] && if [[ "$preview" == *"$element"* ]]; then open "$deployto/$basenameSourceFile$element$mdFive$deployExtension[$counter]"; fi 

		elif [[ $deployExtension[$counter] = *html ]]
		then

			eval "cat "$tempWorkingFile" | $appCommand[$counter]" && if [[ "$preview" == *"$element"* ]]; then open "$deployto/$basenameSourceFile$element$mdFive$deployExtension[$counter]"; fi || echo Failed comm was "$appCommand[$counter]" 

		else
			eval "cat $tempWorkingFile | $appCommand[$counter]" && if [[ "$preview" == *"$element"* ]]; then open "$deployto/$basenameSourceFile$element$mdFive$deployExtension[$counter]"; fi || echo Failed comm was "$appCommand[$counter]" 
		fi	
	fi

done

# Does the user want a spoken version? Try to give
# 'say' a clean bit of text to work with

if [[ $makeSpoken == *yep* ]] 

then

	if [[ $suppressmessages != "yes" ]]; then echo "Creating spoken version" ; fi
	
echo "$title-meta by $author" > "$octavoTempDirectory/spokenIntro"
echo "End of document $title-meta by $author" > "$octavoTempDirectory/spokenOutro"
	
	
	eval "cat '$octavoTempDirectory/spokenIntro' '$tempWorkingFile' '$octavoTempDirectory/spokenOutro' | $spokenCommandWithArgs" && if [[ "$preview" == *"$element"* ]]; then open "$deployto/$basenameSourceFile$element$deployExtension[$counter]"; fi || echo Failed comm was "$appCommand[$counter]"

fi



	# Render a special plain text version?

	# Render the spoken version based on that plain text
	# octavoSpoken, "spoken word", say --voice='Alex' --quality=127 --file-format='mp4f' -f /$tempWorkingFile -o "$deployto/$basenameSourceFile$element.mp4",.mp4


# Upload to FTP server - if this is request in the Yaml
if [[ $ftpDeploy == "yes" ]]; then

	cd "$deployto" || exit

#	if [[ $deployPurgeOlderThan != "0" ]]; then
#
#		logThis $scriptName "Looking to clean up files older than $deployPurgeOlderThan days"
#		find . -mtime +"$deployPurgeOlderThan" -exec rm {} \; || logThis $scriptname "Attempt to delete files exited with error" 
#
#	fi


	logThis $scriptName "Upoading all files to FTP..."

	if [[ $suppressmessages != "yes" ]]; then echo "FTP is uploading to $httpDestination..."; fi

	# The most important command is put <source> <destination>
	# The below should use the login credentials in a file called
	# '.netrc' which needs to be in the user directory
	# Note that the following block has nonstandard indentation;
	# when indented properly, this scripts failw with a parse error
	# possibly caused by ENDOFCOMMANDS not being flush left. Go figure

ftp -i -v $remoteServer &> "$HOME/Dropbox/.logThis/log"  <<ENDOFCOMMANDS

        cd $remotedirectory
	mput *.*
	quit

ENDOFCOMMANDS

else
	if [[ $suppressmessages != "yes" ]]; then echo \(Suppressing FTP upload\); fi

fi

# Clean up

cleanUp > /dev/null 2>&1 

logThis $scriptName "Octavo deployment ended"

echo "Octavo made a successful run." > "$HOME/.octavoLastRunStatus"

if [[ $suppressmessages != "yes" ]]

then

	echo "" 
	echo "---------------------------------------"
	echo "This is Octavo saying 'To you'"
	echo "---------------------------------------"
	echo ""

	echo "Execution time"
	times

fi






