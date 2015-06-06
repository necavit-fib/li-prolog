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
 *        <lantern position> = {left | right}
 *        <left side people> = [person1, person2, ...]
 *       <right side people> = [person1, person2, ...]
 *                    <cost> = integer
 */

/* PARAMETERS */
people([1,2,5,8]).  %list of people and their crossing times
bridgeCapacity(2).  %capacity of the bridge

/* SOLVER */
boundedCost(1). %enables bounding the cost of the path, thus early bounding the search space

solve:-
  people(P),
  optimalSolution([left,P,[],0],[right,[],_,_]).

cost([],0). %no steps => cost = 0
cost([[_,_,_,Cost]|_],Cost). %the cost has been accumulated during the path construction

%builds all the possible subsets of a set under bactracking
msubset([], []).
msubset([E|Tail], [E|NTail]):-
  msubset(Tail, NTail).
msubset([_|Tail], NTail):-
  msubset(Tail, NTail).

crossBridge(PeopleOrigin, PeopleDest, Cost, PeopleOriginEnd, PeopleDestEnd, CostEnd):-
  %Given the maximum capacity of the bridge in terms of people...
  bridgeCapacity(Max),
  %find a subset (group) of people on the origin of the bridge...
  between(1,Max,K),
  msubset(PeopleOrigin,Group),
  length(Group,K),

  %take them out of the set of people in the origin...
  subtract(PeopleOrigin,Group,PeopleOriginEnd),
  %add them to the set of people in the destination...
  append(PeopleDest,Group,PeopleDestEnd),

  %find the slowest person in the group...
  max_list(Group,Slowest),
  %and update the cost with its "weight" (travel time).
  CostEnd is Cost + Slowest.

/* STEPS */
%cross bridge from LEFT to RIGHT
step([left,Left,Right,Cost],[right,LeftEnd,RightEnd,CostEnd]):-
  crossBridge(Left,Right,Cost, LeftEnd,RightEnd,CostEnd).

%cross bridge from RIGHT to LEFT
step([right,Left,Right,Cost],[left,LeftEnd,RightEnd,CostEnd]):-
  crossBridge(Right,Left,Cost, RightEnd,LeftEnd,CostEnd).
/* *************************************************************** */
