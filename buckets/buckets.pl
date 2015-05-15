/* **** **** **** **** **** */
/* David Martínez Rodríguez */
/* LI - May, 2015           */
/* MIT License              */
/* **** **** **** **** **** */

/* *************************************************************** */
/*                     BUCKETS PROBLEM SOLVER                      */
/* *************************************************************** */

/* PARAMETERS */
smallBucket(5). %capacity of the small bucket
bigBucket(8).   %capacity of the big bucket
goalVolume(4).  %final volume within the big bucket

/* SOLVER */
solve:-
  goalVolume(Goal),
  optimalSolution([0,0],[0,Goal]).

cost(Path,N):-
  length(Path,N).

min(X,Y,X):- X =< Y.
min(X,Y,Y):- Y =< X.

/* STEPS */

%empty big
step([S,_],[S,0]).

%empty small
step([_,B],[0,B]).

%fill big
step([S,_],[S,NB]):- bigBucket(NB).

%fill small
step([_,B],[NS,B]):- smallBucket(NS).

%small -> big
step([S,B],[NS,NB]):-
  bigBucket(Maxcapacity),
  Diff is Maxcapacity - B,
  min(S,Diff,Delta),
  NB is B + Delta,
  NS is S - Delta.

%big -> small
step([S,B],[NS,NB]):-
  smallBucket(Maxcapacity),
  Diff is Maxcapacity - S,
  min(B,Diff,Delta),
  NB is B - Delta,
  NS is S + Delta.

/* *************************************************************** */
