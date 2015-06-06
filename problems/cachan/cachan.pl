/* **** **** **** **** **** */
/* David Martínez Rodríguez */
/* LI - May, 2015           */
/* MIT License              */
/* **** **** **** **** **** */

/* *************************************************************** */
/*                      CACHAN PROBLEM SOLVER                      */
/* *************************************************************** */

/* ************************ PARAMETERS *************************** */

students([
	[1,2,6],[1,6,7],[2,3,8],[6,7,9],[6,8,9],[1,2,4],[3,5,6],[3,5,7],
	[5,6,8],[1,6,8],[4,7,9],[4,6,9],[1,4,6],[3,6,9],[2,3,5],[1,4,5],
	[1,6,7],[6,7,8],[1,2,4],[1,5,7],[2,5,6],[2,3,5],[5,7,9],[1,6,8]
]).

/* ************************** SOLVER ***************************** */

nat(0).
nat(N):-
  nat(N1),
  N is N1 + 1.

%the cost of a solution is the sum of talks given in each slot (A,B,C)
cost(A,B,C,Cost):-
  length(A,LengthA),
  length(B,LengthB),
  length(C,LengthC),
  Cost is LengthA + LengthB + LengthC.

%insert an element in a list, if it is not already present
insert(Elem,Set,Set):-
  member(Elem,Set),!.
insert(Elem,Set,FinalSet):-
  append([Elem],Set,FinalSet).

%each slot (A,B,C) is updated by adding the student desired talks (X,Y,Z)
% in their corresponding slot (if it is not already in the slot)
inserted([X,Y,Z], A,B,C, AFinal,BFinal,CFinal):-
  insert(X,A,AFinal),
  insert(Y,B,BFinal),
  insert(Z,C,CFinal).

%once the list of students has been traversed, "return" the final schedule
% of the slots (A,B,C)
scheduleTalks(_, [], A,B,C, A,B,C).
scheduleTalks(MaxTalks, [Student|Tail], A,B,C, AFinal,BFinal,CFinal):-
	%For a given student, find permutations of its desired talks...
  permutation(Student,Permutation),
	%and add them to the slots,
  inserted(Permutation, A,B,C, A1,B1,C1),

	%bounding the number of talks given (bounding the cost)...
  cost(A1,B1,C1,Cost),
  Cost =< MaxTalks,

	%and proceed with the next student
  scheduleTalks(MaxTalks, Tail, A1,B1,C1, AFinal,BFinal,CFinal).

displaySlotTail([]):- nl.
displaySlotTail([Head|Tail]):-
  write(', '), write(Head),
  displaySlotTail(Tail).

displaySlot([]):- nl.
displaySlot([Head|Tail]):-
  write(Head),
  displaySlotTail(Tail).

displaySolution(A,B,C):-
	cost(A,B,C,Cost),
	write('Solution found!'), nl,
	write('  '), write(Cost), write(' talks must be performed:'), nl,
  write('    Slot A: '), displaySlot(A),
  write('    Slot B: '), displaySlot(B),
  write('    Slot C: '), displaySlot(C).

solve(A,B,C):-
	students(Students),
  nat(N),
  scheduleTalks(N, Students, [],[],[], A,B,C),
  displaySolution(A,B,C).

/* ********************* SOLUTION CHECKER ************************ */

%returns, under backtracking, all the slots in which a talk is given
slot(Talk, A,_,_, a):- member(Talk,A).
slot(Talk, _,B,_, b):- member(Talk,B).
slot(Talk, _,_,C, c):- member(Talk,C).
slot(_,    _,_,_, _):- fail.

checkStudent([T1,T2,T3], A,B,C):-
    %For each desired talk (T1,T2,T3), find its corresponding slot...
		slot(T1, A,B,C, S1),
    slot(T2, A,B,C, S2),
    slot(T3, A,B,C, S3),

		%and ensure that they are different.
    S1 \= S2,
    S1 \= S3,
    S2 \= S3,!,

		%Print the slots that the student will attend to.
    write(' will attend to '), nl,
    write('  meeting '), write(T1), write(' on slot '), write(S1), nl,
    write('  meeting '), write(T2), write(' on slot '), write(S2), nl,
    write('  meeting '), write(T3), write(' on slot '), write(S3), nl.
checkStudent(_,_,_,_):-
	%If no possible combination of the students desired talks with the given schedule
	% is possible, then the solution was not correct!!
	write('Something is wrong with this student!!'), nl,
	fail.

checkStudents([], _,_,_).
checkStudents([Student|Tail], A,B,C):-
    write('The student: '), write(Student),
    checkStudent(Student, A,B,C),
    checkStudents(Tail, A,B,C).

checkSolution(Students, A,B,C):-
	checkStudents(Students, A,B,C),
	write('Solution checked! Everything is OK!'), nl.
checkSolution(_, _,_,_):-
	write('Solution is WRONG! Something, somewhere, went terribly wrong!'), nl.

/* *************************** MAIN ****************************** */

main:-
	checkSolution(1),!,
	students(Students),
	solve(A,B,C), nl,
	checkSolution(Students, A,B,C),
	halt.
main:-
  solve(_,_,_),
  halt.
