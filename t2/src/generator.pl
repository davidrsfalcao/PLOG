generator:-
    repeat,
        write('Creating ...'),nl,
        cleanDynamicStuff,
        random(5,20, Size),
        randomSnakeBorders(Size),
        randomColumnRestrictions(Size),
        randomLineRestrictions(Size),
        randomAroundRestrictions(Size),
        time_out(solveProb(Size, Board),1000,Result),
        write(Result),nl,
        !,

    (Result = time_out -> generator; printMatrix(Board),cleanDynamicStuff, true).


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
    Max is integer(Size/3),
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

randomLineRestrictions(Size):-
    Max is integer(Size/3),
    random(0,Max, N),
    randomLineRestrictions(Size, N,0).

randomLineRestrictions(_,Total, Total).

randomLineRestrictions(Size,Total, I):-
    repeat,
        Max is integer(Size/2),
        random(0,Size, Line),
        \+ sumLine(Line,_),
        random(1,Max, Sum),
        asserta(sumLine(Line,Sum)),
        !,
    I1 is I+1,
    randomLineRestrictions(Size,Total, I1).

randomAroundRestrictions(Size):-
    Max is integer(Size/3),
    random(0,Max, N),
    randomAroundRestrictions(Size, N,0).

randomAroundRestrictions(_,Total, Total).

randomAroundRestrictions(Size,Total, I):-
    repeat,
        Max is 7,
        random(0,Size, Line),
        random(0,Size, Col),
        \+ sumAround(Line,Col,_),
        random(0,Max, Sum),
        asserta(sumAround(Line,Col, Sum)),
        !,
    I1 is I+1,
    randomAroundRestrictions(Size,Total, I1).
