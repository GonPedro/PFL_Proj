:- consult(display).
:- consult(board).

clone([],[]).
clone([H|T],[H|Z]):- clone(T,Z).

draw(_):- initial_state(7, Board),
            create_blocked_list(Blocked),
            create_player_1(Player1),
            create_player_2(Player2),
            place_pieces(Blocked, Player1, Player2),
            draw_board(Board).