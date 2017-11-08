:- use_module(library(random)).

bot_select_piece(N_PIECE):-
  random_between(1,4,N_PIECE).

bot_select_move(POSSIBLE_DIR,MOVEMENT_POWER,DIRECTION,MOV_POWER):-
  random_between(1,3,DIR),
  nth1(DIR,POSSIBLE_DIR,DIRECTION),
  random(1,MOVEMENT_POWER,MOV_POWER).

get_movement_power(PLAYER,PIECE,MOVEMENT_POWER):-
    nth0(0,PIECE,L_ELEM),
    nth0(1,PIECE,C_ELEM),
    quadrant(Quad,L_ELEM,C_ELEM),
    power_movement(Quad,PLAYER,POWER_MOV),
    MOVEMENT_POWER is POWER_MOV.

get_possible_directions(PIECE,POSSIBLE_DIR):-
  nth0(0,PIECE,L_ELEM),
  nth0(1,PIECE,C_ELEM),
  board(L_ELEM,C_ELEM,P),
  direction(P,DIR),
  possible_directions(DIR,DIRP1,DIRP2),
  append(POSSIBLE_DIR_A,DIR),
  append(POSSIBLE_DIR_A,DIR1),
  append(POSSIBLE_DIR_A,DIR2),
  POSSIBLE_DIR is POSSIBLE_DIR_A.


bot_movement(PIECES):-
  bot_select_piece(N_PIECE),
  nth1(N_PIECE,PIECES,PIECE),
  get_possible_directions(PIECE,POSSIBLE_DIR,NUM_POSSIBLE_DIR),
  get_movement_power(PLAYER,PIECE,MOVEMENT_POWER),
  bot_select_move(POSSIBLE_DIR,MOVEMENT_POWER,DIRECTION,MOV_POWER),
  move_piece_bot(PIECE,DIRECTION,MOV_POWER).

possible_directions('n','ne','no').
possible_directions('ne','n','e').
possible_directions('e','ne','se').
possible_directions('se','s','e').
possible_directions('s','se','so').
possible_directions('so','s','o').
possible_directions('o','so','no').
possible_directions('no','n','o').

move_piece_bot(PIECE,DIRECTION,MOV_POWER):-
  %move a peça([line,column]) numa determinada direção com um determinado poder de movimento
  
