default_board([
[0,0,0,0,0,0],
[0,0,1,1,1,1],
[0,0,0,0,0,0],
[0,0,0,0,0,0],
[0,0,0,0,1,0],
[0,0,0,0,1,0]
]).

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


% Create random board
% createRandomBoard(+Size, -Board)
createRandomBoard(Size, Board):-
    createRandomBoard(Size, 0, Board).

createRandomBoard(Size, Actual_size, [Head|Tail]):-
    Actual_size < Size,
    length(Head, Size),
    Next_size is Actual_size + 1,
    createRandomBoard(Size, Next_size, Tail).

createRandomBoard(_, _, _).

% Calculates the sum of a specific line
% calculateSumLine(+Board, +Line, -Sum)
calculateSumLine(Board, Line, Sum):-
    calculateSumLine(Board, Line, 1, Sum).

calculateSumLine([Head|_], Line, Actual_line, Sum):-
    Line == Actual_line,
    sumlist(Head, Sum).

calculateSumLine([_|Tail], Line, Actual_line, Sum):-
    Line \= Actual_line,
    Next_line is Actual_line + 1,
    calculateSumLine(Tail, Line, Next_line, Sum).

calculateSumLine([], _, _, 0).

% Calculates the sum of a specific column
% calculateSumCol(+Board, +Column, -Sum)
calculateSumCol(Board, Column, Sum):-
    transpose(Board, New_board),
    calculateSumLine(New_board, Column, 1, Sum).

%
% calculateSumAround(Board, Line, Column, Sum):-
