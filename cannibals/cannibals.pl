step(CurrentState, NextState). %TODO implement this method

path(State,State, Path,Path).
path(CurrentState, GoalState, CurrentPath, TotalPath):-
  step(CurrentState, NextState),
  \+member(NextState, CurrentPath),
  path(NextState, GoalState, [NextState|CurrentPath], TotalPath).

optimalSolution:-
  nat(N),
  path([],[],[[]],P), %TODO fill the initial and goal states and the initial path
  length(P,N),
  write(P).