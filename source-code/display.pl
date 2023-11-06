:-use_module(library(lists)).

% base case for draw_board_header_names
draw_board_header_names(8).

% draw_board_header_names(+Number)
% Draws the horizontal header of the game board.
draw_board_header_names(Number) :- 
        Number < 8,
        write('  '),
        write(Number),
        write('  |'),
        N1 is Number+1,
        draw_board_header_names(N1).

% draw_board_header(+Size)
% Draws beginning of the horizontal header of the game board.
draw_board_header(Size) :- 
        write('      |'),
        draw_board_header_names(Size), nl.



% base case for draw_horizontal_limit
draw_horizontal_limit(0):- 
        write('+'), nl.

% draw_horizontal_limit(+Size)
% Draws the horizontal limits of the game board.
draw_horizontal_limit(Size) :- 
        write('+-----'),
        S1 is Size - 1,
        draw_horizontal_limit(S1).



% base case draw_empty_line
draw_empty_line(0) :- write('|'), nl.

% draw_empty_line(+Size)
% Draws an empty line for the game board.
draw_empty_line(Size) :- 
        write('|     '),
        S1 is Size - 1,
        draw_empty_line(S1).



% base case draw_values
draw_values([], N, _) :- 
        write('|  '),
        write(N),
        write('  |'), nl.

% draw_values(+List, +Number, +Counter)
% Draws the line containing a row of board values.
draw_values([H | T], N, C) :- 
        write('|  '),
        (
            C == 0 -> 
            write(N)
            ;
            write(H)
        ),
        write('  '),
        C1 is C + 1,
        (
            C == 0 ->
            draw_values([H|T], N, C1)
            ;
            draw_values(T, N, C1)
        ).



% base case for draw_board_row
draw_board_row([H | T], 1) :-
            draw_horizontal_limit(9),
            draw_empty_line(9),
            draw_values(H, 1, 0),
            draw_empty_line(9),
            draw_horizontal_limit(9).

% draw_board_row(+Row, +Number)
% Draws the row for the game board.
draw_board_row([H | T], N) :- N > 1,
            N1 is N-1,
            draw_horizontal_limit(9),
            draw_empty_line(9),
            draw_values(H, N, 0),
            draw_empty_line(9),
            draw_board_row(T, N1).



% draw_board(+Board)
% Draws the game board.
draw_board([H | T]) :- 
            draw_board_header(1),
            draw_board_row([H|T], 7),
            draw_board_header(1).

% Draws the header for the Shakti game.
draw_header:-
            write('|---------------------------------------------------------------------|'), nl,
            write('|-------------------------------Shakti--------------------------------|'), nl,
            write('|---------------------------------------------------------------------|'), nl.

% draw_player(+PlayerID)
% Draws the header for the player who has the turn to play.
draw_player(PlayerID):-
            write('|---------------------------------------------------------------------|'), nl,
            write('|-----------------------------Player '), write(PlayerID), write('--------------------------------|'), nl,
            write('|---------------------------------------------------------------------|'), nl.



% base case for draw_available_moves
draw_available_moves([H | []]) :-
            write(H), write('.'), nl.

% draw_available_moves(+Moves)
% Draws the available moves of a player
draw_available_moves([H | T]) :-
            T \== [],
            write(H), write(', '),
            draw_available_moves(T).



% game_over(+Board, +Winner)
% Displays the winner of the game.
game_over(Board, Winner) :-
        write('|-----------------------------Winner----------------------------------|'), nl,
        write('|-----------------------------Player----------------------------------|'), nl,
        write('|-------------------------------'), write(Winner), write('-------------------------------------|'), nl.
