:-include('interface.pl').
:-include('logic.pl').
:-include('utils.pl').
:-use_module(library(lists)).


start:-
    menu,
    !.

menu:-
    clearScreen,
    write('    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('    %                                                             %'),nl,
    write('    %                      Bosnian Snake                          %'),nl,
    write('    %                                                             %'),nl,
    write('    %            1. Random Puzzle                                 %'),nl,
    write('    %            2. 9x9 Puzzle                                    %'),nl,
    write('    %            3. 12x12 Puzzle                                  %'),nl,
    printStatistictsStatus,
    write('    %            5. Exit                                          %'),nl,
    write('    %                                                             %'),nl,
    write('    %                                                             %'),nl,
    write('    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    nl,nl,nl.


printStatistictsStatus:-
    write('    %            4. Statistics: OFF                               %'),nl.


test:-
    default_board(Board),
    %%calculateSumLine(Board, 9, Sum),
    calculateSumCol(Board, 5, Sum),
    write(Sum),nl.
