% replace: altera se possivel o contuedo do tabuleiro nas coordenadas X,Y
replace([L|Ls],0,X,Z,[R|Ls]):-replace_line(L,X,Z,R).
replace([L|Ls],Y,X,Z,[L|Rs]):-Y > 0, Y1 is Y-1, replace(Ls,Y1,X,Z,Rs).

replace_line([p|Cs],0,Z,[p|Cs]):-
  write('FALSE MOVE'),nl.
replace_line([b|Cs],0,Z,[b|Cs]):-
  write('FALSE MOVE'),nl.

replace_line([_|Cs],0,Z,[Z|Cs]).
replace_line([C|Cs],X,Z,[C|Rs]):-X > 0, X1 is X-1, replace_line(Cs,X1,Z,Rs).



%
return_value([L|Ls], X, 0, R):- return_value_line(L, X, R).
return_value([L|Ls], X, Y, R):- Y>0, Y1 is Y-1, return_value(Ls, X, Y1, R).

%
return_value_line([C|Cs], 0, C).
return_value_line([C|Cs], X, R):- X>0, X1 is X-1, return_value_line(Cs, X1, R).
