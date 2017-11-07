:- dynamic board/3.

create_board():-
    assert(board(1,1,'2_sudeste')),
    assert(board(1,2,'null')),
    assert(board(1,3,'1_sul')),
    assert(board(1,4,'null')),
    assert(board(1,5,'null')),
    assert(board(1,6,'null')),
    assert(board(1,7,'2_sul')),
    assert(board(1,8,'null')),
    assert(board(1,9,'null')),

    assert(board(2,1,'null')),
    assert(board(2,2,'null')),
    assert(board(2,3,'null')),
    assert(board(2,4,'null')),
    assert(board(2,5,'null')),
    assert(board(2,6,'null')),
    assert(board(2,7,'null')),
    assert(board(2,8,'null')),
    assert(board(2,9,'null')),

    assert(board(3,1,'null')),
    assert(board(3,2,'null')),
    assert(board(3,3,'null')),
    assert(board(3,4,'null')),
    assert(board(3,5,'null')),
    assert(board(3,6,'null')),
    assert(board(3,7,'null')),
    assert(board(3,8,'null')),
    assert(board(3,9,'null')),

    assert(board(4,1,'null')),
    assert(board(4,2,'null')),
    assert(board(4,3,'null')),
    assert(board(4,4,'null')),
    assert(board(4,5,'null')),
    assert(board(4,6,'null')),
    assert(board(4,7,'null')),
    assert(board(4,8,'null')),
    assert(board(4,9,'null')),

    assert(board(5,1,'1_este')),
    assert(board(5,2,'null')),
    assert(board(5,3,'null')),
    assert(board(5,4,'null')),
    assert(board(5,5,'null')),
    assert(board(5,6,'null')),
    assert(board(5,7,'null')),
    assert(board(5,8,'null')),
    assert(board(5,9,'2_oeste')),

    assert(board(6,1,'null')),
    assert(board(6,2,'null')),
    assert(board(6,3,'null')),
    assert(board(6,4,'null')),
    assert(board(6,5,'null')),
    assert(board(6,6,'null')),
    assert(board(6,7,'null')),
    assert(board(6,8,'null')),
    assert(board(6,9,'null')),

    assert(board(7,1,'null')),
    assert(board(7,2,'null')),
    assert(board(7,3,'null')),
    assert(board(7,4,'null')),
    assert(board(7,5,'null')),
    assert(board(7,6,'null')),
    assert(board(7,7,'null')),
    assert(board(7,8,'null')),
    assert(board(7,9,'null')),

    assert(board(8,1,'null')),
    assert(board(8,2,'null')),
    assert(board(8,3,'null')),
    assert(board(8,4,'null')),
    assert(board(8,5,'null')),
    assert(board(8,6,'null')),
    assert(board(8,7,'null')),
    assert(board(8,8,'null')),
    assert(board(8,9,'null')),

    assert(board(9,1,'null')),
    assert(board(9,2,'null')),
    assert(board(9,3,'1_norte')),
    assert(board(9,4,'null')),
    assert(board(9,5,'null')),
    assert(board(9,6,'null')),
    assert(board(9,7,'2_norte')),
    assert(board(9,8,'null')),
    assert(board(9,9,'1_noroeste')).

translate('null', '   ').
translate('1', ' 1 ').
translate('2', ' 2 ').
translate('1_este', '1 >').
translate('1_oeste', '< 1').
translate('1_norte', '1 ^').
translate('1_sul', 'V 1').
translate('1_nordeste', '1^>').
translate('1_noroeste', '<^1').
translate('1_sudeste', '1V>').
translate('1_sudoeste', '<V1').

translate('2_este', ' 2>').
translate('2_oeste', '<2 ').
translate('2_norte', '2 ^').
translate('2_sul', 'V 2').
translate('2_nordeste', '2^>').
translate('2_noroeste', '<^2').
translate('2_sudeste', '2V>').
translate('2_sudoeste', '<V2').




display_board():-
    writef('╔═══╦═══╦═══╗   ╔═══╦═══╦═══╗   ╔═══╦═══╦═══╗'),
    nl,
    display_board(1,1).

display_board(LINE, COLUMN):-
    LINE < 10,
    writef('║'),
    display_line(LINE, COLUMN),
    display_end_quadrant_v(LINE, COLUMN),
    nl,
    LINE1 is LINE+1,
    display_board(LINE1,COLUMN).

display_board(10,1):-
    nl.

display_line(LINE, COLUMN):-
    COLUMN< 10,
    board(LINE, COLUMN, D),
    translate(D,D1),
    writef(D1),
    writef('║'),
    display_end_quadrant_h(LINE, COLUMN),
    COLUMN1 is COLUMN+1,
    display_line(LINE, COLUMN1).

display_line(LINE, 10):-
    true.

display_end_quadrant_h(LINE, COLUMN):-
    ( COLUMN = 3;  COLUMN = 6),
    writef(' '),
    write(LINE),
    writef(' ║').

display_end_quadrant_h(LINE, COLUMN):-
    true.

display_end_quadrant_v(LINE, COLUMN):-
    LINE = 9,
    nl,
    writef('╚═══╩═══╩═══╝   ╚═══╩═══╩═══╝   ╚═══╩═══╩═══╝').

display_end_quadrant_v(LINE, COLUMN):-
    ( LINE = 3;  LINE = 6),
    nl,
    writef('╚═══╩═══╩═══╝   ╚═══╩═══╩═══╝   ╚═══╩═══╩═══╝'),
    nl,
    writef('  1   2   3       4   5   6       7   8   9'),
    nl,
    writef('╔═══╦═══╦═══╗   ╔═══╦═══╦═══╗   ╔═══╦═══╦═══╗').

display_end_quadrant_v(LINE, COLUMN):-
    nl,
    writef('╠═══╬═══╬═══╣   ╠═══╬═══╬═══╣   ╠═══╬═══╬═══╣').
