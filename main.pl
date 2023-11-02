:- consult(display).
:- consult(board).
:- consult(move).

clone([],[]).
clone([H|T],[H|Z]):- clone(T,Z).

draw :- initial_state(7, Board),
            create_blocked_list(Blocked),
            create_player_1(Player1),
            create_player_2(Player2),
            place_pieces(Blocked, Player1, Player2),
            draw_board(Board).

test :-
            create_blocked_list(Blocked),
            create_player_1(Player1),
            create_player_2(Player2),
            place_pieces(Blocked, Player1, Player2),
            place_initial_empty_pieces(1),
            valid_moves(Blocked, Player1, Valid),
            in_check('K', 4, 6, Valid).
            