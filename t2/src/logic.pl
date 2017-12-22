% Sum of line
% sumLine(+n,+sum)
:-dynamic sumLine/2.

% Sum of column
% sumCol(+n,+sum)
:-dynamic sumCol/2.

% Sum of neighbours
% sumAround(+line, +column, ?sum)
:-dynamic sumAround/3.

% Snake Head
% snakeHead(-line, -column)
:-dynamic snakeHead/2.

% Snake Tail
% snakeTail(-line, -column)
:-dynamic snakeTail/2.

%Returns all elements of a specific line
%  getElemsLine(+Board, +Line, -Elems)
getElemsLine(Board, Line, Elems):-
    nth0(Line, Board, Elems).

%Returns all elements of a specific column
%  getElemsColumn(+Board, +Column, -Elems)
getElemsColumn(Board, Column, Elems):-
    transpose(Board, New_Board),
    nth0(Column, New_Board, Elems).

%Returns all elements of a specific column
%  getElemsAround(+Board, +Line, +Column, -Elems)
getElemsAround(Board, L, C, Elems):-
    findall(L1-C1, neighbor(L, C, L1, C1), Temp),
    getElem(Board, Temp, Elems).

% Returns all valid elements of a list of pairs
% getElem(+board, +List, +Elems)
getElem(Board, [Line-Column|T], [Head|Tail]):-
    nth0(Line, Board, Tmp),
    nth0(Column, Tmp, Head),
    getElem(Board, T, Tail).

getElem(Board, [_|T], Elems):-
    getElem(Board, T, Elems).

getElem(_, [], []).

% Return the neighbor of a specific position L-C
% neighbor(+line, +column, -neighbor_line, -neighbor_column)
neighbor(L,C, L1, C1):-
    L1 is L-1, C1 is C-1.

neighbor(L,C, L1, C1):-
    L1 is L-1,C1 is C.

neighbor(L,C, L1, C1):-
    L1 is L-1,C1 is C+1.

neighbor(L,C, L1, C1):-
    L1 is L,C1 is C-1.

neighbor(L,C, L1, C1):-
    L1 is L,C1 is C+1.

neighbor(L,C, L1, C1):-
    L1 is L+1,C1 is C-1.

neighbor(L,C, L1, C1):-
    L1 is L+1,C1 is C.

neighbor(L,C, L1, C1):-
    L1 is L+1,C1 is C+1.

% Test all horizontal restrictions of the board
% testHorizontalSum(+ board)
testHorizontalSum(Board):-
    findall(Line-Sum, sumLine(Line,Sum),All_Res),
    testHorizontalSum(Board, All_Res).

testHorizontalSum(Board, [Line-Sum|T]):-
    getElemsLine(Board, Line, Elems),
    sum(Elems, #=, Sum),
    testHorizontalSum(Board, T).

testHorizontalSum(_, []).

% Test all vertical restrictions of the board
% testHorizontalSum(+ board)
testVerticalSum(Board):-
    findall(Column-Sum, sumCol(Column,Sum),All_Res),
    testVerticalSum(Board, All_Res).

testVerticalSum(Board, [Column-Sum|T]):-
    getElemsColumn(Board, Column, Elems),
    sum(Elems, #=, Sum),
    testVerticalSum(Board, T).

testVerticalSum(_, []).

% Test all around position restrictions of the board
% testHorizontalSum(+ board)
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

% Return the position adjacent of a specific position L-C
% adjacent(+line, +column, -adjacent_line, -adjacent_column)
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

% Return the diagonal of a specific position L-C
% diagonal(+line, +column, -diagonal_line, -diagonal_column)
diagonal(Line,Col,L1,C1):-
    L1 is Line-1,
    C1 is Col-1.

diagonal(Line,Col,L1,C1):-
    L1 is Line+1,
    C1 is Col+1.

diagonal(Line,Col,L1,C1):-
    L1 is Line-1,
    C1 is Col+1.

diagonal(Line,Col,L1,C1):-
    L1 is Line+1,
    C1 is Col-1.

% Return the diagonal adjacent of a specific position L-C
% diagonal(+line, +column, -diagonal_line, -diagonal_column)
getElemsAdjacent(Board, Line, Column, Elems):-
    findall(L1-C1, adjacent(Line, Column, L1, C1), Temp),
    getElem(Board, Temp, Elems).


%Check if a position is the tail or the head of the snake
% checkBorders(+line,+column)
checkBorders(L, C):-
    snakeHead(L,C);
    snakeTail(L,C).

% Teste the board connectivity
% All pieces of the snake must have 2 adjacente pieces, except the borders
% that must have only 1
% testBoardConnection(+ board)
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
    getElement(Board, Line, Column, P),
    getElemsAround(Board, Line, Column, Around),
    sum(Around,#=,A),
    sum(Elems,#=,H),
    ((P#=0 #/\ H#=<3 #/\ A#=<7) #\/ (P#=1 #/\ H#=2)),
    preventCrossing(P, Board,Line, Column).

% Returns the element of a position
% getElement(+ board, +line, +column, -element)
getElement(Board, Line, Column, Elem):-
     nth0(Line,Board,Temp),
     nth0(Column,Temp, Elem).

% Returns true if an element is not a member of a list
% notMember(+element, +list)
notMember(A, List):-
    \+ member(A, List).

% Prevents the snake from touching itself on the diagonal
% For 2 pieces of the snake to touch each other, they must
% have one and only one adjacent piece in common
% preventCrossing(+reference_element, +board, +line, +column)
preventCrossing(P, Board, Line, Column):-
    findall(L-C, (adjacent(Line, Column, L, C), nth0(L,Board,Temp), nth0(C,Temp, _)) , Adj),
    findall(L1-C1, diagonal(Line, Column, L1, C1), Diag),
    findall(LL-CC, (member(LL-CC, Diag), nth0(LL,Board,Temp), nth0(CC, Temp, _)), Diags),
    preventCrossing1(P, Board, Adj, Diags).

preventCrossing1(P,Board, Adj, [L-_|T]):-
    \+ nth0(L, Board, _),
    preventCrossing1(P,Board, Adj, T).

preventCrossing1(P,Board, Adj, [L-C|T]):-
    nth0(L, Board, Temp),
    \+ nth0(C, Temp, _),
    preventCrossing1(P, Board, Adj, T).

preventCrossing1(P,Board, Adj, [L-C|T]):-
    findall(L1-C1, (adjacent(L, C, L1, C1),nth0(L1,Board, Temp),nth0(C1, Temp, _)), D_Adj),
    findall(Line-Col, (member(Line-Col, Adj), member(Line-Col,D_Adj)), Interset1),
    getElem(Board, Interset1, Interset),
    nth0(L, Board, Temp),
    nth0(C, Temp, Elem),
    sum(Interset, #=, Sum),
    ((Sum#=0 #/\ P#=1) #=> Elem#=0),
    preventCrossing1(P,Board, Adj, T).

preventCrossing1(_,_, _, []).


% Solves the problem
% solveProb(+ board_size, -solution_board)
solveProb(Size, Board):-
    reset_timer,
    Size1 is Size*Size,

    length(List, Size1),
    domain(List, 0,1),

    % ADD SNAKE HEAD %
    snakeHead(Head_L, Head_C),
    calculateIndex(Size, Head_L, Head_C, Index),
    setElemByIndex(List,Index, 1),

    % ADD SNAKE TAIL %
    snakeTail(Tail_L, Tail_C),
    calculateIndex(Size, Tail_L, Tail_C, Index1),
    setElemByIndex(List,Index1, 1),

    list_to_matrix(List, Size, Board),

    testHorizontalSum(Board),
    testVerticalSum(Board),
    testNeighboursSum(Board),
    testBoardConnection(Board),

    labeling([ffc], List).
