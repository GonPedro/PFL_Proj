:- use_module(library(lists)).

% base case for unpack_list
unpack_list([], Dest, Ret, Ret) :- !.

% unpack_list(+StartList, -Dest, +Ret)
% Unpacks elements from a list and appends them to another list, creating a new list. (First call)
unpack_list(StartList, Dest, Ret) :-
            unpack_list(StartList, Dest, Ret, Dest).

% unpack_list(+StartList, -Dest, +Ret)
% Unpacks elements from a list and appends them to another list, creating a new list. (Recursive call)
unpack_list([H | T], Dest, Ret, Acc) :-
            Dest1 = .(H, Acc),
            unpack_list(T, Dest, Ret, Dest1).



% in_check_place(+P, +X, +Y, +Xoff, +Yoff)
% Determines if there is a piece at a specific position that puts the player's king in check.
in_check_place(P, X, Y, Xoff, Yoff) :-
            piece(T, X, Y),
            T = 'X', !,
            Y1 is Y + Yoff,
            X1 is X + Xoff,
            in_check_place(P, X1, Y1, Xoff, Yoff).

% in_check_place(+P, +X, +Y, +Xoff, +Yoff)
% Base case for in_check_place.
in_check_place(P, X, Y, Xoff, Yoff) :-
            piece(T, X, Y),
            (
                (
                    P == 'K' ->
                    (T == 'C' ; T == 'B')
                    ;
                    (T == 'T' ; T == 'P') 
                )
            ).



% in_check(+P, +X, +Y)
% Determines if a piece at a specific position is in check by checking various potential attack directions.
in_check(P, X, Y) :-
        X1 is X - 1,
        X2 is X + 1,
        Y1 is Y - 1,
        Y2 is Y + 1,
        (
            in_check_place(P, X, Y2, 0, 1)
            ;
            in_check_place(P, X, Y1, 0, -1)
            ;
            in_check_place(P, X1, Y, -1, 0)
            ;
            in_check_place(P, X2, Y , 1, 0)
            ;
            in_check_place(P, X1, Y2, -1, 1)
            ;
            in_check_place(P, X2, Y2, 1, 1)
            ;
            in_check_place(P, X1, Y1, -1, -1)
            ;
            in_check_place(P, X2, Y1, 1, -1)
        ).



% base case for check_mate
check_mate([]).

% check_mate(+Pieces)
% Checks if any of the pieces in the given list represent the player's king, indicating if he has been checkmated.
check_mate([[P, X, Y] | T]) :-
            (
                (P == 'K' ; P == 'Q') ->
                fail
                ;
                check_mate(T)
            ).



% base case for valid_piece_mov
valid_piece_mov(_,_,_,_,_,_,_,2, Moves, Moves) :- !.

% base case for valid_piece_mov
valid_piece_mov(_,_,_,_,_,_,'K',1, Moves,  Moves) :- !.

% base case for valid_piece_mov
valid_piece_mov(_,_,_,_,_,_,'Q',1, Moves, Moves) :- !.

% base case for valid_piece_mov
valid_piece_mov(_,0,_,_,_,_,_,_, Moves, Moves).

% base case for valid_piece_mov
valid_piece_mov(_,8,_,_,_,_,_,_, Moves, Moves).

% base case for valid_piece_mov
valid_piece_mov(0,_,_,_,_,_,_,_, Moves, Moves).

% base case for valid_piece_mov
valid_piece_mov(8,_,_,_,_,_,_,_, Moves, Moves).

% valid_piece_mov(+X, +Y, +Xp, +Yp, +Xoff, +Yoff, +P, +C, -Moves, Acc)
% Determines valid piece moves in a direction on the board based on the provided parameters.
valid_piece_mov(X, Y, Xp, Yp, Xoff, Yoff, P, C, Moves, Acc) :-
            piece(T, X, Y),
            (
                (P == 'C' ; P == 'B' ; P == 'Q') ->
                piece('Q', Xk, Yk),
                K = 'Q'
                ;
                piece('K', Xk, Yk),
                K = 'K'
            ),
            (
                ((P == 'C' ; P == 'B' ; P == 'T' ; P == 'P') , in_check(K, Xk, Yk)) ->
                (
                    T == ' ' ->
                    retractall(piece(P, Xp, Yp)),
                    assert(piece(' ', Xp, Yp)),
                    retractall(piece(' ', X, Y)),
                    assert(piece(P, X, Y)),
                    (
                        \+ in_check(K, Xk, Yk) ->
                        Acc1 = .([P, X, Y], Acc)
                        ;
                        Acc1 = Acc
                    ),
                    retractall(piece(P, X, Y)),
                    assert(piece(' ', X, Y)),
                    retractall(piece(' ', Xp, Yp)),
                    assert(piece(P, Xp, Yp)),
                    X1 is X + Xoff,
                    Y1 is Y + Yoff,
                    (
                        piece(T1, X1, Y1) ->
                        (
                            T1 == ' ' ->
                            retractall(piece(' ', X, Y)),
                            assert(piece('X', X, Y)),
                            retractall(piece(P, Xp, Yp)),
                            assert(piece(' ', Xp, Yp)),
                            retractall(piece(' ', X1, Y1)),
                            assert(piece(P, X1, Y1)),
                            (
                                \+ in_check(K, Xk, Yk) ->
                                Moves = .([P, X1, Y1], Acc1),
                                retractall(piece('X', X, Y)),
                                assert(piece(' ', X, Y)),
                                retractall(piece(P, X1, Y1)),
                                assert(piece(' ', X1, Y1)),
                                retractall(piece(' ', Xp, Yp)),
                                assert(piece(P, Xp, Yp))
                                ;
                                retractall(piece('X', X, Y)),
                                assert(piece(' ', X, Y)),
                                retractall(piece(P, X1, Y1)),
                                assert(piece(' ', X1, Y1)),
                                retractall(piece(' ', Xp, Yp)),
                                assert(piece(P, Xp, Yp)),
                                Moves = Acc1
                            )
                            ;
                            Moves = Acc1

                        )
                        ;
                        Moves = Acc1
                    )
                    ;
                    T == 'X' ->
                    X1 is X + Xoff,
                    Y1 is Y + Yoff,
                    valid_piece_mov(X1, Y1, Xp, Yp, Xoff, Yoff, P, C, Moves, Acc)
                    ;
                    valid_piece_mov(X, Y, Xp, Yp, Xoff, Yoff, P, 2, Moves, Acc)
                )
                ;
                ((P == 'K', in_check(P, Xp, Yp)) ; (P == 'Q', in_check(P, Xp, Yp))) ->
                (
                    T == ' ' ->
                    (
                        \+ in_check(P, X, Y) ->
                        Moves = .([P, X, Y], Acc)
                        ;
                        Moves = Acc
                    )
                    ;
                    Moves = Acc
                )
                ;
                (
                    T == ' ' ->
                    (
                        (P == 'K' ; P == 'Q') ->
                            (
                                \+ in_check(P, X, Y) ->
                                Moves = .([P, X, Y], Acc)
                                ;
                                Moves = Acc
                            )
                        ;
                        Acc1 = .([P,X,Y], Acc),
                        X1 is X + Xoff,
                        Y1 is Y + Yoff,
                        (
                            piece(T1, X1, Y1) ->
                            (
                                T1 == ' ' ->
                                retractall(piece(' ', X, Y)),
                                assert(piece('X', X, Y)),
                                (
                                    \+ in_check(K, Xk, Yk) ->
                                    Moves = .([P, X1, Y1], Acc1),
                                    retractall(piece('X', X, Y)),
                                    assert(piece(' ', X, Y))
                                    ;
                                    retractall(piece('X', X, Y)),
                                    assert(piece(' ', X, Y)),
                                    Moves = Acc1
                                )
                                ;
                                Moves = Acc1

                            )
                            ;
                            Moves = Acc1
                        )
                    )
                    ;
                    T == 'X' ->
                    Y1 is Y + Yoff,
                    X1 is X + Xoff,
                    valid_piece_mov(X1, Y1, Xp, Yp, Xoff, Yoff, P, C, Moves, Acc)
                    ;
                    valid_piece_mov(X, Y, Xp, Yp, Xoff, Yoff, P, 2, Moves, Acc)
                )
            ).

                        
                    
% valid_piece_moves(+[T, X, Y], -Acc)
% Determines all the valid movements for a single piece and combines them into a single list.                    
valid_piece_moves([T, X, Y], Acc) :-
            Y1 is Y + 1,
            Y2 is Y - 1,
            X1 is X - 1,
            X2 is X + 1,
            valid_piece_mov(X, Y1, X, Y, 0, 1, T, 0, Up, []),
            valid_piece_mov(X, Y2, X, Y, 0, -1, T, 0, Down, []),
            valid_piece_mov(X1, Y, X, Y, -1, 0, T, 0, Left, []),
            valid_piece_mov(X2, Y, X, Y, 1, 0, T, 0, Right, []),
            valid_piece_mov(X1, Y1, X, Y, -1, 1, T, 0, Upleft, []),
            valid_piece_mov(X2, Y1, X, Y, 1, 1, T, 0, Upright, []),
            valid_piece_mov(X1, Y2, X, Y, -1, -1, T, 0, Downleft, []),
            valid_piece_mov(X2, Y2, X, Y, 1, -1, T, 0, Downright, []),
            unpack_list(Up, Down, Sub1),
            unpack_list(Left, Right, Sub2),
            unpack_list(Upleft, Upright, Sub3),
            unpack_list(Downleft, Downright, Sub4),
            unpack_list(Sub1, Sub2, Sub5),
            unpack_list(Sub3, Sub4, Sub6),
            unpack_list(Sub5, Sub6, Acc).



% valid_moves(+Board, +Pieces, -Available_moves)
% Determines all the valid movements for a list of pieces and combines them into a final list of available moves. (First Call)
valid_moves(Board, [H | T], Available_moves) :- 
            valid_moves(Board, [H | T], Available_moves, []).

% base case for valid_moves
valid_moves(_, [], Available_moves, Available_moves).

% valid_moves(+Board, +Pieces, -Available_moves, Acc)
% Determines all the valid movements for a list of pieces and combines them into a final list of available moves. (Recursive Call)
valid_moves(Board, [H | T], Available_moves, Acc) :-
            valid_piece_moves(H, Acc1),
            unpack_list(Acc1, Acc, Acc2),
            valid_moves(Board, T, Available_moves, Acc2).



% move(+Board, +Move, +Valid_moves, -New_board)
% Validates and executes a move on the board, updating the board accordingly.
move(Board, [P, X, Y], Valid_moves, Board1) :-
            member([P, X, Y], Valid_moves),
            piece(P, Xo, Yo),
            Xoff is X - Xo,
            Yoff is Y - Yo,
            (
                %downleft
                (Xoff == - 2, Yoff == -2) ->
                Xrem is X + 1,
                Yrem is Y + 1,
                retractall(piece(' ', Xrem, Yrem)),
                assert(piece('X', Xrem, Yrem)),
                retractall(piece(P, Xo, Yo)),
                retractall(piece(' ', X, Y)),
                assert(piece(P, X, Y)),
                assert(piece(' ', Xo, Yo)),
                update_board(Board1, 1)
                ;
                %downright
                (Xoff == 2, Yoff == -2) ->
                Xrem is X - 1,
                Yrem is Y + 1,
                retractall(piece(' ', Xrem, Yrem)),
                assert(piece('X', Xrem, Yrem)),
                retractall(piece(P, Xo, Yo)),
                retractall(piece(' ', X, Y)),
                assert(piece(P, X, Y)),
                assert(piece(' ', Xo, Yo)),
                update_board(Board1, 1)
                ;
                %upleft
                (Xoff == -2, Yoff == 2) ->
                Xrem is X + 1,
                Yrem is Y - 1,
                retractall(piece(' ', Xrem, Yrem)),
                assert(piece('X', Xrem, Yrem)),
                retractall(piece(P, Xo, Yo)),
                retractall(piece(' ', X, Y)),
                assert(piece(P, X, Y)),
                assert(piece(' ', Xo, Yo)),
                update_board(Board1, 1)
                ;
                %upright
                (Xoff == 2, Yoff == 2) ->
                Xrem is X - 1,
                Yrem is Y - 1,
                retractall(piece(' ', Xrem, Yrem)),
                assert(piece('X', Xrem, Yrem)),
                retractall(piece(P, Xo, Yo)),
                retractall(piece(' ', X, Y)),
                assert(piece(P, X, Y)),
                assert(piece(' ', Xo, Yo)),
                update_board(Board1, 1)
                ;
                %up
                (Yoff == 2) ->
                Yrem is Y - 1,
                retractall(piece(' ', X, Yrem)),
                assert(piece('X', X, Yrem)),
                retractall(piece(P, Xo, Yo)),
                retractall(piece(' ', X, Y)),
                assert(piece(P, X, Y)),
                assert(piece(' ', Xo, Yo)),
                update_board(Board1, 1)
                ;
                %down
                (Yoff == -2) ->
                Yrem is Y + 1,
                retractall(piece(' ', X, Yrem)),
                assert(piece('X', X, Yrem)),
                retractall(piece(P, Xo, Yo)),
                retractall(piece(' ', X, Y)),
                assert(piece(P, X, Y)),
                assert(piece(' ', Xo, Yo)),
                update_board(Board1, 1)
                ;
                %left
                (Xoff == -2) ->
                Xrem is X + 1,
                retractall(piece(' ', Xrem, Y)),
                assert(piece('X', Xrem, Y)),
                retractall(piece(P, Xo, Yo)),
                retractall(piece(' ', X, Y)),
                assert(piece(P, X, Y)),
                assert(piece(' ', Xo, Yo)),
                update_board(Board1, 1)
                ;
                %right
                (Xoff == 2) ->
                Xrem is X - 1,
                retractall(piece(' ', Xrem, Y)),
                assert(piece('X', Xrem, Y)),
                retractall(piece(P, Xo, Yo)),
                retractall(piece(' ', X, Y)),
                assert(piece(P, X, Y)),
                assert(piece(' ', Xo, Yo)),
                update_board(Board1, 1)
                ;
                retractall(piece(P, Xo, Yo)),
                retractall(piece(' ', X, Y)),
                assert(piece(P, X, Y)),
                assert(piece(' ', Xo, Yo)),
                update_board(Board1, 1)
            ).


