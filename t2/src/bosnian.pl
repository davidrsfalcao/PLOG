:-use_module(library(lists)).
:-use_module(library(clpfd)).
:-use_module(library(statistics)).
:-use_module(library(random)).
:-use_module(library(timeout)).
:-include('interface.pl').
:-include('logic.pl').
:-include('utils.pl').
:-include('generator.pl').


start:-
    mainMenu(0),
    !.

mainMenu(EnableV):-
    clearScreen,
    write('    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('    %                                                             %'),nl,
    write('    %                      Bosnian Snake                          %'),nl,
    write('    %                                                             %'),nl,
    write('    %            1. Random Puzzle                                 %'),nl,
    write('    %            2. 6x6 Puzzle                                    %'),nl,
    write('    %            3. 9x9 Puzzle                                    %'),nl,
    printStatistictsStatus(EnableV),
    write('    %            5. Exit                                          %'),nl,
    write('    %                                                             %'),nl,
    write('    %                                                             %'),nl,
    write('    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    nl,nl,
    write('Please choose an option: '),
    read(R),
    menu(R, EnableV).

% -----------------------------------------------------------------------
% Menu 1 - RANDOM PUZZLE
% -----------------------------------------------------------------------

menu(X, Stats):-
    X==1,
    clearScreen,
    generator,
    !.

% -----------------------------------------------------------------------
% Menu 2 - 6X6 PUZZLE
% -----------------------------------------------------------------------

menu(X, Stats):-
    X==2,
    clearScreen,
    asserta(sumLine(1,2)),
    asserta(sumLine(4,1)),
    asserta(sumAround(2,4,6)),
    asserta(sumAround(3,1,6)),
    asserta(snakeHead(0,0)),
    asserta(snakeTail(5,5)),
    solver(6, Stats),
    cleanDynamicStuff.

% -----------------------------------------------------------------------
% Menu 3 - 9X9 PUZZLE
% -----------------------------------------------------------------------

menu(X,Stats):-
    X==3,
    clearScreen,
    asserta(snakeHead(3,3)),
    asserta(snakeTail(5,5)),
    asserta(sumCol(6,4)),
    asserta(sumCol(2,6)),
    asserta(sumAround(2,6,1)),
    asserta(sumAround(0,3,3)),
    asserta(sumAround(6,2,5)),
    asserta(sumAround(8,5,2)),
    solver(9,Stats),
    cleanDynamicStuff.

% -----------------------------------------------------------------------
% Menu 4 - STATISTICS
% -----------------------------------------------------------------------

menu(X, EnableV):-
    X==4,
    EnableV1 is mod(EnableV+1,2),
    mainMenu(EnableV1).

% -----------------------------------------------------------------------
% Exit GAME
% -----------------------------------------------------------------------

menu(X, _):-
    X==5,
    true.

% -----------------------------------------------------------------------
% Invalid Option
% -----------------------------------------------------------------------
menu(_, _):-
    mainMenu(_).

% Print statistics status
printStatistictsStatus(0):-
    write('    %            4. Statistics: OFF                               %'),nl.

printStatistictsStatus(1):-
    write('    %            4. Statistics: ON                                %'),nl.

% Print statistics
printStatisticts(1):-
    fd_statistics.

printStatisticts(_).

% Solves the problem and displays the solution
solver(Size, Statistics):-
    solveProb(Size, Board),
    printMatrix(Board),nl,
    printStatisticts(Statistics),
    print_time.
