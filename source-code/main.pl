:- consult(display).
:- consult(board).
:- consult(input).
:- consult(random_bot).

clone([],[]).
clone([H|T],[H|Z]):- clone(T,Z).

test:-
        test_place,
        valid_moves([], [['T', 2, 7], ['K', 4, 6], ['P', 6, 6]], Valid).

            

process_player_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerI) :-
            get_movement_piece(P, PlayerI),
            get_movement_x(X),
            get_movement_y(Y),
            (
                move(Board, [P, X, Y], Valid, Board1) ->
                Player is PlayerI + 1,
                New_player is Player mod 2,
                update_player(Curr_player, New_curr),
                update_player(Opp_player, New_opp),
                (
                    Bl == 0 ->
                    pvp(Board1, New_opp, New_curr, New_player)
                    ;
                    pvc(Board1, New_opp, New_curr, New_player, 1)
                )
                ;
                write('Invalid Move!'), nl,
                process_player_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerI)
            ).



process_computer_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerI) :-
            choose_move(Valid, Bl, Move),
            (
                move(Board, Move, Valid, Board1) ->
                Player is PlayerI + 1,
                New_player is Player mod 2,
                update_player(Curr_player, New_curr),
                update_player(Opp_player, New_opp),
                pvc(Board1, New_opp, New_curr, New_player, Bl)
                ;
                write('Invalid Move!'), nl,
                process_computer_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerI)
            ).

pvp(Board, Curr_player, Opp_player, PlayerI):-
            Player is PlayerI + 1,
            draw_player(Player),
            draw_board(Board),
            valid_moves(Board, Curr_player, Valid),
            (
                check_mate(Valid) ->
                F1 is Player mod 2,
                Winner is F1 + 1,
                game_over(Board, Winner),
                retractall(piece(_,_,_))
                ;
                write('Here are your available moves:'), nl,
                draw_available_moves(Valid),
                process_player_mov(Board, Curr_player, Opp_player, Valid, 0, PlayerI)
            ).

pvc(Board, Curr_player, Opp_player, PlayerI, Bl):-
            (
                PlayerI == 0 ->
                Player is PlayerI + 1,
                draw_player(Player),
                draw_board(Board),
                valid_moves(Board, Curr_player, Valid),
                (
                    check_mate(Valid) ->
                    F1 is Player mod 2,
                    Winner is F1 + 1,
                    game_over(Board, Winner),
                    retractall(piece(_,_,_))
                    ;
                    write('Here are your available moves:'), nl,
                    draw_available_moves(Valid),
                    process_player_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerI)
                )
                ;
                valid_moves(Board, Curr_player, Valid),
                (
                    check_mate(Valid) ->
                    F1 is Player mod 2,
                    Winner is F1 + 1,
                    game_over(Board, Winner),
                    retractall(piece(_,_,_))
                    ;
                    process_computer_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerI)
                )

            ).

cvc(Board, Curr_player, Opp_player, PlayerI, Bl1, Bl2):-
            draw_board(Board),
            valid_moves(Board, Curr_player, Valid),
            Player is PlayerI + 1,
            (
                check_mate(Valid) ->
                F1 is Player mod 2,
                Winner is F1 + 1,
                game_over(Board, Winner),
                retractall(piece(_,_,_))
                ;
                choose_move(Valid, Bl1, Move),
                move(Board, Move, Valid, Board1),
                New_player is Player mod 2,
                update_player(Curr_player, New_curr),
                cvc(Board1, Opp_player, New_curr, New_player, Bl2, Bl1)
            ).
            

play:-
            draw_header,
            write('Welcome to Shakti!'), nl,
            get_gamemode(Gm),
            initial_state(7, Board),
            create_blocked_list(Blocked),
            create_player_1(Player1),
            create_player_2(Player2),
            place_pieces(Blocked, Player1, Player2),
            place_initial_empty_pieces,
            (
                Gm == 1 ->
                pvp(Board, Player1, Player2, 0)
                ;
                Gm == 2 ->
                get_computer_level(Bl),
                pvc(Board, Player1, Player2, 0, Bl)
                ;
                Gm == 3 ->
                get_computer_level(Bl1),
                get_computer_level(Bl2),
                cvc(Board, Player1, Player2, 0, Bl1, Bl2)
                ;
                fail
            ).