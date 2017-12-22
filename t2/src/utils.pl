% clean the Screen with 50 new lines
clearScreen :-
	newLine(50), !.

% display new lines
% newLine(+ Number)
newLine(Number) :-
	newLine(0, Number).

% display new lines
% newLine(+ Line,  + Limit)
newLine(Line, Limit) :-
	Line < Limit,
	LineInc is Line + 1,
	nl,
	newLine(LineInc, Limit).

newLine(_,_).

% convert an ascii code to a decimal number
% ascii_to_dec(+ N, - N1)
ascii_to_dec(N,N1):-
	N1 is N-48.

% reset the timer
reset_timer:-
	statistics(walltime,_).

% Print the elapsed time
print_time :-
	statistics(walltime, [_, ElapsedTime | _]),
	nl,
	format('Solution Time: ~3d seconds',ElapsedTime), nl, nl.

% Convert a list to matrix
% list_to_matrix(+list, +matrix_size, -matrix)
list_to_matrix([], _, []).

list_to_matrix(List, Size, [Row|Matrix]):-
	list_to_matrix_row(List, Size, Row, Tail),
	list_to_matrix(Tail, Size, Matrix).

list_to_matrix_row(Tail, 0, [], Tail).

list_to_matrix_row([Item|List], Size, [Item|Row], Tail):-
	NSize is Size-1,
	list_to_matrix_row(List, NSize, Row, Tail).

calculateIndex(Size, Line, Column, Index):-
	Index is (Size * Line + Column).

calculateLineColumn(Size, Index, Line, Column):-
	Line is integer(Index/Size),
	Column is mod(Index,Size).

setElemByIndex(List, Index, Elem):-
	setElemByIndex(List, Index, 0, Elem).

setElemByIndex([Head|_], Index, Index, Elem):-
	Head = Elem.

setElemByIndex([_|Tail], Index, I, Elem):-
	I1 is I+1,
	setElemByIndex(Tail, Index, I1, Elem).

intersection([], _, []).

intersection([H1|T1], L2, [H1|Res]) :-
	member(H1, L2),
	intersection(T1, L2, Res).

intersection([_|T1], L2, Res) :-
	intersection(T1, L2, Res).


disjunction([], _,[]).

disjunction([H1|T1], L2, [H1|Res]) :-
	disjunction(T1, L2, Res).

disjunction([H1|T1], L2, Res) :-
	member(H1, L2),
	disjunction(T1, L2, Res).
