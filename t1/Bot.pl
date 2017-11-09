:- use_module(library(random)).

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
bot_movement(PLAYER,PIECES,P1,DIRECTION_TO_MOV,TILES_TO_MOV):-    %chamar esta função para saber qual a peça a mover(P1),
  bot_select_piece(N_PIECE),                                      %qual a direção de movimento e quantas casas vai mover.
  nth1(N_PIECE,PIECES,PIECE),                                     %Recebe uma lista com as peças do jogador para definir que peça vai mover
  get_possible_directions(PIECE,POSSIBLE_DIR),
  get_movement_power(PLAYER,PIECE,MOVEMENT_POWER),
  bot_select_move(POSSIBLE_DIR,MOVEMENT_POWER,DIRECTION,MOV_POWER),
  P1 is PIECE,
  DIRECTION_TO_MOV is DIRECTION,
  TILES_TO_MOV is MOV_POWER.
