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
