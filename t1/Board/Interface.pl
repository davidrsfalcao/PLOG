translate('null', '   ').
translate('1', '░░░').
translate('2', '▓▓▓').
translate('1_e', ' ▷ ').
translate('1_w', ' ◁ ').
translate('1_n', ' △ ').
translate('1_s', ' ▽ ').
translate('1_ne', ' ◹ ').
translate('1_nw', ' ◸ ').
translate('1_se', ' ◿ ').
translate('1_sw', ' ◺ ').
translate('2_e', ' ▶ ').
translate('2_w', ' ◀ ').
translate('2_n', ' ▲ ').
translate('2_s', ' ▼ ').
translate('2_ne', ' ◥ ').
translate('2_nw', ' ◤ ').
translate('2_se', ' ◢ ').
translate('2_sw', ' ◣ ').

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
