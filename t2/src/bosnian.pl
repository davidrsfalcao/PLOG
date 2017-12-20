:-use_module(library(lists)).
:-use_module(library(clpfd)).
:- use_module(library(statistics)).
:-include('interface.pl').
:-include('logic.pl').
:-include('utils.pl').



start:-
    mainMenu(1),
    !.

mainMenu(EnableV):-
    clearScreen,
    write('    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('    %                                                             %'),nl,
    write('    %                      Bosnian Snake                          %'),nl,
    write('    %                                                             %'),nl,
    write('    %            1. Random Puzzle                                 %'),nl,
    write('    %            2. 9x9 Puzzle                                    %'),nl,
    write('    %            3. 12x12 Puzzle                                  %'),nl,
    printStatistictsStatus(EnableV),
    write('    %            5. Exit                                          %'),nl,
    write('    %                                                             %'),nl,
    write('    %                                                             %'),nl,
    write('    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    nl,nl,
    write('Please choose an option: '),
    repeat,
        get_char(R),
        %dá erro a partir daqui.
        (menu(R) ->
            (R == 5 ->
                !
                ;
                mainMenu(EnableV)

            )
            ;
            fail
        ),
    !.


% -----------------------------------------------------------------------
% Menu 1 - RANDOM PUZZLE
% -----------------------------------------------------------------------

    menu(X):-
      X==1,
      clearScreen,
      write('\t\t\tRANDOM PUZZLE '),
      newLine(15).

% -----------------------------------------------------------------------
% Menu 2 - 9X9 PUZZLE
% -----------------------------------------------------------------------

    menu(X):-
      X==2,
      clearScreen,
      write('\t\t\t9x9 PUZZLE '),
      newLine(15).

% -----------------------------------------------------------------------
% Menu 3 - 12X12 PUZZLE
% -----------------------------------------------------------------------

    menu(X):-
      X==3,
      clearScreen,
      write('\t\t\t12x12 PUZZLE '),
      newLine(15).

% -----------------------------------------------------------------------
% Menu 4 - STATISTICS
% -----------------------------------------------------------------------

    menu(X):-
      X==4,
      clearScreen,
      (EnableV == 0 ->
        EnableV1 is 1,
        mainMenu(EnableV1)
        ; EnableV1 is 0,
        mainMenu(EnableV1)).

% -----------------------------------------------------------------------
% Exit GAME
% -----------------------------------------------------------------------

    menu(X):-
      X==5,
      true.



printStatistictsStatus(EnableV):-
  (EnableV == 1 ->
    write('    %            4. Statistics:'),
    write('OFF                                %'),nl
    ;write('    %            4. Statistics:'),
    write('ON                                 %'),nl).





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

    testHorizontalSum(Mat),
    testVerticalSum(Mat),
    testNeighboursSum(Mat),
    testBoardConnection(Mat),


    labeling([ffc], Board),

    printMatrix(Mat),nl,
    print_time.
