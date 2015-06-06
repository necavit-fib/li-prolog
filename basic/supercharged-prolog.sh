#!/bin/bash

bold=`tput bold`
normal=`tput sgr0`

function usage {
	echo ""
	echo "usage: `basename $0` [-f LIB_FILE | --lib-file LIB_FILE]"
	echo ""
	echo "    ${bold}-f, --lib-file LIB_FILE${normal}"
	echo "        Loads the specified file into a SWI-Prolog engine."
	echo "        If no file is specified, it defaults to 'exercices.pl'"
	echo ""
	exit
}

if [ -n "$1" ] && [ "$1" = "-h" -o "$1" = "--help" ]; then
	usage
fi

lib_file=exercices.pl
if [ -n "$1" ] && [ "$1" = "-f" -o "$1" = "--lib-file" ]; then
	lib_file="$2"
fi

echo ""
echo "Running: swipl -l $lib_file ..."
echo ""
swipl -l $lib_file
