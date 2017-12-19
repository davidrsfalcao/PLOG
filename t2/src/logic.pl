% Sum of line
% sumLine(+n,+sum)
sumLine(1,2).
sumLine(4,1).

% Sum of column
% sumCol(+n,+sum)
sumCol(_,_):-
    false.

% Sum of neighbours
% sumAround(+line, +column, + sum)
sumAround(2,4,6).
sumAround(3,1,6).

% Snake Head (line, column)
snakeHead(0,0).

% Snake Tail (line, column)
snakeTail(5,5).


%Returns all elements of a specific line
%  getElemsLine(+Board, +Line, -Elems)
getElemsLine(Board, Line, Elems):-
    nth0(Line, Board, Elems).

%Returns all elements of a specific column
%  getElemsColumn(+Board, +Column, -Elems)
getElemsColumn(Board, Column, Elems):-
    transpose(Board, New_Board),
    nth0(Column, New_Board, Elems).

getElemsAround(Board, L, C, Elems):-
    findall(L1-C1, neighbor(L, C, L1, C1), Temp),
    getElem(Board, Temp, Elems).

getElem(Board, [Line-Column|T], [Head|Tail]):-
    nth0(Line, Board, Tmp),
    nth0(Column, Tmp, Head),
    getElem(Board, T, Tail).

getElem(Board, [_|T], Elems):-
    getElem(Board, T, Elems).

getElem(_, [], []).

neighbor(L,C, L1, C1):-
    L1 is L-1,
    C1 is C-1.

neighbor(L,C, L1, C1):-
    L1 is L-1,
    C1 is C.

neighbor(L,C, L1, C1):-
    L1 is L-1,
    C1 is C+1.

neighbor(L,C, L1, C1):-
    L1 is L,
    C1 is C-1.

neighbor(L,C, L1, C1):-
    L1 is L,
    C1 is C+1.

neighbor(L,C, L1, C1):-
    L1 is L+1,
    C1 is C-1.

neighbor(L,C, L1, C1):-
    L1 is L+1,
    C1 is C.

neighbor(L,C, L1, C1):-
    L1 is L+1,
    C1 is C+1.

testHorizontalSum(Board):-
    findall(Line-Sum, sumLine(Line,Sum),All_Res),
    testHorizontalSum(Board, All_Res).

testHorizontalSum(Board, [Line-Sum|T]):-
    getElemsLine(Board, Line, Elems),
    sum(Elems, #=, Sum),
    testHorizontalSum(Board, T).

testHorizontalSum(_, []).


testVerticalSum(Board):-
    findall(Column-Sum, sumCol(Column,Sum),All_Res),
    testVerticalSum(Board, All_Res).

testVerticalSum(Board, [Column-Sum|T]):-
    getElemsColumn(Board, Column, Elems),
    sum(Elems, #=, Sum),
    testVerticalSum(Board, T).

testVerticalSum(_, []).

testNeighboursSum(Board):-
    findall([Line, Column,Sum], sumAround(Line,Column,Sum),All_Res),
    testNeighboursSum(Board, All_Res).

testNeighboursSum(Board, [Head|T]):-
    nth0(0, Head, Line),
    nth0(1, Head, Column),
    nth0(2, Head, Sum),
    nth0(Line, Board, Temp),
    nth0(Column, Temp, Position),
    Position #= 0,
    getElemsAround(Board, Line, Column, Elems),
    sum(Elems, #=, Sum),
    testNeighboursSum(Board, T).

testNeighboursSum(_, []).

adjacent(Line,Col,L1,C1):-
    L1 is Line-1,
    C1 is Col.

adjacent(Line,Col,L1,C1):-
    L1 is Line+1,
    C1 is Col.

adjacent(Line,Col,L1,C1):-
    L1 is Line,
    C1 is Col-1.

adjacent(Line,Col,L1,C1):-
    L1 is Line,
    C1 is Col+1.

getElemsAdjacent(Board, Line, Column, Elems):-
    findall(L1-C1, adjacent(Line, Column, L1, C1), Temp),
    getElem(Board, Temp, Elems).


%Check if a position is the tail or the head of the snake
% checkBorders(+line,+column)
checkBorders(L, C):-
    snakeHead(L,C);
    snakeTail(L,C).

testBoardConnection(Board):-
    findall(Line-Column, (nth0(Line, Board, Tmp),nth0(Column, Tmp, _)), Indexes),
    testBoardConnection(Board, Indexes).

testBoardConnection(Board, [Line-Column|T]):-
    checkBorders(Line, Column),
    getElemsAdjacent(Board, Line, Column, Elems),
    sum(Elems, #=, 1), % only has 1 connection
    testBoardConnection(Board, T).

testBoardConnection(Board, [Line-Column|T]):-
    \+ checkBorders(Line, Column),
    getElemsAdjacent(Board, Line, Column, Elems),
    verifyConnection(Board, Line, Column, Elems),
    testBoardConnection(Board, T).

testBoardConnection(_, []).

verifyConnection(Board, Line, Column, Elems):-
    nth0(Line,Board,Temp),
    nth0(Column,Temp,P),
    (P#=0 #\/ P#=1),
    sum(Elems,#=,2).
