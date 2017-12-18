default_board([
[0,0,0,0,0,0],
[0,0,1,1,1,1],
[0,0,0,0,0,0],
[0,0,0,0,0,0],
[0,0,0,0,1,0],
[0,0,0,0,1,0]
]).

% Sum of line (n, sum)
sumLine(2,2).
sumLine(5,1).

% Sum of column (n, sum)
sumCol(4,3).

% Snake Head (line, column)
snakeHead(1,1).

% Snake Tail (line, column)
snakeTail(8,8).

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


calculateSumCol(Board, Column, Sum):-
    transpose(Board, New_board),
    calculateSumLine(New_board, Column, 1, Sum).
