printMatrix([Head|Tail]):-
    write(Head),nl,
    printMatrix(Tail).

printMatrix([]).
