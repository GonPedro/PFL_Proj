:- use_module(library(system)).
:- consult(display).
:- consult(board).
:- consult(input).
:- consult(random_bot).

% process_player_mov(+Board, +Curr_player, +Opp_player, +Valid, +Bl, +PlayerID)
% Processes the player's move on the game board and updates the game state accordingly.
process_player_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerID) :-
            get_movement_piece(P, PlayerID),
            get_movement_x(X),
            get_movement_y(Y),
            (
                move(Board, [P, X, Y], Valid, Board1) ->
                Player is PlayerID + 1,
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
                process_player_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerID)
            ).

% process_computer_mov(+Board, +Curr_player, +Opp_player, +Valid, +Bl, +PlayerID)
% Processes the computer-generated move on the game board and updates the game state accordingly.
process_computer_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerID) :-
            choose_move(Valid, Bl, Move),
            (
                move(Board, Move, Valid, Board1) ->
                Player is PlayerID + 1,
                New_player is Player mod 2,
                update_player(Curr_player, New_curr),
                update_player(Opp_player, New_opp),
                pvc(Board1, New_opp, New_curr, New_player, Bl)
                ;
                write('Invalid Move!'), nl,
                process_computer_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerID)
            ).

% pvp(+Board, +Curr_player, +Opp_player, +PlayerID)
% Creates a player vs player game loop.
pvp(Board, Curr_player, Opp_player, PlayerID):-
            Player is PlayerID + 1,
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
                process_player_mov(Board, Curr_player, Opp_player, Valid, 0, PlayerID)
            ).

% pvc(+Board, +Curr_player, +Opp_player, +PlayerID, +Bl)
% Creates a player vs computer game loop.
pvc(Board, Curr_player, Opp_player, PlayerID, Bl):-
            Player is PlayerID + 1,
            (
                PlayerID == 0 ->
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
                    process_player_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerID)
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
                    process_computer_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerID)
                )
            ).

% cvc(+Board, +Curr_player, +Opp_player, +PlayerID, +Bl1, +Bl2)
% Creates a computer vs computer game loop.
cvc(Board, Curr_player, Opp_player, PlayerID, Bl1, Bl2):-
            Player is PlayerID + 1,
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
                choose_move(Valid, Bl1, Move),
                move(Board, Move, Valid, Board1),
                New_player is Player mod 2,
                update_player(Curr_player, New_curr),
                sleep(2),
                cvc(Board1, Opp_player, New_curr, New_player, Bl2, Bl1)
            ).
            
% Initiates the game of Shakti.
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