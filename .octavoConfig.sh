#!/bin/sh

# Configuration file for Octavo

## Logfile location
export LOGFILE="$HOME/Dropbox/.logThis/log" # Needs to be created if it doesn't exist

## Behaviour
export suppressmessages="no"
### Note that a variable called TEMPDIRECTORY specifying your favourite temporary
### directory should be specified

## Location of skeleton files for creation of new Octavo documents
export skeletondir="$HOME/Dropbox/CCCU/text/deploy/skeletons"

## Document settings (these can be overriden in the Yaml)
## Note: Some variables must be set in the Yaml itself
## in order to be available to Pandoc and filters
export crossrefYaml="$HOME/Dropbox/CCCU/text/deploy/includes/pandoc-crossrefSettings.yaml"
export includedir="$HOME/Dropbox/CCCU/text/deploy/includes"
export templatedir="$HOME/Dropbox/CCCU/text/deploy/templates"
export deployconfig="$HOME/Dropbox/CCCU/text/deploy/deployConfig"
export remoteserver="cccupsychology.com"

## YAML processing
export yamlBeginMarker="---" ## Where does the YAML block start?
export yamlEndMarker="..." ## Where does it end?

## Preprocessing
export extension="markdown" ## file extension
export includeMarkerString="&&" ## String to indicate where 'includes' should be


# Deployment text for the document, telling the reader about
# other versions
## export deploymentTextHead="\qrcode{www.google.com} If you scan this QR code with your phone, it will take you an online version of this document. It is available in"
export deploymentTextHead="This document is available in"
export deploymentTextBody=""
export deploymentTextFoot="This document contains hyperlinks to [sections within it](#overview), [external webpages](http://cccupsychology.com), and email addresses like [ian.hocking@canterbury.ac.uk](mailto:ian.hocking@canterbury.ac.uk)."

# Purge files in Deploy directories older than N days (use 0 to unset this behaviour):
# export deployPurgeOlderThan="1"   # Disabled for the moment because it's deleting source files, annoyingly

