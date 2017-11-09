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
	init_game,
	play,
	clean_players,
	clean_board,
	clean_board_res,
	!.

	%% TIRAR ISTO TUDO DAQUI E METER NUM CICLO
	%% RECURSIVO DENTRO DA Logic
	%%
	%% AQUI DEVEM SER CHAMADOS OS MENUS
