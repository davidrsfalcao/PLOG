printMatrix([Head|Tail]):-
    printRowMatrix(Head),
    write('|'),nl,
    printMatrix(Tail).

printMatrix([]).

printRowMatrix([]).

printRowMatrix([Head|Tail]):-
    Head = 0,
    write('| '),
    printRowMatrix(Tail).

printRowMatrix([Head|Tail]):-
    Head = 1,
    write('|X'),
    printRowMatrix(Tail).
