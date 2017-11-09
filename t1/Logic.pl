:- dynamic player/2.

clean_players:-
    retractall(player(_,_)),
    !.


choose_piece(PLAYER, LINE, COLUMN):-
    repeat,
    nl,
    write('[PLAYER '),
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
    PP == PLAYER.


choose_position_to_move(PLAYER, LINE, COLUMN):-
    nl,
    nl,
    write('[PLAYER '),
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
    repeat,
    ( TYPE == 'HUMAN' ->
        choose_position_to_move(PLAYER, LINE1, COLUMN1)
        ; %bot
        write("BOT")
    ),
    (verify_movement(PLAYER, LINE_A, COLUMN_A, LINE1, COLUMN1, POWER, DIR_A) ->
        !
        ; fail
    ),
    board(LINE_A, COLUMN_A, PIECE),
    retract(board(LINE_A, COLUMN_A, PIECE)),
    board_res(LINE_A, COLUMN_A, PIECE1),
    ( PIECE1 == 0 ->
        assert(board(LINE_A, COLUMN_A, 'null'))
        ;
        ( PIECE1 == 1 ->
            assert(board(LINE_A, COLUMN_A, '1'))
            ;
            assert(board(LINE_A, COLUMN_A, '2'))
        )
    ),

    % FALTA VER AS PEÇAS DO MEIO

    retract(board_res(LINE1, COLUMN1, _)),
    ( PLAYER == 1 ->
        assert(board_res(LINE1, COLUMN1, 1))
        ;
        assert(board_res(LINE1, COLUMN1, 2))
    ),

    retract(board(LINE1, COLUMN1, _)),
    (direction(PIECE2,DIR_A), piece(PIECE2, PLAYER)),
    assert(board(LINE1, COLUMN1,PIECE2)).


calculate_direction(LINE_A, COLUMN_A, LINE1, COLUMN1, DIR):-
    D_YY is LINE_A - LINE1,
    ( D_YY == 0 ->
        D_Y is 0
        ;
        ( D_YY > 0 ->
            D_Y is 1
            ;
            D_Y is -1
        )
    ),
    D_XX is COLUMN1 - COLUMN_A,
    ( D_XX == 0 ->
        D_X is 0
        ;
        ( D_XX > 0 ->
            D_X is 1
            ;
            D_X is -1
        )
    ),
    direction_mov(D_Y, D_X, DIR).




verify_movement(PLAYER, LINE_A, COLUMN_A, LINE1, COLUMN1, POWER, DIR):-
    DIF_L is LINE_A - LINE1,
    abs(DIF_L, X),
    X =< POWER,
    DIF_C is COLUMN_A - COLUMN1,
    abs(DIF_C, Y),
    Y =< POWER,
    (X == Y; X == 0; Y == 0),
    calculate_direction(LINE_A, COLUMN_A, LINE1, COLUMN1, DIR),
    board(LINE_A, COLUMN_A, PIECE),
    direction(PIECE,DIR_A),
    possible_direction(DIR_A, DIR),
    position_is_free_to_move(PLAYER, LINE1, COLUMN1).
    %% FALTA VERIFICAR SE NÃO HÁ PEÇAS PELO CAMINHO
