#!/bin/bash

function usage {
	echo "Usage: $0 PROBLEM_FILE"
	echo "    Generates a solver for the given problem file, provided it has a 'optimalSolution' Prolog goal."
	echo "    After the solver compilation, it is executed."
}

exec_file=solve
solver_file=solver.pl

echo "Cleaning solver file $solver_file..."
echo "rm $solver_file"
rm $solver_file

echo ""
echo "Appending generic solver to $solver_file..."
echo "cat generic-solver.pl >> $solver_file"
cat generic-solver.pl >> $solver_file

echo ""
echo "Appending problem solver to $solver_file..."
echo "cat $1 >> $solver_file"
cat $1 >> $solver_file

echo ""
echo "Compiling solver to executable file: $exec_file..."
echo "swipl -O -g optimalSolution --stand_alone=true -o $exec_file -c $solver_file"
swipl -O -g main --stand_alone=true -o $exec_file -c $solver_file

echo ""
echo "Executing solver..."
echo "./$exec_file"
./$exec_file 2> /dev/null
