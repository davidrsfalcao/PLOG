:-include('interface.pl').
:-include('logic.pl').
:-include('utils.pl').
:-use_module(library(lists)).
:-use_module(library(clpfd)).
:- use_module(library(statistics)).


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
    reset_timer,
    Size is 6,
    Size1 is Size*Size,

    length(Board, Size1),
    domain(Board, 0,1),

    % ADD SNAKE HEAD %
    snakeHead(Head_L, Head_C),
    calculateIndex(Size, Head_L, Head_C, Index),
    setElemByIndex(Board,Index, 1),

    % ADD SNAKE TAIL %
    snakeTail(Tail_L, Tail_C),
    calculateIndex(Size, Tail_L, Tail_C, Index1),
    setElemByIndex(Board,Index1, 1),

    list_to_matrix(Board, Size, Mat),

    getElemsLine(Mat, 0, List),
    getElemsColumn(Mat, 3, List1),
    getElemsColumn(Mat, 0, List2),
    getElemsColumn(Mat, 4, List3),
    getElemsColumn(Mat, 5, List4),

    getElemsAround(Mat, 0, 0, Elems),
    
    sum(Elems, #=, 3),

    sum(List, #=, 4),
    sum(List1, #=, 4),
    sum(List2, #=, 2),
    sum(List3, #=, 1),
    sum(List4, #=, 1),
    labeling([], Board),

    printMatrix(Mat),nl,
    print_time.
