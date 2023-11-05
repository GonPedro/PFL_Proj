:- use_module(library(lists)).
:- consult(move).

:- dynamic piece/3.

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

create_player_1(Player) :- Player = [['C', 2, 2], ['Q', 4, 2], ['B', 6, 2]].
create_player_2(Player) :- Player = [['T', 2, 6], ['K', 4, 6], ['P', 6, 6]].
create_blocked_list(Blocked) :- Blocked = [[1, 1], [7, 1], [1, 7], [7, 7]].

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

place_initial_empty_pieces :-
    assert(piece(' ', 2, 1)),
    assert(piece(' ', 3, 1)),
    assert(piece(' ', 4, 1)),
    assert(piece(' ', 5, 1)),
    assert(piece(' ', 6, 1)),
    assert(piece(' ', 1, 2)),
    assert(piece(' ', 3, 2)),
    assert(piece(' ', 5, 2)),
    assert(piece(' ', 7, 2)),
    assert(piece(' ', 1, 3)),
    assert(piece(' ', 2, 3)),
    assert(piece(' ', 3, 3)),
    assert(piece(' ', 4, 3)),
    assert(piece(' ', 5, 3)),
    assert(piece(' ', 6, 3)),
    assert(piece(' ', 7, 3)),
    assert(piece(' ', 1, 4)),
    assert(piece(' ', 2, 4)),
    assert(piece(' ', 3, 4)),
    assert(piece(' ', 4, 4)),
    assert(piece(' ', 5, 4)),
    assert(piece(' ', 6, 4)),
    assert(piece(' ', 7, 4)),
    assert(piece(' ', 1, 5)),
    assert(piece(' ', 2, 5)),
    assert(piece(' ', 3, 5)),
    assert(piece(' ', 4, 5)),
    assert(piece(' ', 5, 5)),
    assert(piece(' ', 6, 5)),
    assert(piece(' ', 7, 5)),
    assert(piece(' ', 1, 6)),
    assert(piece(' ', 3, 6)),
    assert(piece(' ', 5, 6)),
    assert(piece(' ', 7, 6)),
    assert(piece(' ', 2, 7)),
    assert(piece(' ', 3, 7)),
    assert(piece(' ', 4, 7)),
    assert(piece(' ', 5, 7)),
    assert(piece(' ', 6, 7)).

test_place :-
    assert(piece('X', 1, 1)),
    assert(piece(' ', 2, 1)),
    assert(piece(' ', 3, 1)),
    assert(piece(' ', 4, 1)),
    assert(piece(' ', 5, 1)),
    assert(piece(' ', 6, 1)),
    assert(piece('X', 7, 1)),
    assert(piece(' ', 1, 2)),
    assert(piece(' ', 2, 2)),
    assert(piece(' ', 3, 2)),
    assert(piece('Q', 4, 2)),
    assert(piece(' ', 5, 2)),
    assert(piece('B', 6, 2)),
    assert(piece(' ', 7, 2)),
    assert(piece(' ', 1, 3)),
    assert(piece(' ', 2, 3)),
    assert(piece('X', 3, 3)),
    assert(piece(' ', 4, 3)),
    assert(piece(' ', 5, 3)),
    assert(piece(' ', 6, 3)),
    assert(piece(' ', 7, 3)),
    assert(piece(' ', 1, 4)),
    assert(piece(' ', 2, 4)),
    assert(piece(' ', 3, 4)),
    assert(piece(' ', 4, 4)),
    assert(piece(' ', 5, 4)),
    assert(piece(' ', 6, 4)),
    assert(piece(' ', 7, 4)),
    assert(piece(' ', 1, 5)),
    assert(piece(' ', 2, 5)),
    assert(piece(' ', 3, 5)),
    assert(piece('C', 4, 5)),
    assert(piece(' ', 5, 5)),
    assert(piece(' ', 6, 5)),
    assert(piece(' ', 7, 5)),
    assert(piece(' ', 1, 6)),
    assert(piece(' ', 2, 6)),
    assert(piece(' ', 3, 6)),
    assert(piece('K', 4, 6)),
    assert(piece(' ', 5, 6)),
    assert(piece('P', 6, 6)),
    assert(piece(' ', 7, 6)),
    assert(piece('X', 1, 7)),
    assert(piece('T', 2, 7)),
    assert(piece(' ', 3, 7)),
    assert(piece(' ', 4, 7)),
    assert(piece(' ', 5, 7)),
    assert(piece(' ', 6, 7)),
    assert(piece('X', 7, 7)).
    

update_board_row(Y, X, Row) :- update_board_row(Y, X, Row, []).
update_board_row(_, 0, Row, Row).
update_board_row(Y, X, Row, Acc):-
            piece(T, X, Y),
            Acc1 = .(T, Acc),
            X1 is X - 1,
            update_board_row(Y, X1, Row, Acc1).

update_board(Board, Y) :- update_board(Board, Y, []).
update_board(Board, 8, Board).
update_board(Board, Y, Acc) :- 
            Y < 8,
            update_board_row(Y, 7, Row),
            Acc1 = .(Row, Acc),
            Y1 is Y + 1,
            update_board(Board, Y1, Acc1).

update_player_piece([P, _, _], Acc) :-
            piece(P, X, Y),
            Acc = [P, X, Y].

update_player([H | T], Player) :- update_player([H | T], Player, []).
update_player([], Player, Player).
update_player([H | T], Player, Acc) :-
            update_player_piece(H, Acc1),
            Acc2 = .(Acc1, Acc),
            update_player(T, Player, Acc2).

            
make_board(Lenght, Char, Board) :- make_board(Lenght, 'X', Board, []).
make_board(0, _, Board, Board).
make_board(Lenght, Char, Board, Sub) :- Lenght > 0, Lenght1 is Lenght - 1, (Lenght == 7 -> make_cover_row(7, Char, Row) ; Lenght == 6 -> make_white_row(7,' ',Row) ; Lenght == 2 -> make_black_row(7,' ',Row) ; Lenght == 1 -> make_cover_row(7, Char, Row) ; make_row(7, ' ', Row)), Sub1 = .(Row, Sub), make_board(Lenght1, Char, Board, Sub1).
initial_state(Lenght, Board) :- make_board(Lenght, 'X', Board).


