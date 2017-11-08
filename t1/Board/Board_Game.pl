:- dynamic board/3.

create_board():-
    assert(board(1,1,'2_se')),
    assert(board(1,2,'null')),
    assert(board(1,3,'1_s')),
    assert(board(1,4,'null')),
    assert(board(1,5,'null')),
    assert(board(1,6,'null')),
    assert(board(1,7,'2_s')),
    assert(board(1,8,'null')),
    assert(board(1,9,'null')),

    assert(board(2,1,'null')),
    assert(board(2,2,'null')),
    assert(board(2,3,'null')),
    assert(board(2,4,'null')),
    assert(board(2,5,'null')),
    assert(board(2,6,'null')),
    assert(board(2,7,'null')),
    assert(board(2,8,'null')),
    assert(board(2,9,'null')),

    assert(board(3,1,'null')),
    assert(board(3,2,'null')),
    assert(board(3,3,'null')),
    assert(board(3,4,'null')),
    assert(board(3,5,'null')),
    assert(board(3,6,'null')),
    assert(board(3,7,'null')),
    assert(board(3,8,'null')),
    assert(board(3,9,'null')),

    assert(board(4,1,'null')),
    assert(board(4,2,'null')),
    assert(board(4,3,'null')),
    assert(board(4,4,'null')),
    assert(board(4,5,'null')),
    assert(board(4,6,'null')),
    assert(board(4,7,'null')),
    assert(board(4,8,'null')),
    assert(board(4,9,'null')),

    assert(board(5,1,'1_e')),
    assert(board(5,2,'null')),
    assert(board(5,3,'null')),
    assert(board(5,4,'null')),
    assert(board(5,5,'null')),
    assert(board(5,6,'null')),
    assert(board(5,7,'null')),
    assert(board(5,8,'null')),
    assert(board(5,9,'2_w')),

    assert(board(6,1,'null')),
    assert(board(6,2,'null')),
    assert(board(6,3,'null')),
    assert(board(6,4,'null')),
    assert(board(6,5,'null')),
    assert(board(6,6,'null')),
    assert(board(6,7,'null')),
    assert(board(6,8,'null')),
    assert(board(6,9,'null')),

    assert(board(7,1,'null')),
    assert(board(7,2,'null')),
    assert(board(7,3,'null')),
    assert(board(7,4,'null')),
    assert(board(7,5,'null')),
    assert(board(7,6,'null')),
    assert(board(7,7,'null')),
    assert(board(7,8,'null')),
    assert(board(7,9,'null')),

    assert(board(8,1,'null')),
    assert(board(8,2,'null')),
    assert(board(8,3,'null')),
    assert(board(8,4,'null')),
    assert(board(8,5,'null')),
    assert(board(8,6,'null')),
    assert(board(8,7,'null')),
    assert(board(8,8,'null')),
    assert(board(8,9,'null')),

    assert(board(9,1,'null')),
    assert(board(9,2,'null')),
    assert(board(9,3,'1_n')),
    assert(board(9,4,'null')),
    assert(board(9,5,'null')),
    assert(board(9,6,'null')),
    assert(board(9,7,'2_n')),
    assert(board(9,8,'null')),
    assert(board(9,9,'1_nw')).

clean_board():-
    retractall(board(_,_,_)).

% piece(name piece, player)
piece('1_n',1).
piece('1_s',1).
piece('1_e',1).
piece('1_w',1).
piece('1_ne',1).
piece('1_nw',1).
piece('1_se',1).
piece('1_sw',1).
piece('2_n',2).
piece('2_s',2).
piece('2_e',2).
piece('2_w',2).
piece('2_ne',2).
piece('2_nw',2).
piece('2_se',2).
piece('2_sw',2).

% direction(name piece, direction)
direction('1_n','n').
direction('1_s','s').
direction('1_e','e').
direction('1_w','w').
direction('1_ne','ne').
direction('1_nw','nw').
direction('1_se','se').
direction('1_sw','sw').
direction('2_n','n').
direction('2_s','s').
direction('2_e','e').
direction('2_w','w').
direction('2_ne','ne').
direction('2_nw',nw).
direction('2_se','se').
direction('2_sw','sw').