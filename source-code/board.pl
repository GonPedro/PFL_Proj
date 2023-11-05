:- use_module(library(lists)).
:- consult(move).

:- dynamic piece/3.

% make_row(+Length, +Char, -Row)
% Generates a row of characters with the specified length and character.
make_row(Length, Char, Row) :- 
            make_row(Length, Char, Row, []).

% base case for make_row
make_row(0, _, Row, Row).

make_row(Length, Char, Row, Sub) :- 
            Length > 0,
            Length1 is Length - 1,
            Sub1 = .(Char, Sub),
            make_row(Length1, Char, Row, Sub1).



% make_cover_row(+Length, +Char, -Row)
% Generates a row of characters with the specified length and character for a covered row.
make_cover_row(Length, Char, Row) :- 
            make_cover_row(Length, Char, Row, []).

% base case for make_cover_row
make_cover_row(0, _, Row, Row).

make_cover_row(Length, Char, Row, Sub) :- 
            Length > 0,
            Length1 is Length - 1,
            Sub1 = .(Char, Sub),
            (
            Length1 == 1 -> make_cover_row(Length1, 'X', Row, Sub1)
            ;
            make_cover_row(Length1, ' ', Row, Sub1)
            ).



% make_black_row(+Length, +Char, -Row)
% Generates a row of characters with the specified length and character for a black row.
make_black_row(Length, Char, Row) :-
            make_black_row(Length, Char, Row, []).

% base case for make_black_row
make_black_row(0, _, Row, Row).

make_black_row(Length, Char, Row, Sub) :- 
            Length > 0,
            Length1 is Length - 1,
            Sub1 = .(Char, Sub),
            (
            Length1 == 6 -> make_black_row(Length1, 'P', Row, Sub1)
            ;
            Length1 == 2 -> make_black_row(Length1, 'T', Row, Sub1)
            ;
            Length1 == 4 -> make_black_row(Length1, 'K', Row, Sub1)
            ;
            make_black_row(Length1, ' ', Row, Sub1)
            ).



% make_white_row(+Length, +Char, -Row)
% Generates a row of characters with the specified length and character for a white row.
make_white_row(Length, Char, Row) :-
            make_white_row(Length, Char, Row, []).

% base case for make_white_row
make_white_row(0, _, Row, Row).

make_white_row(Length, Char, Row, Sub) :-
            Length > 0,
            Length1 is Length - 1,
            Sub1 = .(Char, Sub),
            (
            Length1 == 6 -> make_white_row(Length1, 'B', Row, Sub1)
            ;
            Length1 == 2 -> make_white_row(Length1, 'C', Row, Sub1)
            ;
            Length1 == 4 -> make_white_row(Length1, 'Q', Row, Sub1)
            ;
            make_white_row(Length1, ' ', Row, Sub1)
            ).



% create_player_1(-Player)
% Creates the initial game board configuration for Player 1.
create_player_1(Player) :- Player = [['C', 2, 2], ['Q', 4, 2], ['B', 6, 2]].

% create_player_2(-Player)
% Creates the initial game board configuration for Player 2.
create_player_2(Player) :- Player = [['T', 2, 6], ['K', 4, 6], ['P', 6, 6]].

% create_blocked_list(-Blocked)
% Creates a list of blocked positions on the game board.
create_blocked_list(Blocked) :- Blocked = [[1, 1], [7, 1], [1, 7], [7, 7]].



% place_blocked_piece(+Position)
% Places a blocked piece at the specified position on the game board.
place_blocked_piece([X,Y]) :- assert(piece('X', X, Y)).

% base case for place_blocked_pieces
place_blocked_pieces([]).

place_blocked_pieces([H|T]) :-
            place_blocked_piece(H),
            place_blocked_pieces(T).



% place_player_piece(+Piece)
% Places a player-controlled piece at the specified position on the game board.
place_player_piece([T, X, Y]) :- assert(piece(T, X, Y)).

% base case for place_player_pieces
place_player_pieces([]).

place_player_pieces([H | T]) :-
            place_player_piece(H),
            place_player_pieces(T).
            

% place_pieces(+Blocked, +Player1, +Player2)
% Places all the pieces on the game board.
place_pieces(Blocked, Player1, Player2) :-
            place_blocked_pieces(Blocked),
            place_player_pieces(Player1),
            place_player_pieces(Player2).



% Assert initial empty pieces on the game board at specific positions.
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



% update_board_row(+Y, +X, -Row, ?Acc)
% Updates a row of the game board with a new piece at the specified position.
update_board_row(Y, X, Row) :- update_board_row(Y, X, Row, []).

% base case for update_board_row
update_board_row(_, 0, Row, Row).

update_board_row(Y, X, Row, Acc):-
            piece(T, X, Y),
            Acc1 = .(T, Acc),
            X1 is X - 1,
            update_board_row(Y, X1, Row, Acc1).



% update_board(-UpdatedBoard, +Y, ?Acc)
% Updates a specific row in the game board with a new row.
update_board(Board, Y) :- update_board(Board, Y, []).

% base case for update_board
update_board(Board, 8, Board).

update_board(Board, Y, Acc) :- 
            Y < 8,
            update_board_row(Y, 7, Row),
            Acc1 = .(Row, Acc),
            Y1 is Y + 1,
            update_board(Board, Y1, Acc1).



% update_player_piece(+Piece, -UpdatedPiece)
% Updates a player-controlled piece with its current position.
update_player_piece([P, _, _], Acc) :-
            piece(P, X, Y),
            Acc = [P, X, Y].

% update_player(+Pieces, -Player, -UpdatedPlayer)
% Updates the game board configuration of the player-controlled pieces.
update_player([H | T], Player) :- update_player([H | T], Player, []).

% base case for update_player
update_player([], Player, Player).

update_player([H | T], Player, Acc) :-
            update_player_piece(H, Acc1),
            Acc2 = .(Acc1, Acc),
            update_player(T, Player, Acc2).



% make_board(+Length, +Char, -Board)
% Generates a game board with the specified dimensions and initial character.
make_board(Length, Char, Board) :- make_board(Length, 'X', Board, []).

% base case for make_board
make_board(0, _, Board, Board).

make_board(Length, Char, Board, Sub) :- 
    Length > 0,
    Length1 is Length - 1,
    (
        Length == 7 ->
        make_cover_row(7, Char, Row)
        ;
        Length == 6 ->
        make_white_row(7,' ',Row)
        ;
        Length == 2 ->
        make_black_row(7,' ',Row)
        ;
        Length == 1 ->
        make_cover_row(7, Char, Row)
        ;
        make_row(7, ' ', Row)),
        Sub1 = .(Row, Sub),
        make_board(Length1, Char, Board, Sub1
    ).



% initial_state(-Length)
% Generates the initial state of the game board.
initial_state(Length, Board) :- make_board(Length, 'X', Board).
