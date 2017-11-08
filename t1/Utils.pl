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

direction_mov(0,0,'null').
direction_mov(1,0,'n').
direction_mov(-1,0,'s').
direction_mov(0,1,'e').
direction_mov(0,-1,'w').
direction_mov(1,1,'ne').
direction_mov(1,-1,'nw').
direction_mov(-1,1,'se').
direction_mov(-1,-1,'sw').
