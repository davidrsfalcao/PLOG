
% -----------------------------------------------------------------------
% Main Menu
% -----------------------------------------------------------------------


mainMenu:-
    clearScreen,
    write(' ______________________________________________________________________________ '),nl,
    write('|                                                                              |'),nl,
    write('|                                                                              |'),nl,
    write('|                     ______               ______    _____   _    _            |'),nl,
    write('|              \\     |___   |      \\      |   ___|  |  _  | | |  | |           |'),nl,
    write('|             _ \\       /  /      _ \\     |  |      |   __| | |  | |           |'),nl,
    write('|            ___ \\    /   /_     ___ \\    |  |___   | || \\  | |__| |           |'),nl,
    write('|          _/    _\\  |______|  _/    _\\   |______|  |_||__\\ |______|           |'),nl,
    write('|                                                                              |'),nl,
    write('|                                                                              |'),nl,
    write('|                                                                              |'),nl,
    write('|                              1 - Player vs Player                            |'),nl,
    write('|                              2 - Player vs CPU                               |'),nl,
    write('|                              3 - CPU vs CPU                                  |'),nl,
    write('|                              4 - How To Play                                 |'),nl,
    write('|                              5 - Exit Game                                   |'),nl,
    write('|                                                                              |'),nl,
    write('|                                                                              |'),nl,
    write('|______________________________________________________________________________|'),nl,
    nl,nl,
    write('Please choose an option: '),
    get_single_char(R),
    ascii_to_dec(R,R1),
    (menu(R1) ->
        mainMenu
        ;
        true
    ),
    !.



% -----------------------------------------------------------------------
% Menu 1 - PLAYER(BLACK) VS PLAYER(WHITE)
% -----------------------------------------------------------------------

menu(X):-
    X==1,
    clearScreen,
    write('\t\t\tPLAYER 1 (WHITE) VS PLAYER 2 (BLACK) '),
    newLine(15),
    sleep(3),
    assert(player(1,'HUMAN')),
    assert(player(2,'HUMAN')),
    play.


% -----------------------------------------------------------------------
% Menu 2 - PLAYER(BLACK) VS CPU(WHITE)
% -----------------------------------------------------------------------

menu(X):-
    X==2,
    clearScreen,
    write('\t\t\tPLAYER 1 (WHITE) VS CPU (BLACK) '),
    newLine(15),
    sleep(3),
    assert(player(1,'HUMAN')),
    assert(player(2,'BOT')),
    play.
% -----------------------------------------------------------------------
% MENU 3 - CPU(BLACK) VS CPU(WHITE)
% -----------------------------------------------------------------------

menu(X):-
    X==3,
    clearScreen,
    write('\t\t\tCPU (WHITE) VS CPU (BLACK) '),
    newLine(15),
    sleep(3),
    assert(player(1,'BOT')),
    assert(player(2,'BOT')),
    play.

% -----------------------------------------------------------------------
% MENU 4 - HOW TO PLAY
% -----------------------------------------------------------------------

menu(X):-
    X==4,
    clearScreen,
    write(' ______________________________________________________________________________ '),nl,
    write('|                                HOW TO PLAY                                   |'),nl,
    write('|                                                                              |'),nl,
    write('|                                                                              |'),nl,
    write('|                                                                              |'),nl,
    write('|  Get more pieces of your color all over the board to win.                    |'),nl,
    write('|  Choose which piece you want to move and where to move it.                   |'),nl,
    write('|  Everytime you "eat" an opponent piece your arrow will disappear.            |'),nl,
    write('|  When one of the players have no more pieces,the other can only make one     |'),nl,
    write('| more round.                                                                  |'),nl,
    write('|  You can move the number of tiles you have in the quadrant you are in.       |'),nl,
    write('|                                                                              |'),nl,
    write('|                                                                              |'),nl,
    write('|                                                                              |'),nl,
    write('| 1 - return                                                                   |'),nl,
    write('|                                                                              |'),nl,
    write('|                                                                              |'),nl,
    write('|______________________________________________________________________________|'),nl,
    nl,nl,nl,
    get_single_char(R),
    ascii_to_dec(R,R1),
    ( R1 == 1 ->
        mainMenu
        ;
        menu(4)
    ).

% -----------------------------------------------------------------------
% Exit GAME
% -----------------------------------------------------------------------

menu(X):-
    X==5,
    menu(9999),
    true.
