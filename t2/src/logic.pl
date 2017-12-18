% Sum of line
% sumLine(+n,+sum)
sumLine(2,2).
sumLine(5,1).

% Sum of column
% sumCol(+n,+sum)
sumCol(3,3).

sumCol(_,_):-
    false.

% Snake Head (line, column)
snakeHead(1,1).

% Snake Tail (line, column)
snakeTail(8,8).


list_to_matrix([], _, []).
list_to_matrix(List, Size, [Row|Matrix]):-
  list_to_matrix_row(List, Size, Row, Tail),
  list_to_matrix(Tail, Size, Matrix).

list_to_matrix_row(Tail, 0, [], Tail).
list_to_matrix_row([Item|List], Size, [Item|Row], Tail):-
  NSize is Size-1,
  list_to_matrix_row(List, NSize, Row, Tail).


% Calculates the sum of a specific line
% calculateSumLine(+Board, +Size, +Line, -Sum)
calculateSumLine(Board, Size, Line, Sum):-
    Index is Line * Size,
    IndexF is Index + Size,
    calculateSumLine(Board, Index, IndexF, Sum, 0).

calculateSumLine(_, IndexF, IndexF, Sum, Sum).

calculateSumLine(Board, IndexI, IndexF, Sum, Sum_aux):-
    nth0(IndexI, Board, Elem),
    Next_sum #= Sum_aux + Elem,
    Next_index is IndexI + 1,
    calculateSumLine(Board, Next_index, IndexF, Sum, Next_sum).


% Calculates the sum of a specific column
%calculateSumCol(+Board, +Size, +Column, -Sum)
calculateSumCol(Board, Size, Column, Sum):-
    calculateSumCol(Board, Size, Column, Sum, 0).

calculateSumCol(_, Size, IndexI, Sum, Sum):-
    IndexI >= Size.

calculateSumCol(Board, Size, IndexI, Sum, Sum_aux):-
    TotalSize is Size * Size,
    IndexI < TotalSize,
    nth0(IndexI, Board, Elem),
    Next_sum #= Sum_aux + Elem,
    Next_index is IndexI + Size,
    calculateSumCol(Board, Size, Next_index, Sum, Next_sum).
