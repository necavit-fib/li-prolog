%concat(L1,L2,L3).
% Given two lists L2 and L2, L3 is the concatenation
% of the other two
concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).

%prod(L,P).
% Given a list of integers L, their product is P
prod([], 1).
prod([Head|Tail], P):-
  prod(Tail, Prod),
  P is Head * Prod.

%dot(V1,V2,D).
% Given two lists (vectors) V1 and V2, of the same
% size, D is their dot product
dot([], [], 0).
dot([Head1|Tail1], [Head2|Tail2], Dot):-
  dot(Tail1, Tail2, InnerDot),
  Dot is Head1 * Head2 + InnerDot.

%union(S1,S2,U).
% Given two sets as lists without repeated elements
% S1 and S2, U is the union of the sets
union([], Set, Set).
union([X|Set1], Set2, Union):-
  member(X, Set2), !, union(Set1, Set2, Union).
union([X|Set1], Set2, [X|Union]):-
  union(Set1, Set2, Union).

%intersection(S1,S2,I).
% Given two sets S1 and S2, I is the intersection of them
intersection([], _, []).
intersection([X|Set1], Set2, [X|Intersection]):-
  member(X, Set2), !,
  intersection(Set1, Set2, Intersection).
intersection([_|Set1], Set2, Intersection):-
  intersection(Set1, Set2, Intersection).

%lastElem(L,X).
% Given a list L, X is its last element
lastElement(List, X):-
  concat(_,[X], List).

% another implementation:
lastElement2([Last], Last).
lastElement2([_|Tail], Last):-
  lastElement2(Tail, Last).

%inverse(L,I).
% Given a list L, I is the inverted list
inverse([], []).
inverse([Head|Tail], I):-
  inverse(Tail, Aux),
  concat(Aux, [Head], I).

%dados(P,N,L).
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
