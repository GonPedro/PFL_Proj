:- consult(display).
:- consult(board).
:- consult(move).
:- consult(input).

clone([],[]).
clone([H|T],[H|Z]):- clone(T,Z).

draw :- initial_state(7, Board),
            create_blocked_list(Blocked),
            create_player_1(Player1),
            create_player_2(Player2),
            place_pieces(Blocked, Player1, Player2),
            place_initial_empty_pieces,
            draw_board(Board),
            update_board(Board1, 1),
            draw_board(Board1).

test :-
            create_blocked_list(Blocked),
            create_player_1(Player1),
            create_player_2(Player2),
            place_pieces(Blocked, Player1, Player2),
            place_initial_empty_pieces,
            valid_moves(Blocked, Player1, Valid),
            write(Valid), nl.
            

play:-
            draw_header,
            write('Welcome to Shakti!'), nl,
            get_gamemode(Gm),
            (
                Gm == 2 ->
                get_computer_level(Bl)
                ;
                Gm == 3 ->
                get_computer_level(Bl1),
                get_computer_level(Bl2)
                %-gameloop em tudo agora
            ).