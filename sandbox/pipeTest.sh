#!/usr/bin/env bash
# Bash3 Boilerplate. Copyright (c) 2014, kvz.io

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"

arg1="${1:-}"


function firstFunction() {

read -r pipedInput

sed 's/title/REPLACED TITLE/g' "$pipedInput"

}


function secondFunction() {

	pipedInput="$(cat)" # Captured multi-line input from Stdin

echo "$pipedInput"

}


echo "$arg1" | firstFunction | secondFunction
