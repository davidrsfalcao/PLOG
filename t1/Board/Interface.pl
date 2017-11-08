translate('null', '   ').
translate('1', '░░░').
translate('2', '▓▓▓').
translate('1_este', ' ▷ ').
translate('1_oeste', ' ◁ ').
translate('1_norte', ' △ ').
translate('1_sul', ' ▽ ').
translate('1_nordeste', ' ◹ ').
translate('1_noroeste', ' ◸ ').
translate('1_sudeste', ' ◿ ').
translate('1_sudoeste', ' ◺ ').
translate('2_este', ' ▶ ').
translate('2_oeste', ' ◀ ').
translate('2_norte', ' ▲ ').
translate('2_sul', ' ▼ ').
translate('2_nordeste', ' ◥ ').
translate('2_noroeste', ' ◤ ').
translate('2_sudeste', ' ◢ ').
translate('2_sudoeste', ' ◣ ').

display_board():-
    clearScreen,
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

display_line(_, 10).

display_end_quadrant_h(LINE, COLUMN):-
    ( COLUMN = 3;  COLUMN = 6),
    writef(' '),
    LINE1 is 10 - LINE,
    write(LINE1),
    writef(' ║').

display_end_quadrant_h(_, _).

display_end_quadrant_v(LINE, _):-
    LINE = 9,
    nl,
    writef('╚═══╩═══╩═══╝   ╚═══╩═══╩═══╝   ╚═══╩═══╩═══╝').

display_end_quadrant_v(LINE, _):-
    ( LINE = 3;  LINE = 6),
    nl,
    writef('╚═══╩═══╩═══╝   ╚═══╩═══╩═══╝   ╚═══╩═══╩═══╝'),
    nl,
    writef('  a   b   c       d   e   f       g   h   i'),
    nl,
    writef('╔═══╦═══╦═══╗   ╔═══╦═══╦═══╗   ╔═══╦═══╦═══╗').

display_end_quadrant_v(_, _):-
    nl,
    writef('╠═══╬═══╬═══╣   ╠═══╬═══╬═══╣   ╠═══╬═══╬═══╣').
