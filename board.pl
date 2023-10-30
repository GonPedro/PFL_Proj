:- use_module(library(lists)).

make_row(Lenght, Char, Row) :- make_row(Lenght, Char, Row, []).
make_row(0, _, Row, Row).
make_row(Lenght, Char, Row, Sub) :- Lenght > 0, Lenght1 is Lenght - 1, Sub1 = .(Char, Sub), make_row(Lenght1, Char, Row, Sub1).
make_cover_row(Lenght, Char, Row) :- make_cover_row(Lenght, Char, Row, []).
make_cover_row(0, _, Row, Row).
make_cover_row(Lenght, Char, Row, Sub) :- Lenght > 0, Lenght1 is Lenght - 1, Sub1 = .(Char, Sub), (Lenght1 == 1 -> make_cover_row(Lenght1, 'X', Row, Sub1) ; make_cover_row(Lenght1, ' ', Row, Sub1) ).
make_black_row(Lenght, Char, Row) :- make_black_row(Lenght, Char, Row, []).
make_black_row(0, _, Row, Row).
make_black_row(Lenght, Char, Row, Sub) :- Lenght > 0, Lenght1 is Lenght - 1, Sub1 = .(Char, Sub), (Lenght1 == 6 -> make_black_row(Lenght1, 'B', Row, Sub1) ; Lenght1 == 2 -> make_black_row(Lenght1, 'B', Row, Sub1) ; Lenght1 == 4 -> make_black_row(Lenght1, 'K', Row, Sub1) ; make_black_row(Lenght1, ' ', Row, Sub1)).
make_white_row(Lenght, Char, Row) :- make_white_row(Lenght, Char, Row, []).
make_white_row(0, _, Row, Row).
make_white_row(Lenght, Char, Row, Sub) :- Lenght > 0, Lenght1 is Lenght - 1, Sub1 = .(Char, Sub), (Lenght1 == 6 -> make_white_row(Lenght1, 'W', Row, Sub1) ; Lenght1 == 2 -> make_white_row(Lenght1, 'W', Row, Sub1) ; Lenght1 == 4 -> make_white_row(Lenght1, 'Q', Row, Sub1) ; make_white_row(Lenght1, ' ', Row, Sub1)).


make_board(Lenght, Char, Board) :- make_board(Lenght, 'X', Board, []).
make_board(0, _, Board, Board).
make_board(Lenght, Char, Board, Sub) :- Lenght > 0, Lenght1 is Lenght - 1, (Lenght == 7 -> make_cover_row(7, Char, Row) ; Lenght == 6 -> make_white_row(7,' ',Row) ; Lenght == 2 -> make_black_row(7,' ',Row) ; Lenght == 1 -> make_cover_row(7, Char, Row) ; make_row(7, ' ', Row)), Sub1 = .(Row, Sub), make_board(Lenght1, Char, Board, Sub1).
initial_state(Lenght, Board) :- make_board(Lenght, 'X', Board).

