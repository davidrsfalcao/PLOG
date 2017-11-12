:- use_module(library(random)).

% the bot randomly choose a piece to move (pieces with possible movements)
% bot_choose_piece(+ PLAYER, - LINE, - COLUMN)
bot_choose_piece(PLAYER, LINE, COLUMN):-
    possible_moves_player(PLAYER, MOVES),
    length(MOVES, TAM),
    random(0,TAM,N),
    nth0(N, MOVES, MOVE),
    nth0(1, MOVE, LINE),
    nth0(2, MOVE, COLUMN),
    sleep(2). % simulate human's time of reaction

% the bot randomly choose a position to move a piece
% bot_choose_position_to_mov(+ LINE_A, + COLUMN_A, - LINE1, - COLUMN1)
bot_choose_position_to_mov(LINE_A, COLUMN_A, LINE1, COLUMN1):-
    possible_moves_piece(LINE_A, COLUMN_A),
    nb_getval(list_movements_piece, MOVES),
    length(MOVES, TAM),
    random(0,TAM,N),
    nth0(N, MOVES, MOVE),
    nth0(3, MOVE, LINE1),
    nth0(4, MOVE, COLUMN1).

% the bot randomly choose a direction
% bot_change_direction(+ DIR, + DIR1, + DIR2, - DIR_TO_MOV)
bot_change_direction(DIR, DIR1, DIR2, DIR_TO_MOV):-
    random(0,3,RDIR),
    (RDIR == 0 ->
        DIR_TO_MOV = DIR
        ;
        (RDIR == 1 ->
            DIR_TO_MOV = DIR1
            ;
            DIR_TO_MOV = DIR2
        )
    ).
