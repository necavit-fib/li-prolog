%concat(L1,L2,L3).
% Given two lists L2 and L2, L3 is the concatenation
% of the other two
concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).

%memberRest(X,L,Rest).
% Given an element X and a list L, return the rest of
% the elements of L if X is a member of the list.
memberRest(X,L,Rest):-
  concat(L1,[X|L2],L),
  concat(L1,L2,Rest).

%2.
%prod(L,P).
% Given a list of integers L, their product is P
prod([], 1).
prod([Head|Tail], P):-
  prod(Tail, Prod),
  P is Head * Prod.

%3.
%dot(V1,V2,D).
% Given two lists (vectors) V1 and V2, of the same
% size, D is their dot product
dot([], [], 0).
dot([Head1|Tail1], [Head2|Tail2], Dot):-
  dot(Tail1, Tail2, InnerDot),
  Dot is Head1 * Head2 + InnerDot.

%4.1.
%union(S1,S2,U).
% Given two sets as lists without repeated elements
% S1 and S2, U is the union of the sets
union([], Set, Set).
union([X|Set1], Set2, Union):-
  member(X, Set2), !, union(Set1, Set2, Union).
union([X|Set1], Set2, [X|Union]):-
  union(Set1, Set2, Union).

%4.2.
%intersection(S1,S2,I).
% Given two sets S1 and S2, I is the intersection of them
intersection([], _, []).
intersection([X|Set1], Set2, [X|Intersection]):-
  member(X, Set2), !,
  intersection(Set1, Set2, Intersection).
intersection([_|Set1], Set2, Intersection):-
  intersection(Set1, Set2, Intersection).

%5.1.
%lastElem(L,X).
% Given a list L, X is its last element
lastElement(List, X):-
  concat(_,[X], List).

%5.1. (variant)
% another implementation:
lastElement2([Last], Last).
lastElement2([_|Tail], Last):-
  lastElement2(Tail, Last).

%5.2
%inverse(L,I).
% Given a list L, I is the inverted list
inverse([], []).
inverse([Head|Tail], I):-
  inverse(Tail, Aux),
  concat(Aux, [Head], I).

%6.
%fib(N,F).
% Given an integer N, F is the N-th Fibonacci number
fib(1,1).
fib(2,1).
fib(N,F):-
  N > 2,
  N1 is N - 1,
  N2 is N - 2,
  fib(N1,F1),
  fib(N2,F2),!,
  F is F1 + F2.

%7.
%dice(P,N,L).
% Given P points & N rolls of a single die, give all the possible combinations
% of rolls that would sum P points in the list L
dice(0, 0, []).
dice(Points, Nrolls, List):-
	Nrolls > 0,
	Points >= Nrolls,
	Max is 6*Nrolls,
	Points =< Max,
	member(X,[1,2,3,4,5,6]),
	N1rolls is Nrolls - 1,
	RemainingPoints is Points - X,
	dice(RemainingPoints, N1rolls, Auxlist),
	List = [X|Auxlist].

%8.
%sumOfOthers(L).
% Given a list L, it is satisfied if any of the elements of
% L is the sum of the rest of the elements in L.
sumOfOthers(L):-
  memberRest(X,L,Rest),
  sum_list(Rest,X),!.

%9.
%sumOfPrevious(L).
% Given a list L, it is satisfied if any of the elements of
% L is the sum of the previous elements in L.
sumOfPrevious(L):-
  concat(Previous,[X|_],L),
  sum_list(Previous,X),!.

%10.
%card(L).
% Given a list L, for each element in L write a list that states
% how many times the element appeared in L
card(L):-
  cardinality(L,Card),
  write(Card).

cardinality([],[]).
cardinality([X|Tail],UpdatedCard):-
  cardinality(Tail,Card),
  memberRest([X,N],Card,Rest),!,
  N1 is N + 1,
  append([[X,N1]],Rest,UpdatedCard).
cardinality([X|Tail],UpdatedCard):-
  cardinality(Tail,Card),
  append([[X,1]],Card,UpdatedCard).

%11.
%sorted(L).
% Given a list L of numbers, it succeeds if the list is ordered.
sorted([]).
sorted([_]):- !. %the cut is necessary to make the predicate deterministic
sorted([X1,X2|Tail]):-
  X1 =< X2,
  sorted([X2|Tail]).

%12.
%permsort(L1,L2).
% Given a list L1, L2 is its sorted version. To sort it, only permutation/2
% and sorted/1 are allowed.
permsort(List,Sorted):-
  permutation(List,Sorted),
  sorted(Sorted),!.

%14.
%inssort(L1,L2).
% Given a list L1, L2 is its sorted version. The sorting must follow an
% insertion scheme.
inssort([],[]).
inssort([X|Tail],Sorted):-
  inssort(Tail,Partial),
  insertion(X,Partial,Sorted),!.

insertion(X,[],[X]).
insertion(X,[Y|Rest],[X,Y|Rest]):-
  X =< Y.
insertion(X,[Y|Rest],[Y|Result]):-
  X > Y,
  insertion(X,Rest,Result).

%16.
%mergesort(L1,L2).
% Given a list L1, L2 is its sorted version. The sorting must follow the
% merge sort scheme.
mergesort([],[]):- !.
mergesort([X],[X]):- !.
mergesort(List,Sorted):-
  split(List,Left,Right),
  mergesort(Left,MLeft),
  mergesort(Right,MRight),
  merge(MLeft,MRight,Sorted).

split([],[],[]):-!.
split(List,Left,Right):-
  concat(Left,Right,List),
  length(Left,L),
  length(Right,R),
  L = R, !.
split(List,Left,Right):-
  concat(Left,Right,List),
  length(Left,L),
  length(Right,R),
  R1 is R + 1,
  L = R1, !.

merge([], L, L):- !.
merge(L, [], L):- !.
merge([L|LL], [R|RL], [L|Merged]):-
  L =< R,!,
  merge(LL,[R|RL],Merged).
merge([L|LL], [R|RL], [R|Merged]):-
  merge([L|LL],RL,Merged).
