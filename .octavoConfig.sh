#!/bin/sh

#################################################################################################
#################################################################################################

# Configuration file for Octavo

# You could change the settings below

#################################################################################################
#################################################################################################

export LOGPATH="$HOME/.logThis" # Octavo log file path
mkdir -p "$LOGPATH" # Will be created if it doesn't exist

export LOGFILE="$LOGPATH/log"

# Deployment text for the document, telling the reader about
# other versions
export deploymentTextHead="This document is available in"
export deploymentTextBody=""
export deploymentTextFoot="This document contains hyperlinks to [sections within it](#overview), [external webpages](http://cccupsychology.com), and email addresses like [ian.hocking@canterbury.ac.uk](mailto:ian.hocking@canterbury.ac.uk)."





#################################################################################################
#################################################################################################

# You probably don't need to change the setting below right now

#################################################################################################
#################################################################################################

## Behaviour
export suppressmessages="no"
### Note that a variable called TEMPDIRECTORY specifying your favourite temporary
### directory should be specified

## Location of skeleton files for creation of new Octavo documents
export skeletondir="$OCTAVOPATH/skeletons"

## Document settings (these can be overriden in the Yaml)
## Note: Some variables must be set in the Yaml itself
## in order to be available to Pandoc and filters
export crossrefYaml="$OCTAVOPATH/includes/pandoc-crossrefSettings.yaml"
export includedir="$OCTAVOPATH/includes"
export templatedir="$OCTAVOPATH/templates"
export deployconfig="$OCTAVOPATH/deployConfig"
export remoteserver="cccupsychology.com"

## YAML processing
export yamlBeginMarker="---" ## Where does the YAML block start?
export yamlEndMarker="..." ## Where does it end?

## Preprocessing
export extension="markdown" ## file extension
export includeMarkerString="&&" ## String to indicate where 'includes' should be


