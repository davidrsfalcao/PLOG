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
        draw_possible_moves(PLAYER),
        show_board,
    	choose_piece(PLAYER, LINE, COLUMN),
        delete_possible_moves(PLAYER),
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
        write('[PLAYER '),
        write(PLAYER),
        write('] Choosing a piece to play'),
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
