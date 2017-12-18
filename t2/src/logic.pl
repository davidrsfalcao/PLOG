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
