#!/bin/sh

#########################
# Install depencies for #
# Octavo                #
#########################

# This could be made for OS X easily too

sudo apt-get install zsh \
	&& echo "Installed zsh" \
	|| echo "Installation of zsh failed"

sudo apt-get install pandoc \
	&& echo "Installed pandoc" \
	|| echo "Installation of pandoc failed"

sudo apt-get install texlive-full \
	&& echo "Installed textlive-full" \
	|| echo "Installation of text-live failed"

