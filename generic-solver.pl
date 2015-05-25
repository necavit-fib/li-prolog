/* **** **** **** **** **** */
/* David Martínez Rodríguez */
/* LI - May, 2015           */
/* MIT License              */
/* **** **** **** **** **** */

/* *************************************************************** */
/*                 GENERIC SOLVER (UTILITY FUNCTIONS)              */
/* *************************************************************** */

nat(0).
nat(N):-
	nat(X),
	N is X + 1.

%the problem implementation defines whether or not to bound the cost
boundedCost(_, _):- boundedCost(0), !.
boundedCost(CurrentPath, MaxCost):- cost(CurrentPath, Cost), Cost =< MaxCost.

path(State,State, Path,_,Path).
path(CurrentState, GoalState, CurrentPath, MaxCost, TotalPath):-
	step(CurrentState, NextState), %defined per problem
	boundedCost(CurrentPath, MaxCost),
  \+member(NextState, CurrentPath),
  path(NextState, GoalState, [NextState|CurrentPath], MaxCost, TotalPath).

optimalSolution(InitialState, GoalState):-
	nat(Cost),
	path(InitialState, GoalState, [InitialState], Cost, Path),
	cost(Path, Cost), %defined per problem
	write('Cost: '), write(Cost), nl,
	write('Path: '), write(Path), nl.

main:-
	solve, %defined in each problem (will use optimalSolution)
	halt.

/* *************************************************************** */
