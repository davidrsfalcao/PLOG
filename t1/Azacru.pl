%:- include('Menus.pl').
:- include('Board/Board_Game.pl').
:- include('Board/Board_Results.pl').
:- include('Board/Interface.pl').
:- include('Board/Quadrants.pl').
:- include('Utils.pl').
%:- include('Logic.pl').


%                                %
%             Azacru             %
%                                %
%         write "azacru."        %
%     in the terminal to run     %
%                                %
%                                %



azacru :-
	create_board,
	create_board_res,
	display_board,
	clean_board,
	clean_board_res.
