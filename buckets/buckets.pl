/*
 * 
 */

/* PARAMETERS */
smallBucket(5). %capacity of the small bucket
bigBucket(8).   %capacity of the big bucket
goalVolume(4).  %final volume within the big bucket

/* SOLVER */

step([_,_], [_,0]). %empty big
step([_,_], [0,_]). %empty small
step([_,B], [_,NB]):- %fill big
  bigBucket(NB),
  B < NB.
step([S,_], [NS,_]):- %fill small
  smallBucket(NS),
  S < NS.
step([S,B],[NS,NB]):- %small -> big
  %TODO

path(State,State, Path,Path).
path(CurrentState, GoalState, CurrentPath, TotalPath):-
  step(CurrentState, NextState),
  \+member(NextState, CurrentPath),
  path(NextState, GoalState, [NextState|CurrentPath], TotalPath).

optimalSolution:-
 %parameters
  smallBucket(S),
  bigBucket(B),
  goalVolume(G),
  
 %solver
  nat(N),
  path([0,0],[0,G],[[0,0]],P), %TODO fill the initial and goal states and the initial path
  length(P,N),
  write(P).