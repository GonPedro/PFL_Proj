:- use_module(library(lists)).

make_row(Lenght, Char, Row) :- 
            make_row(Lenght, Char, Row, []).

make_row(0, _, Row, Row).

make_row(Lenght, Char, Row, Sub) :- 
            Lenght > 0,
            Lenght1 is Lenght - 1,
            Sub1 = .(Char, Sub),
            make_row(Lenght1, Char, Row, Sub1).

make_cover_row(Lenght, Char, Row) :- 
            make_cover_row(Lenght, Char, Row, []).

make_cover_row(0, _, Row, Row).

make_cover_row(Lenght, Char, Row, Sub) :- 
            Lenght > 0,
            Lenght1 is Lenght - 1,
            Sub1 = .(Char, Sub),
            (
            Lenght1 == 1 -> make_cover_row(Lenght1, 'X', Row, Sub1)
            ;
            make_cover_row(Lenght1, ' ', Row, Sub1)
            ).

make_black_row(Lenght, Char, Row) :-
            make_black_row(Lenght, Char, Row, []).

make_black_row(0, _, Row, Row).

make_black_row(Lenght, Char, Row, Sub) :- 
            Lenght > 0,
            Lenght1 is Lenght - 1,
            Sub1 = .(Char, Sub),
            (
            Lenght1 == 6 -> make_black_row(Lenght1, 'P', Row, Sub1)
            ;
            Lenght1 == 2 -> make_black_row(Lenght1, 'T', Row, Sub1)
            ;
            Lenght1 == 4 -> make_black_row(Lenght1, 'K', Row, Sub1)
            ;
            make_black_row(Lenght1, ' ', Row, Sub1)
            ).

make_white_row(Lenght, Char, Row) :-
            make_white_row(Lenght, Char, Row, []).

make_white_row(0, _, Row, Row).

make_white_row(Lenght, Char, Row, Sub) :-
            Lenght > 0,
            Lenght1 is Lenght - 1,
            Sub1 = .(Char, Sub),
            (
            Lenght1 == 6 -> make_white_row(Lenght1, 'B', Row, Sub1)
            ;
            Lenght1 == 2 -> make_white_row(Lenght1, 'C', Row, Sub1)
            ;
            Lenght1 == 4 -> make_white_row(Lenght1, 'Q', Row, Sub1)
            ;
            make_white_row(Lenght1, ' ', Row, Sub1)
            ).

create_player_1(Player) :- Player = [['C', 1, 5], ['Q', 3, 5], ['B', 5, 5]].
create_player_2(Player) :- Player = [['T', 1, 1], ['K', 3, 1], ['P', 5, 1]].
create_blocked_list(Blocked) :- Blocked = [[0, 0], [6, 0], [0, 6], [6, 6]].

place_blocked_piece([X,Y]) :- assert(piece('X', X, Y)).
place_blocked_pieces([]).
place_blocked_pieces([H|T]) :-
            place_blocked_piece(H),
            place_blocked_pieces(T).

place_player_piece([T, X, Y]) :- assert(piece(T, X, Y)).
place_player_pieces([]).
place_player_pieces([H | T]) :-
            place_player_piece(H),
            place_player_pieces(T).
            

place_pieces(Blocked, Player1, Player2) :-
            place_blocked_pieces(Blocked),
            place_player_pieces(Player1),
            place_player_pieces(Player2).

place_initial_empty_pieces(_) :-
    assert(piece(' ', 1, 0)),
    assert(piece(' ', 2, 0)),
    assert(piece(' ', 3, 0)),
    assert(piece(' ', 4, 0)),
    assert(piece(' ', 5, 0)),
    assert(piece(' ', 0, 1)),
    assert(piece(' ', 2, 1)),
    assert(piece(' ', 4, 1)),
    assert(piece(' ', 6, 1)),
    assert(piece(' ', 0, 2)),
    assert(piece(' ', 1, 2)),
    assert(piece(' ', 2, 2)),
    assert(piece(' ', 3, 2)),
    assert(piece(' ', 4, 2)),
    assert(piece(' ', 5, 2)),
    assert(piece(' ', 6, 2)),
    assert(piece(' ', 0, 3)),
    assert(piece(' ', 1, 3)),
    assert(piece(' ', 2, 3)),
    assert(piece(' ', 3, 3)),
    assert(piece(' ', 4, 3)),
    assert(piece(' ', 5, 3)),
    assert(piece(' ', 6, 3)),
    assert(piece(' ', 0, 4)),
    assert(piece(' ', 1, 4)),
    assert(piece(' ', 2, 4)),
    assert(piece(' ', 3, 4)),
    assert(piece(' ', 4, 4)),
    assert(piece(' ', 5, 4)),
    assert(piece(' ', 6, 4)),
    assert(piece(' ', 0, 5)),
    assert(piece(' ', 2, 5)),
    assert(piece(' ', 4, 5)),
    assert(piece(' ', 6, 5)),
    assert(piece(' ', 1, 6)),
    assert(piece(' ', 2, 6)),
    assert(piece(' ', 3, 6)),
    assert(piece(' ', 4, 6)),
    assert(piece(' ', 5, 6)).
    
            
make_board(Lenght, Char, Board) :- make_board(Lenght, 'X', Board, []).
make_board(0, _, Board, Board).
make_board(Lenght, Char, Board, Sub) :- Lenght > 0, Lenght1 is Lenght - 1, (Lenght == 7 -> make_cover_row(7, Char, Row) ; Lenght == 6 -> make_white_row(7,' ',Row) ; Lenght == 2 -> make_black_row(7,' ',Row) ; Lenght == 1 -> make_cover_row(7, Char, Row) ; make_row(7, ' ', Row)), Sub1 = .(Row, Sub), make_board(Lenght1, Char, Board, Sub1).
initial_state(Lenght, Board) :- make_board(Lenght, 'X', Board), create_blocked_list(Blocked), place_blocked_pieces(Blocked).

