#!/bin/sh

echo "This basically works. Now to tighten it up."

echo

# Functions

help() {

echo "Help is being given"

}


defaults() {

echo "Showing all defaults"
echo
echo "YAML:"
echo
echo "The script:"
echo


}

# Source the octavoConfig.sh file
source "$HOME/.octavoConfig.sh"

# Temp file location
tempFileLocation="$TEMPDIRECTORY/.octavoNewTemp.markdown"

# Source the file containing default values
source "$HOME/.octavoNewDefaults.sh"

# Automatic defaults
metatitle=title
dateShellSafe=$(date +"%d %B, %Y")
filename="newOctavoArticle.markdown"
deployto="$(pwd)"

## Initial variable set up (these should be set from shell arguments)

skeleton="2resWorkshopBooklet.markdown"
remotedirectory="testDirectory"
ftpdeploy="no"
httpdestination="http://cccupsychology.com/deployIh/testDirectory/"
customfilterone="pandoc-csv2table"
customfiltertwo="pandoc-crossref"
customfilterthree="pandoc-citeproc"


## Read from command line

# cmdtest - print command line arguments
if [ -z "$1" ] 

then

	help

exit

fi

OPTIONS=(title metatitle author date version headimage headquote httpdestination remotedirectory deployto formats preview ftpdeploy spokendeploy refreshcalendar customfilterone customfiltertwo customfilterthree papersize tocdepth toc colorlinks boxlinks linespread numbersections bibliography citationstyle linkcitations solariseddarkon solariseddarkoff mdfivehashset redact tblPrefix eqnPrefix figPrefix autoEqnLabels)

OPTIONS+=(filename, deployto)

OPTIONS+=(skeleton)


while [ $# -gt 0 ]
do
	myArguments=("$1")
for a in ${OPTIONS[@]}
		do
			case $1 in
				--$a=*)
				declare "$a=${myArguments#*=}" # Set the variable
				;;
				-h|--help)
					help	
					exit
				;;
			-d|--defaults)
				defaults
				exit
			esac
		done
		    	shift
done



# Catch errors

# If ftpdeploy is yes, we must have a remote directory too


# Is the FTP set up? If so, we'll need to create a directory


if [[ $ftpdeploy == "yes" ]]; then

ftp -i -v $remoteserver  <<ENDOFCOMMANDS

        mkdir $remotedirectory
	quit

ENDOFCOMMANDS

fi

echo "Creating $filename in $(pwd) using skeleton $skeleton"

# Create the Yaml
echo "---" > "$tempFileLocation" 
echo "title: \""$title"\"" >> "$tempFileLocation"  
echo "title-meta: \""$metatitle"\"" >> "$tempFileLocation" 
echo "author: \""$author"\"" >> "$tempFileLocation" 
echo "date: \""$dateShellSafe"\"" >> "$tempFileLocation" 
echo "version: "$version"" >> "$tempFileLocation" 
echo "headimage: \""$headimage"\"" >> "$tempFileLocation" 
echo "headquote: \""$headquote"\"" >> "$tempFileLocation" 
echo "httpdestination: \""$httpdestination"\"" >> "$tempFileLocation" 
echo "remotedirectory: \""$remotedirectory"\"" >> "$tempFileLocation" 
echo "deployto: \""$deployto"\"" >> "$tempFileLocation" 
echo "formats: \""$formats"\"" >> "$tempFileLocation" 
echo "preview: \""$preview"\"" >> "$tempFileLocation" 
echo "ftpdeploy: \""$ftpdeploy"\"" >> "$tempFileLocation" 
echo "spokendeploy: \""$spokendeploy"\"" >> "$tempFileLocation" 
echo "refreshcalendar: \""$refreshcalendar"\"" >> "$tempFileLocation" 
echo "customfilterone: \""$customfilterone"\"" >> "$tempFileLocation" 
echo "customfiltertwo: \""$customfiltertwo"\"" >> "$tempFileLocation" 
echo "customfilterthree: \""$customfilterthree"\"" >> "$tempFileLocation" 
echo "papersize: "$papersize"" >> "$tempFileLocation" 
echo "toc-depth: "$tocdepth"" >> "$tempFileLocation" 
echo "toc: "$toc"" >> "$tempFileLocation" 
echo "colorlinks: "$colorlinks"" >> "$tempFileLocation" 
echo "boxlinks: "$boxlinks"" >> "$tempFileLocation" 
echo "linespread: \""$linespread"\"" >> "$tempFileLocation" 
echo "numbersections: \""$numbersections"\"" >> "$tempFileLocation" 
echo "bibliography: \""$bibliography"\"" >> "$tempFileLocation" 
echo "citation-style: \""$citationstyle"\"" >> "$tempFileLocation" 
echo "link-citations: "$linkcitations"" >> "$tempFileLocation" 
echo "solariseddarkon: "$solariseddarkon"" >> "$tempFileLocation" 
echo "solariseddarkoff: "$solariseddarkoff"" >> "$tempFileLocation" 
echo "mdfivehashset: \""$mdfivehashset"\"" >> "$tempFileLocation" 
echo "redact: \""$redact"\"" >> "$tempFileLocation" 
echo "tblPrefix: \""$tblPrefix"\"" >> "$tempFileLocation" 
echo "eqnPrefix: \""$eqnPrefix"\"" >> "$tempFileLocation" 
echo "figPrefix: \""$figPrefix"\"" >> "$tempFileLocation" 
echo "autoEqnLabels: "$autoEqnLabels"" >> "$tempFileLocation" 
echo ... >> "$tempFileLocation" 
echo "" >> "$tempFileLocation"

# Add the Yaml and skeleton together
cat "$tempFileLocation" "$skeletondir/$skeleton" >> "$TEMPDIRECTORY/.octavoNewFinished.markdown"

# Copy file to current working directory
cp "$TEMPDIRECTORY/.octavoNewFinished.markdown" "$(pwd)/$filename"

# Clean up
rm "$tempFileLocation"
rm "$TEMPDIRECTORY/.octavoNewFinished.markdown"
