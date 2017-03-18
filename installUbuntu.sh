#!/bin/sh

#########################
# Install depencies for #
# Octavo                #
#########################

# Usage

# sudo sh installUbuntu.sh

# Note to self: This could be made for OS X easily too

sudo apt-get install zsh \
	&& echo "Installed zsh" \
	|| echo "Installation of zsh failed"

sudo apt-get install pandoc \
	&& echo "Installed pandoc" \
	|| echo "Installation of pandoc failed"

sudo apt-get install texlive-full \
	&& echo "Installed textlive-full" \
	|| echo "Installation of text-live failed"

# Lastly, install these

# Install Haskell (instructions for other OSs than Ubuntu
# are available here: https://www.haskell.org/downloads/linux)

sudo apt-get --yes install haskell-platform

# Update Cabal
sudo cabal update

# Now install csv2table
cabal install pandoc-csv2table

# Now install pandoc-crossref
cabal install pandoc-crossref

# Now install pandoc-citeproc
sudo apt-get --yes install pandoc-citeproc


# Python for the python-based filters
sudo apt-get --yes install python3-pip
pip-install upgrade pip
sudo pip3 install pandocfilters

