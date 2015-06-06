/* **** **** **** **** **** */
/* David Martínez Rodríguez */
/* LI - May, 2015           */
/* MIT License              */
/* **** **** **** **** **** */

/* *************************************************************** */
/*                      BRIDGE PROBLEM SOLVER                      */
/* *************************************************************** */

/*
 * The state is modeled as follows:
 *   State = [<lantern position>, <left side people>, <right side people>, <cost>], where
 *   TODO
 */

/* PARAMETERS */
people([1,2,5,8]).  %list of people and their crossing times
bridgeCapacity(2).  %capacity of the bridge

/* SOLVER */
boundedCost(1).

solve:-
  people(P),
  optimalSolution([left,P,[],0],[right,[],_,_]).

cost([],0). %no steps => cost = 0
cost([[_,_,_,Cost]|_],Cost). %the cost has been accumulated during the path construction

msubset([], []).
msubset([E|Tail], [E|NTail]):-
  msubset(Tail, NTail).
msubset([_|Tail], NTail):-
  msubset(Tail, NTail).

crossBridge(PeopleOrigin, PeopleDest, Cost, PeopleOriginEnd, PeopleDestEnd, CostEnd):-
  bridgeCapacity(Max),
  between(1,Max,K),
  msubset(PeopleOrigin,Group),
  length(Group,K),
  subtract(PeopleOrigin,Group,PeopleOriginEnd),
  append(PeopleDest,Group,PeopleDestEnd),
  max_list(Group,Slowest),
  CostEnd is Cost + Slowest.

/* STEPS */
%cross bridge from LEFT to RIGHT
step([left,Left,Right,Cost],[right,LeftEnd,RightEnd,CostEnd]):-
  crossBridge(Left,Right,Cost, LeftEnd,RightEnd,CostEnd).

%cross bridge from RIGHT to LEFT
step([right,Left,Right,Cost],[left,LeftEnd,RightEnd,CostEnd]):-
  crossBridge(Right,Left,Cost, RightEnd,LeftEnd,CostEnd).
/* *************************************************************** */
