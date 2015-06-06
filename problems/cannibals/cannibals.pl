/* **** **** **** **** **** */
/* David Martínez Rodríguez */
/* LI - May, 2015           */
/* MIT License              */
/* **** **** **** **** **** */

/* *************************************************************** */
/*                   CANNIBALS PROBLEM SOLVER                      */
/* *************************************************************** */

/*
 * The state is modeled as follows:
 *   State = [<left side>, <right side>, <canoe position>], where
 *          <left side>  = [#missionaires, #cannibals],
 *          <right side> = [#missionaires, #cannibals],
 *      <canoe position> = {left | right}
 */

/* PARAMETERS */
missionaries(3).  %number of missionaires to cross the river
cannibals(3).     %number of cannibals to cross the river
canoeCapacity(2). %capacity of the boat

/* SOLVER */
boundedCost(0).

solve:-
  missionaries(M),
  cannibals(C),
  optimalSolution([[M,C],[0,0],left],[[0,0],[M,C],right]).

cost(Path,N):- %the cost is the amount of necessary steps
  length(Path,N).

notEaten(0,_). %no missionaires and N cannibals: OK (missionaires not killed)
notEaten(Missionaires,Cannibals):- %as long as missionaires are majority, all is OK
  Missionaires >= Cannibals.

crossRiver(MStartLeft,CStartLeft,MStartRight,CStartRight, MEndLeft,CEndLeft,MEndRight,CEndRight):-
  %Given the maximum capacity of the canoe...
  canoeCapacity(Max),
  %find a combination of missionaires and cannibals such that...
  between(0,Max,Missionaires),
  between(0,Max,Cannibals),
  %there is enough missionaires or cannibals in the start shore of the river...
  Missionaires =< MStartLeft,
  Cannibals =< CStartLeft,
  %the number of people in the canoe is the sum of missionaires and cannibals...
  Canoe is Missionaires + Cannibals,
  %there is at lease 1 people in the canoe...
  Canoe >= 1,
  %and the number of people in the canoe does not exceed its capacity.
  Canoe =< Max,

  %Substract and add people to their corresponding side
  MEndLeft is MStartLeft - Missionaires,
  MEndRight is MStartRight + Missionaires,
  CEndLeft is CStartLeft - Cannibals,
  CEndRight is CStartRight + Cannibals,

  %Ensure the missionaires do not get eaten!
  notEaten(MEndLeft,CEndLeft),
  notEaten(MEndRight,CEndRight).


/* STEPS */
%move canoe from LEFT to RIGHT
step([[MLeft,CLeft],[MRight,CRight],left],
     [[MLeftFinal,CLeftFinal],[MRightFinal,CRightFinal],right]):-
  crossRiver(MLeft,CLeft,MRight,CRight,
             MLeftFinal,CLeftFinal,MRightFinal,CRightFinal).

%move canoe from RIGHT to LEFT
step([[MLeft,CLeft],[MRight,CRight],right],
     [[MLeftFinal,CLeftFinal],[MRightFinal,CRightFinal],left]):-
  crossRiver(MRight,CRight,MLeft,CLeft,
             MRightFinal,CRightFinal,MLeftFinal,CLeftFinal).
/* *************************************************************** */
