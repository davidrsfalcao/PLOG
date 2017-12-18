:-include('interface.pl').
:-include('logic.pl').
:-include('utils.pl').
:-use_module(library(lists)).
:-use_module(library(clpfd)).


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
    Size is 6,
    Size1 is Size*Size,

    length(Board, Size1),
    domain(Board, 0,1),
    calculateSumCol(Board, Size, 0, Sum),
    Sum #= 3,
    labeling([], Board),
    list_to_matrix(Board, Size, Mat),
    printMatrix(Mat),nl.
