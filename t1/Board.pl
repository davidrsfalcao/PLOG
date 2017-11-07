board([
  [null,null,null,null,null,null,null,null,null],
  [null,null,null,null,null,null,null,null,null],
  [null,null,null,null,null,null,null,null,null],
  [null,null,null,null,null,null,null,null,null],
  [null,null,null,null,null,null,null,null,null],
  [null,null,null,null,null,null,null,null,null],
  [null,null,null,null,null,null,null,null,null]
]).

init_row(R, [ ]) :-
    R =< 0, !.
init_row(R, [_ | T]) :-
    R > 0,
    R2 is R - 1,
    init_row(R2, T).

init_board(_, R, []) :-
    R =< 0, !.
init_board(C, R, [H|T]) :-
    init_list(C,H),
    R2 is R - 1,
    init_matrix(C, R2, T).



display_walls(S):-
    S > 0,
    S < 9,
    S1 is S + 1,
    write('|'),
    write('  '),
    write('|'),
    display_walls(S1).

display_walls(S):-
    S > 0,
    S1 is S + 1,
    write('|'),
    write(' '),
    write('|'),
    display_walls(S1).

display_walls(S):-nl.
