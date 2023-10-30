:- consult(display).
:- consult(board).

clone([],[]).
clone([H|T],[H|Z]):- clone(T,Z).

draw(_):- initial_state(7, Board), draw_board(Board).