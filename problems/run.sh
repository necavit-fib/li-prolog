#!/bin/bash

# Prolog problems automated solver script
# david.martinez.rodriguez@est.fib.upc.edu
#
# May 2015

# *** environment setting *** #
export PATH=$PATH:.

# *** variables *** #
exec_file=solve
solver_logic="foo"
solver_file=solver.pl
solution_tmp=solution

#terminal output formatting
bold=`tput bold`
normal=`tput sgr0`
info=`tput setaf 6`
error=`tput setaf 1`

# *** function declarations *** #

function echor {
	builtin echo [$(basename $0)]: $1;
}

function usage {
	echo ""
	echo "usage: `basename $0` [-h | --help] ${bold}PROBLEM${normal}"
	echo "    compiles and runs a solver for the given problem"
	echo ""
	echo "    ${bold}-h, --help${normal}  prints this usage and exit"
	echo ""
	echo "    ${bold}PROBLEM${normal}  one of the following available problems:"
	echo "      bridge"
	echo "      buckets"
	echo "      cachan (see note, below)"
	echo "      cannibals"
	echo ""
	echo "    ${bold}NOTE!${normal} the cachan problem accepts an additional flag:"
	echo "      --check  enables solution checking (disabled by default)"
	echo ""
	exit
}

function clean_solver {
	echor "cleaning solver file $solver_file..."
	rm -f $solver_file

	echor "cleaning solver executable file $exec_file..."
	rm -f $exec_file
}

function compile_execute {
	echor "appending problem solver $solver_logic to $solver_file..."
	cat $solver_logic >> $solver_file

	echor "compiling solver to executable file: $exec_file..."
	swipl -O -g main --stand_alone=true -o $exec_file -c $solver_file

	echor "executing solver..."
	$exec_file > $solution_tmp

	echor "DONE executing solver!"
	echor "solution found by the solver:"
	echo ""
	cat $solution_tmp
	echo ""
	rm -f $solution_tmp
}

function execute_generic_solver {
	echor "appending generic solver to $solver_file..."
	cat generic-solver.pl >> $solver_file
	compile_execute
}

function bridge {
	clean_solver
	solver_logic=bridge/bridge.pl
	execute_generic_solver
}

function buckets {
	clean_solver
	solver_logic=buckets/buckets.pl
	execute_generic_solver
}

function cachan {
	clean_solver
	solver_logic=cachan/cachan.pl
	if [ -n "$2" ] && [ "$2" = "--check" ]; then
		echor "enabling solution checking..."
		echo "checkSolution(1)." >> $solver_file
	else
		echo "checkSolution(0)." >> $solver_file
	fi
	compile_execute
}

function cannibals {
	clean_solver
	solver_logic=cannibals/cannibals.pl
	execute_generic_solver
}

# *** main script logic *** #
if [ $# -lt 1 ]; then
  echor "error: no arguments supplied"
  usage
fi

#select which problem to build the solver
problem=$1
case "$problem" in
	"-h"|"--help") usage ;;
	"bridge") bridge ;;
	"buckets") buckets ;;
	"cachan") cachan "$@" ;;
	"cannibals") cannibals ;;
	*)
		echor "error: problem not recognised"
		usage
	;;
esac
