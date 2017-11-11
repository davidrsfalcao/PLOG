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

move_belongs_to_player(PLAYER, ALL_MOVES, INDEX):-
    nth0(INDEX, ALL_MOVES, ELEM),
    nth0(0, ELEM, PP),
    PLAYER == PP.

number_possible_moves_player(PLAYER, COUNT):-
    nb_getval(list_movements,ALL_MOVES),
    aggregate_all(count, move_belongs_to_player(PLAYER, ALL_MOVES, _), COUNT),
    !.

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
    position_is_free_to_move(PLAYER, LINE1, COLUMN1),
    not(exist_piece_between_move(LINE_A, COLUMN_A, LINE1, COLUMN1)).

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

exist_piece_between_move(LINE_A, COLUMN_A, LINE1, COLUMN1):-
    DIF_L is LINE1 - LINE_A,
    DIF_C is COLUMN1 - COLUMN_A,

    ( DIF_L == 0 ->
        D_X is 0
        ;
        ( DIF_L > 0 ->
            D_X is 1
            ;
            D_X is -1
        )
    ),
    ( DIF_C == 0 ->
        D_Y is 0
        ;
        ( DIF_C > 0 ->
            D_Y is 1
            ;
            D_Y is -1
        )
    ),
    LINE is LINE_A + D_X,
    COLUMN is COLUMN_A + D_Y,
    exist_piece_between_move(LINE, COLUMN, LINE1, COLUMN1, D_X, D_Y).

exist_piece_between_move(LINE_A, COLUMN_A, LINE1, COLUMN1, D_X, D_Y):-
    LINE is LINE_A + D_X,
    COLUMN is COLUMN_A + D_Y,

    ((LINE_A == LINE1, COLUMN_A == COLUMN1) ->
        false
        ;
        board(LINE_A, COLUMN_A, PIECE),
        ((piece(PIECE,1) ; piece(PIECE, 2)) ->
            true
            ;
            exist_piece_between_move(LINE, COLUMN, LINE1, COLUMN1, D_X, D_Y)
        )
    ).

pass_over_enemies_tiles(LINE_A, COLUMN_A, LINE1, COLUMN1):-
    nb_setval(flag_enemy_passed, 0),
    board_res(LINE_A, COLUMN_A, PIECE),
    board_res(LINE1, COLUMN1, PIECE1),
    ( (PIECE == PIECE1 , (not(PIECE == 0))) ->
        DIF_L is LINE1 - LINE_A,
        DIF_C is COLUMN1 - COLUMN_A,
        ( DIF_L == 0 ->
            D_X is 0
            ;
            ( DIF_L > 0 ->
                D_X is 1
                ;
                D_X is -1
            )
        ),
        ( DIF_C == 0 ->
            D_Y is 0
            ;
            ( DIF_C > 0 ->
                D_Y is 1
                ;
                D_Y is -1
            )
        ),
        LINE is LINE_A + D_X,
        COLUMN is COLUMN_A + D_Y,
        PLAYER is PIECE,
        pass_over_enemies_tiles(PLAYER, LINE, COLUMN, LINE1, COLUMN1, D_X, D_Y)
        ;
        true
    ).

pass_over_enemies_tiles(PLAYER, LINE_A, COLUMN_A, LINE1, COLUMN1, D_X, D_Y):-
    LINE is LINE_A + D_X,
    COLUMN is COLUMN_A + D_Y,
    ( PLAYER == 1 ->
        ENEMY is 2
        ;
        ENEMY is 1
    ),
    ((LINE_A == LINE1, COLUMN_A == COLUMN1) ->
        true
        ;
        board_res(LINE_A, COLUMN_A, PIECE),
        ((PIECE == ENEMY) ->
            retract(board_res(LINE_A, COLUMN_A, _)),
            assert(board_res(LINE_A, COLUMN_A, PLAYER)),
            retract(board(LINE_A, COLUMN_A, _)),
            (PLAYER == 1 ->
                assert(board(LINE_A, COLUMN_A, '1'))
                ;
                assert(board(LINE_A, COLUMN_A, '2'))
            ),
            nb_setval(flag_enemy_passed,1),
            pass_over_enemies_tiles(PLAYER, LINE, COLUMN, LINE1, COLUMN1, D_X, D_Y)
            ;
            pass_over_enemies_tiles(PLAYER, LINE, COLUMN, LINE1, COLUMN1, D_X, D_Y)
        )
    ).

pass_over_empty_tiles(LINE_A, COLUMN_A, LINE1, COLUMN1):-
    board_res(LINE_A, COLUMN_A, PIECE),
    board_res(LINE1, COLUMN1, PIECE1),
    ( (PIECE == PIECE1 , (not(PIECE == 0))) ->
        DIF_L is LINE1 - LINE_A,
        DIF_C is COLUMN1 - COLUMN_A,
        ( DIF_L == 0 ->
            D_X is 0
            ;
            ( DIF_L > 0 ->
                D_X is 1
                ;
                D_X is -1
            )
        ),
        ( DIF_C == 0 ->
            D_Y is 0
            ;
            ( DIF_C > 0 ->
                D_Y is 1
                ;
                D_Y is -1
            )
        ),
        LINE is LINE_A + D_X,
        COLUMN is COLUMN_A + D_Y,
        PLAYER is PIECE,
        pass_over_empty_tiles(PLAYER, LINE, COLUMN, LINE1, COLUMN1, D_X, D_Y)
        ;
        true
    ).

pass_over_empty_tiles(PLAYER, LINE_A, COLUMN_A, LINE1, COLUMN1, D_X, D_Y):-
    LINE is LINE_A + D_X,
    COLUMN is COLUMN_A + D_Y,

    ((LINE_A == LINE1, COLUMN_A == COLUMN1) ->
        true
        ;
        board_res(LINE_A, COLUMN_A, PIECE),
        ((PIECE == 0) ->
            retract(board_res(LINE_A, COLUMN_A,_)),
            assert(board_res(LINE_A, COLUMN_A, PLAYER)),
            retract(board(LINE_A, COLUMN_A,_)),
            ( PLAYER == 1 ->
                assert(board(LINE_A, COLUMN_A, '1'))
                ;
                assert(board(LINE_A, COLUMN_A, '2'))
            )
            ;
            exist_piece_between_move(LINE, COLUMN, LINE1, COLUMN1, D_X, D_Y)
        )
    ).
