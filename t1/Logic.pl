:- dynamic player/2.

clean_players():-
    retractall(player(_,_)).


choose_piece(PLAYER, LINE, COLUMN):-
    repeat,
    nl,
    write('[PLAYER'),
    write(PLAYER),
    write('] Choose a piece to play'),
    choose_line(LINE),
    choose_column(COLUMN),
    (piece_belongs_to_player(PLAYER, LINE, COLUMN) ->
        !
        ;
        write('\nERROR: Choose a valid piece'),
        nl,
        fail
    ).

choose_line(LINE):-
    repeat,
    nl,
    write('Line: '),
    get_single_char(LINE2),
    ascii_to_dec(LINE2,LINE1),
    write(LINE1),
    ((LINE1 =< 9 , LINE1 >= 1) ->
        !
        ; write('\nERROR: Invalid Line. Choose again!'),
        fail
    ),
    LINE is 10-LINE1.

choose_column(COLUMN):-
    repeat,
    nl,
    write('Column: '),
    get_single_char(COLUMN2),
    ascii_to_dec(COLUMN2,COLUMN1),
    COLUMN is COLUMN1 - 48,
    format('~c',COLUMN2),
    ((COLUMN =< 9 , COLUMN >= 1) ->
        !
        ; write('\nERROR: Invalid Column. Choose again!'),
        fail
    ).

piece_belongs_to_player(PLAYER, LINE, COLUMN):-
    board(LINE, COLUMN, PIECE),
    piece(PIECE, PP),
    PP =:= PLAYER.


choose_position_to_move(PLAYER, LINE, COLUMN):-
    nl,
    nl,
    write('[PLAYER'),
    write(PLAYER),
    write('] Choose a position to move'),
    choose_line(LINE),
    choose_column(COLUMN),
    !.

move_piece(PLAYER, LINE, COLUMN):-
    LINE_A is LINE,
    COLUMN_A is COLUMN,
    quadrant(QUADRANT, LINE_A, COLUMN_A),
    power_movement(QUADRANT, PLAYER, POWER),
    player(PLAYER, TYPE),
    ( TYPE == 'HUMAN' ->
        choose_position_to_move(PLAYER, LINE1, COLUMN1)
        ; %bot
        write("BOT")
    ).
