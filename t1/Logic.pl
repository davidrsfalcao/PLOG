:- dynamic player/2.

clean_players:-
    retractall(player(_,_)),
    !.

init_game:-
    create_board,
    create_board_res,
    !.

clean_game_stuff:-
    clean_players,
    clean_board,
    clean_board_res,
    !.

play:-
    init_game,
    nb_setval(player,1),
    repeat,
        nb_getval(player, PLAYER),
        get_all_possible_moves,
        %draw_possible_moves,
        show_board,
    	choose_piece(PLAYER, LINE, COLUMN),
        %delete_possible_moves,
        show_board,
    	move_piece(PLAYER, LINE, COLUMN),
        TMP is mod(PLAYER,2),
        NextPlayer is TMP +1,
        nb_setval(player, NextPlayer),
        fail,
    clean_game_stuff.


choose_piece(PLAYER, LINE, COLUMN):-
    player(PLAYER, TYPE),
    (TYPE == 'HUMAN' ->
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
            show_board,
            nl,
            write('\nERROR: Choose a valid piece'),
            nl,
            fail
        )
        ;
        bot_choose_piece(PLAYER, LINE, COLUMN)
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
        ; show_board,
        write('\nERROR: Invalid Line. Choose again!'),
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
        ; show_board,
         write('\nERROR: Invalid Column. Choose again!'),
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
        show_board,
        ( TYPE == 'HUMAN' ->
            choose_position_to_move(PLAYER, LINE1, COLUMN1)
            ; %bot
            bot_choose_position_to_mov(LINE_A, COLUMN_A, LINE1, COLUMN1)
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

    % FALTA VER AS PECAS DO MEIO

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
    %% FALTA VERIFICAR SE NAO HA PECAS PELO CAMINHO

possible_moves_piece(LINE, COLUMN):-
    board(LINE, COLUMN, PIECE),
    piece(PIECE, PLAYER),
    quadrant(QUADRANT, LINE, COLUMN),
    power_movement(QUADRANT, PLAYER, POWER),
    nb_setval(list_movements_piece, [[]]),
    % VERIFICA SE O LIMITE ESQUERDO É MAIOR QUE 0
    LL1 is COLUMN - POWER,
    ( LL1 < 1 ->
        LL is 1
        ;
        LL is LL1
    ),

    % VERIFICA SE O LIMITE DIREITO É MENOR QUE 10
    LR1 is COLUMN + POWER,
    ( LR1 > 9 ->
        LR is 9
        ;
        LR is LR1
    ),

    % VERIFICA SE O LIMITE SUPERIOR É MAIOR QUE 0
    LU1 is LINE - POWER,
    ( LU1 < 1 ->
        LU is 1
        ;
        LU is LU1
    ),

    % VERIFICA SE O LIMITE INFERIOR É MENOR QUE 10
    LD1 is LINE + POWER,
    ( LD1 > 9 ->
        LD is 9
        ;
        LD is LD1
    ),
    nb_setval(line, LU),
    nb_setval(column, LL),

    repeat,
        nb_getval(line, L),
        possible_moves_piece_line(PLAYER, LINE, COLUMN, L, POWER, LR, LL),
        nb_getval(line, H),
        ( H > LD ->
            !
            ;
            fail
        ),
        nb_getval(list_movements_piece, LIST_TMP),
        nth0(0, LIST_TMP, ELEM),
        delete(LIST_TMP, ELEM, LIST_MOVE),
        nb_setval(list_movements_piece, LIST_MOVE).

possible_moves_piece_line(PLAYER, LINE, COLUMN, L, POWER, LR, LL):-
    repeat,
        nb_getval(column, C),
        (verify_movement(PLAYER, LINE, COLUMN, L, C, POWER, _) ->
            make_list_of_move(PLAYER, LINE, COLUMN, L, C, RESULT),
            nb_getval(list_movements_piece, TMP),
            add_list(TMP, RESULT, FINAL),
            nb_setval(list_movements_piece, FINAL),
            K is C + 1,
            nb_setval(column, K)
            ;
            K is C + 1,
            nb_setval(column, K)
        ),
        nb_getval(column, C2),
        ( C2 > LR ->
            nb_setval(column, LL),
            nb_getval(line, I),
            J is I+1,
            nb_setval(line, J),
            !
            ;
            fail
        ),
    !.

get_all_possible_moves:-
    nb_setval(list_movements, [[]]),
    nb_setval(line1, 1),
    nb_setval(column1, 1),
    repeat,
        get_all_possible_moves_line,
        nb_getval(line1, H),
        ( H > 9 ->
            !
            ;
            fail
        ),
    !,
    nb_getval(list_movements, LIST_TMP),
    nth0(0, LIST_TMP, ELEM),
    delete(LIST_TMP, ELEM, LIST_MOVE),
    nb_setval(list_movements, LIST_MOVE).

get_all_possible_moves_line:-
    nb_getval(line1, L),
    repeat,
        nb_getval(column1, C),
        board(L, C, PIECE),
        ((piece(PIECE,1) ; piece(PIECE,2)) ->
            possible_moves_piece(L, C),
            nb_getval(list_movements_piece, TMP),
            nb_getval(list_movements, LISTAA),
            append(LISTAA, TMP, FINAL),
            nb_setval(list_movements, FINAL),
            K is C + 1,
            nb_setval(column1, K)
            ;
            K is C + 1,
            nb_setval(column1, K)
        ),
        nb_getval(column1, C2),
        ( C2 > 9 ->
            nb_setval(column1, 1),
            nb_getval(line1, I),
            J is I+1,
            nb_setval(line1, J),
            !
            ;
            fail
        ),
    !.

number_possible_moves_player(PLAYER, COUNT):-
    nb_getval(list_movements,ALL_MOVES),
    aggregate_all(count, move_belongs_to_player(PLAYER, ALL_MOVES, _), COUNT),
    !.


move_belongs_to_player(PLAYER, ALL_MOVES, INDEX):-
    nth0(INDEX, ALL_MOVES, ELEM),
    nth0(0, ELEM, PP),
    PLAYER == PP.

possible_moves_player(PLAYER, MOVES):-
    LIST = [[]],
    nb_setval(moves_player, LIST),
    nb_getval(list_movements, LL),
    nb_setval(index, 0),
    last(LL, LAST),

    repeat,
        nb_getval(index, INDEX),
        nth0(INDEX, LL, E),
        nth0(0, E, P),
        ( P == PLAYER ->
            nb_getval(moves_player, A),
            make_list_of_list(E, E1),
            append(A, E1, C),
            nb_setval(moves_player, C)
            ;
            nb_getval(moves_player, A),
            nb_setval(moves_player, A)
        ),
        ( E == LAST ->
            !
            ;
            INDEX1 is INDEX +1,
            nb_setval(index, INDEX1),
            fail
        ),

    nb_getval(moves_player, TMP),
    nth0(0, TMP, ELEM),
    delete(TMP, ELEM, LIST_MOVE),
    nb_setval(moves_player, LIST_MOVE),
    nb_getval(moves_player, MOVES).
