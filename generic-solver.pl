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

path(State,State, Path,Path).
path(CurrentState, GoalState, CurrentPath, TotalPath):-
  step(CurrentState, NextState), %defined per problem
  \+member(NextState, CurrentPath),
  path(NextState, GoalState, [NextState|CurrentPath], TotalPath).

optimalSolution(InitialState, GoalState):-
	nat(Cost),
	path(InitialState, GoalState, [InitialState], Path),
	cost(Path, Cost), %defined per problem
	write('Cost: '), write(Cost), nl,
	write('Path: '), write(Path), nl.

main:-
	solve, %defined in each problem (will use optimalSolution)
	halt.

/* *************************************************************** */
