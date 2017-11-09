%:- include('Menus.pl').
:- include('Board/Board_Game.pl').
:- include('Board/Board_Results.pl').
:- include('Board/Interface.pl').
:- include('Board/Quadrants.pl').
:- include('Utils.pl').
:- include('Logic.pl').


%                                %
%             Azacru             %
%                                %
%         write "azacru."        %
%     in the terminal to run     %
%                                %
%                                %



azacru :-
	assert(player(1,'HUMAN')),
	assert(player(2,'HUMAN')),
	create_board,
	create_board_res,
	show_board,
	choose_piece(1,LINE, COLUMN),
	move_piece(1, LINE, COLUMN),
	show_board,
	clean_players,
	clean_board,
	clean_board_res,
	!.
