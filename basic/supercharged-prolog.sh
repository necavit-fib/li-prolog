#!/bin/bash

function usage {
	echo ""
	echo "ERROR"
	echo "Usage: $0 [-f LIB_FILE | --lib-file LIB_FILE]"
	echo "    Loads the specified file into a SWIProlog engine."
	echo "    If no file is specified, it defaults to 'exercices.pl'"
	echo ""
}

LIB_FILE=exercices.pl

while [[ $# > 1 ]]; do
	key="$1"
	case $key in
	  -f|--lib-file)
	  $LIB_FILE="$2"
	  shift
	  ;;
	  *)
			# unknown option
	  ;;
	esac
	shift
done

echo ""
echo "Running: swipl -l $LIB_FILE ..."
echo ""
echo ""
swipl -l $LIB_FILE
