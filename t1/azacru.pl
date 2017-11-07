%:- include('Utils.pl').
%:- include('Menus.pl').
:- include('Board.pl').
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
	create_board(),
	display_board().
