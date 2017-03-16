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

sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:hvr/ghc
sudo apt-get update
sudo apt-get install -y cabal-install-1.22 ghc-7.10.3
cat >> ~/.bashrc <<EOF
export PATH="\$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:\$PATH"
EOF
export PATH=~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH

# Update Cabal
sudo /opt/cabal/1.22/bin/cabal update

# Now install csv2table
cabal install pandoc-csv2table

# Now install pandoc-crossref
cabal install pandoc-crossref

# Now install pandoc-citeproc
apt-get install pandoc-citeproc
