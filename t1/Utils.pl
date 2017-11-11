clearScreen :- newLine(100), !.
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


make_list_of_move(PLAYER, LINE, COLUMN, LINE1, COLUMN1, RESULT):-
	numlist(PLAYER, PLAYER, P),
	numlist(LINE, LINE, L_B),
	numlist(COLUMN, COLUMN, C_B),
	numlist(LINE1, LINE1, L_A),
	numlist(COLUMN1, COLUMN1, C_A),
	append(P, L_B, L1),
	append(L1, C_B, L2),
	append(L2, L_A, L3),
	append(L3, C_A, RESULT).

make_list_of_list(LIST,B):-
	B = [LIST].

% ADD LIST to a LIST OF LISTS
add_list(LLIST, LIST, FINAL):-
	make_list_of_list(LIST,B),
	append(LLIST, B, FINAL).

direction_mov(0,0,'null').
direction_mov(1,0,'n').
direction_mov(-1,0,'s').
direction_mov(0,1,'e').
direction_mov(0,-1,'w').
direction_mov(1,1,'ne').
direction_mov(1,-1,'nw').
direction_mov(-1,1,'se').
direction_mov(-1,-1,'sw').


draw_possible_moves(PLAYER):-
	draw_possible_moves(PLAYER,0),
	!.

draw_possible_moves(PLAYER, INDEX):-
	nb_getval(list_movements,ALL_MOVES), nl, nl,
	write(ALL_MOVES), nl, nl, nl,
	length(ALL_MOVES, TAM),
	(TAM == 0 ->
		true
		;
		nth0(INDEX, ALL_MOVES, MOV),
		nth0(0, MOV, PP),
		( PLAYER == PP ->
			nth0(3, MOV, LINE),
			nth0(4, MOV, COLUMN),
			retract(board(LINE, COLUMN, _)),
			assert(board(LINE, COLUMN, 'X')),
			last(ALL_MOVES, LAST)
			;
			last(ALL_MOVES, LAST)
		),
		(LAST == MOV ->
			true
			;
			INDEX1 is INDEX +1,
			draw_possible_moves(PLAYER, INDEX1)
		)
	).


delete_possible_moves(PLAYER):-
	delete_possible_moves(PLAYER,0),
	!.

delete_possible_moves(PLAYER, INDEX):-
	nb_getval(list_movements,ALL_MOVES),
	length(ALL_MOVES, TAM),
	(TAM == 0 ->
		true
		;
		nth0(INDEX, ALL_MOVES, MOV),
		nth0(0, MOV, PP),
		( PLAYER == PP ->
			nth0(3, MOV, LINE),
			nth0(4, MOV, COLUMN),
			retract(board(LINE, COLUMN, _)),
			board_res(LINE, COLUMN, PIECE),
			(PIECE == 0 ->
				PIECE1 = 'null'
				;
				( PIECE == 1 ->
					PIECE1 = '1'
					;
					PIECE1 = '2'
				)
			),
			assert(board(LINE, COLUMN, PIECE1)),
			last(ALL_MOVES, LAST)
			;
			last(ALL_MOVES, LAST)
		),
		(LAST == MOV ->
			true
			;
			INDEX1 is INDEX +1,
			delete_possible_moves(PLAYER, INDEX1)
		)
	).
