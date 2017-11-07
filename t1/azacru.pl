:- include('Menus.pl').
:- include('Board.pl').


%                                %
%             Azacru             %
%                                %
%         write "azacru."        %
%     in the terminal to run     %
%                                %
%                                %


azacru :-
	cleanScreen,
	mainMenu.
