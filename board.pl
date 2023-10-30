:- use_module(library(lists)).

draw_columns_name_section(Number, CharCode):- Number > 0, char_code(Char, CharCode), write('   '), write(Char), write('  '), NextCharCode is (CharCode + 1), draw_columns_name_section(Number - 1, NextCharCode).
draw_columns_name(Length):- draw_columns_name_section(Length, 97), nl. % Draws "A B C D E".

draw_horizontal_delimiter([]):- write('+'), nl.
draw_horizontal_delimiter([H | T]):- write('+-----'), draw_horizontal_delimiter(T).

draw_box_limit([]):- write('|'), nl.
draw_box_limit([H | T]):- write('|     '), draw_box_limit(T).

draw_board_values([], Number):- write('|  '), write(Number), nl.
draw_board_values([H | T], Number):- write('|  '), write(H), write('  '), draw_board_values(T, Number).

draw_board_section([], _):- draw_horizontal_delimiter(H).
draw_board_section([H | T], 1):- draw_horizontal_delimiter(H), 
    draw_box_limit(H), 
    draw_board_values(H, 1),
    draw_box_limit(H),
    draw_horizontal_delimiter(H).

draw_board_section([H | T], Num):- Num > 1, NextNum is Num - 1,
    draw_horizontal_delimiter(H), 
    draw_box_limit(H), 
    draw_board_values(H, Num),
    draw_box_limit(H),
    draw_board_section(T, NextNum).

draw_board([H | T]):- Board = .(H, T), length(H, Length), length(Board, Height), 
    draw_board_section(Board, Height), nl, 
    draw_columns_name(Length).

draw_turn_player(TurnPlayer):- write('It is your turn, '), write(TurnPlayer), write('!'), nl.
display_game(Board, TurnPlayer):- draw_board(Board), nl, draw_turn_player(TurnPlayer), nl.