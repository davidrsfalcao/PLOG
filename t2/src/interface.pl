printMatrix(Board,-1,_):-
    printRowMatrix(Board, -1, -1),
    nl,
    length(Board, Size),
    printHorizontalDivision(Size),
    printMatrix(Board, 0, -1).


printMatrix([Head|Tail],Line,Column):-
    printRowMatrix(Head, Line, Column),
    write('|'),nl,
    length(Head, Size),
    printHorizontalDivision(Size),
    Line1 is Line+1,
    printMatrix(Tail, Line1, -1).

printMatrix([],_,_).

printRowMatrix([],_,_).

printRowMatrix(Board, Line,-1):-
    sumLine(Line,Sum),
    Sum < 10,
    write(Sum),
    write('  '),
    printRowMatrix(Board, Line, 0).

printRowMatrix(Board, Line,-1):-
    sumLine(Line,Sum),
    write(Sum),
    write('   '),
    printRowMatrix(Board, Line, 0).

printRowMatrix(Board, Line,-1):-
    write('   '),
    printRowMatrix(Board, Line, 0).

printRowMatrix([_|Tail],Line,Column):-
    checkBorders(Line,Column),
    write('|OOO'),
    C1 is Column+1,
    printRowMatrix(Tail, Line, C1).

printRowMatrix([_|Tail],Line,Column):-
    sumAround(Line, Column, Sum),
    write('| '),
    write(Sum),
    write(' '),
    C1 is Column+1,
    printRowMatrix(Tail, Line, C1).

printRowMatrix([Head|Tail],Line,Column):-
    Head = 0,
    write('|   '),
    C1 is Column+1,
    printRowMatrix(Tail, Line, C1).

printRowMatrix([Head|Tail],Line,Column):-
    Head = 1,
    write('|XXX'),
    C1 is Column+1,
    printRowMatrix(Tail, Line, C1).

printRowMatrix([_|Tail],-1,Column):-
    sumCol(Column,Sum),
    write('  '),
    write(Sum),
    write(' '),
    C1 is Column+1,
    printRowMatrix(Tail,-1, C1).

printRowMatrix([_|Tail],-1,Column):-
    write('    '),
    C1 is Column+1,
    printRowMatrix(Tail,-1, C1).

printRowMatrix(Board,-1,-1):-
    write(' '),
    printRowMatrix(Board,-1, 0).

printHorizontalDivision(Length):-
    write('   |'),
    Length1 is Length*4,
    printHorizontalDivision(Length1, 1).

printHorizontalDivision(Length, Length):-
    write('|'),nl.

printHorizontalDivision(Length, I):-
    write('-'),
    I1 is I+1,
    printHorizontalDivision(Length, I1).
