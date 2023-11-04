:-use_module(library(lists)).

draw_board_header_names(0, _).
draw_board_header_names(Number, Charcode) :- Number > 0, char_code(Char, Charcode), write('  '), write(Char), write('  |'), N1 is Number-1, C1 is Charcode + 1, draw_board_header_names(N1, C1).
draw_board_header(Size) :- write('      '), write('|'), draw_board_header_names(Size, 97), nl.

draw_horizontal_limit(0):- write('+'), nl.
draw_horizontal_limit(Size) :- write('+-----'), S1 is Size - 1, draw_horizontal_limit(S1).

draw_empty_line(0) :- write('|'), nl.
draw_empty_line(Size) :- write('|     '), S1 is Size - 1, draw_empty_line(S1).

draw_values([], N, _) :- write('|  '), write(N), write('  |'), nl.
draw_values([H | T], N, C) :- write('|  '), (C == 0 -> write(N) ; write(H)), write('  '), C1 is C + 1, (C == 0 -> draw_values([H|T], N, C1) ; draw_values(T, N, C1)). 


draw_board_row([H | T], 1) :-
            draw_horizontal_limit(9),
            draw_empty_line(9),
            draw_values(H, 1, 0),
            draw_empty_line(9),
            draw_horizontal_limit(9).
draw_board_row([H | T], N) :- N > 1,
            N1 is N-1,
            draw_horizontal_limit(9),
            draw_empty_line(9),
            draw_values(H, N, 0),
            draw_empty_line(9),
            draw_board_row(T, N1).

draw_board([H | T]) :- 
            draw_board_header(7),
            draw_board_row([H|T], 7),
            draw_board_header(7).


draw_header:-
            write('|---------------------------------------------------------------------|'), nl,
            write('|-------------------------------Shakti--------------------------------|'), nl,
            write('|---------------------------------------------------------------------|'), nl.

draw_player(PlayerI):-
            write('|---------------------------------------------------------------------|'), nl,
            write('|-----------------------------Player '), write(PlayerI), write('--------------------------------|'), nl,
            write('|---------------------------------------------------------------------|'), nl.


draw_available_moves([H | []]) :-
            write(H), write('.'), nl.

draw_available_moves([H | T]) :-
            T \== [],
            write(H), write(', '),
            draw_available_moves(T).







