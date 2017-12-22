gen(Size):-
    reset_timer,
    repeat,
        write('Mais uma voltinha'),nl,
        cleanDynamicStuff,
        random(5,20, Size),
        randomSnakeBorders(Size),
        randomColumnRestrictions(Size),
        write('criando'),nl,
        solveProb(Size, Board),
        printMatrix(Board),
        !,

    %%%%% CLEAN THIS LATER
    cleanDynamicStuff.



cleanDynamicStuff:-
    retractall(sumLine(_,_)),
    retractall(sumCol(_,_)),
    retractall(sumAround(_,_,_)),
    retractall(snakeHead(_,_)),
    retractall(snakeTail(_,_)).



randomSnakeBorders(Size):-
    random(0, Size, L1),
    random(0, Size, C1),
    random(0, Size, L2),
    random(0, Size, C2),
    asserta(snakeHead(L1,C1)),
    asserta(snakeTail(L2,C2)).

randomColumnRestrictions(Size):-
    Max is 4,
    random(0,Max, N),
    randomColumnRestrictions(Size, N,0).

randomColumnRestrictions(_,Total, Total).

randomColumnRestrictions(Size,Total, I):-
    repeat,
        Max is integer(Size/2),
        random(0,Size, Col),
        \+ sumCol(Col,_),
        random(1,Max, Sum),
        asserta(sumCol(Col,Sum)),
        !,
    I1 is I+1,
    randomColumnRestrictions(Size,Total, I1).
