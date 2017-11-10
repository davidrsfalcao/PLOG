:- use_module(library(random)).


nb_getval(list_movements,LISTAG).

list_pieces_player(PLAYER,LISTAG,PIECES):-
  COUNT = 0,
  length(LISTAG,T_LISTAG),
  repeat,
    (COUNT < T_LISTAG->
      nth0(COUNT,LISTAG,LISTP),
      nth0(0,LISTP,PLY),
      (PLY == PLAYER ->
        nth0(1,LISTP,L_ACT),
        nth0(2,LISTP,C_ACT),
        check_already_exists(L_T,C_T,PIECES,E),
        (E == 0 ->
          P1 is [L_ACT,C_ACT],
          append(PIECES,P1),
          COUNT is COUNT +1,
          fail
          ;COUNT is COUNT +1,
          fail
         )
      ;COUNT is COUNT + 1,
        fail
      )
    ;!.

check_already_exists(L_T,C_T,PIECES,E):-
  COUNT = 0,
  length(PIECES,T),
  repeat,
    (COUNT < T ->
      nth0(COUNT,PIECES,P1),
      nth0(0,P1,L),
      nth0(1,P1,C),
      (L_T == L,C_T == C ->
        E is 1,
        !
        ;COUNT is COUNT +1,
        fail
        )
    ; E is 0,
      !.


bot_select_piece(N_PIECE):-         %retorna o index da peça numa lista de peças
  random_between(1,4,N_PIECE).

bot_select_move(POSSIBLE_DIR,MOVEMENT_POWER,DIRECTION,MOV_POWER):-
  random_between(1,3,DIR),                   %Recebe uma lista de possiveis direções e o poder de movimento da peça
  nth1(DIR,POSSIBLE_DIR,DIRECTION),          % e retorna a direção para a qual se vai mover e quantas casas
  random(1,MOVEMENT_POWER,MOV_POWER).

get_movement_power(PLAYER,PIECE,MOVEMENT_POWER):-  %Recebe o player e a PIECE(array lista e coluna) e retorna o poder de moviento da peça
    nth0(0,PIECE,L_ELEM),
    nth0(1,PIECE,C_ELEM),
    quadrant(Quad,L_ELEM,C_ELEM),
    power_movement(Quad,PLAYER,POWER_MOV),
    MOVEMENT_POWER is POWER_MOV.

get_possible_directions(PIECE,POSSIBLE_DIR):-  %Recebe a PIECE(array lista e coluna) e retorna uma lista de possiveis direções
  nth0(0,PIECE,L_ELEM),
  nth0(1,PIECE,C_ELEM),
  board(L_ELEM,C_ELEM,P),
  direction(P,DIR),
  possible_directions(DIR,DIRP1,DIRP2),
  append(POSSIBLE_DIR_A,DIR),
  append(POSSIBLE_DIR_A,DIR1),
  append(POSSIBLE_DIR_A,DIR2),
  POSSIBLE_DIR is POSSIBLE_DIR_A.

%recebe o PLAYER e uma lista com as peças do PLAYER(array lista e coluna) e retorna a peça,a direção a mover e quantas casas
bot_movement(PLAYER,P1,DIRECTION_TO_MOV,TILES_TO_MOV):-    %chamar esta função para saber qual a peça a mover(P1),
  bot_select_piece(N_PIECE),                                      %qual a direção de movimento e quantas casas vai mover.
  list_pieces_player(PLAYER,LISTAG,PIECES)                        %Recebe uma lista com as peças do jogador para definir que peça vai mover
  nth1(N_PIECE,PIECES,PIECE),
  get_possible_directions(PIECE,POSSIBLE_DIR),
  get_movement_power(PLAYER,PIECE,MOVEMENT_POWER),
  bot_select_move(POSSIBLE_DIR,MOVEMENT_POWER,DIRECTION,MOV_POWER),
  P1 is PIECE,
  DIRECTION_TO_MOV is DIRECTION,
  TILES_TO_MOV is MOV_POWER.
