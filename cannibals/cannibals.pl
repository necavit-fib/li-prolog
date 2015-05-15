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
solve:-
  missionaires(M),
  cannibals(C),
  optimalSolution([[M,C],[0,0],left],[[0,0],[M,C],right]).

cost(Path,N):- %the cost is the amount of necessary steps
  length(Path,N).

notEaten(0,_). %no missionaires and N cannibals: OK (missionaires not killed)
notEaten(Missionaires,Cannibals):- %as long as missionaires are majority, all is OK
  Missionaires >= Cannibals.

crossRiver() :-


/* STEPS */
%move canoe from LEFT to RIGHT
step([[MLeft,CLeft],[MRight,CRight],left],
     [[MLeftFinal,CLeftFinal],[MRightFinal,CRightFinal],right]):-
    crossRiver(MLeft,CLeft,MRight,CRight, MLeftFinal,CLeftFinal,MRightFinal,CRightFinal).
%TODO

%move canoe from RIGHT to LEFT
%TODO
/* *************************************************************** */
