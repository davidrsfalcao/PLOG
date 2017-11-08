clearScreen :- newLine(50), !.
newLine(Number) :-
	newLine(0, Number).

newLine(Line, Limit) :-
	Line < Limit,
	LineInc is Line + 1,
	nl,
	newLine(LineInc, Limit).

newLine(_,_).

ascii_to_dec(N,N1):-
	N1 is N-48.
