:- use_module(library(lists)).

unpack_list([], Dest, Ret, Ret) :- !.
unpack_list(StartList, Dest, Ret) :-
            unpack_list(StartList, Dest, Ret, Dest).
unpack_list([H | T], Dest, Ret, Acc) :-
            Dest1 = .(H, Acc),
            unpack_list(T, Dest, Ret, Dest1).


in_check_place(P, X, Y, Xoff, Yoff) :-
            piece(T, X, Y),
            T = 'X', !,
            Y1 is Y + Yoff,
            X1 is X + Xoff,
            in_check_place(P, X1, Y1, Xoff, Yoff).

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


in_check(P, X, Y) :-
        X1 is X - 1,
        X2 is X + 1,
        Y1 is Y - 1,
        Y2 is Y + 1,
        (in_check_place(P, X, Y2, 0, 1) ; in_check_place(P, X, Y1, 0, -1) ; in_check_place(P, X1, Y, -1, 0) ; in_check_place(P, X2, Y , 1, 0) ; in_check_place(P, X1, Y2, -1, 1) ; in_check_place(P, X2, Y2, 1, 1) ; in_check_place(P, X1, Y1, -1, -1) ; in_check_place(P, X2, Y1, 1, -1)).

valid_piece_mov(_,_,_,_,_,2, Moves, Moves).
valid_piece_mov(_,_,_,_,'K',1, Moves,  Moves).
valid_piece_mov(_,_,_,_,'Q',1, Moves, Moves).
valid_piece_mov(_,0,_,_,_,_, Moves, Moves).
valid_piece_mov(_,8,_,_,_,_, Moves, Moves).
valid_piece_mov(0,_,_,_,_,_, Moves, Moves).
valid_piece_mov(8,_,_,_,_,_, Moves, Moves).
valid_piece_mov(X, Y, Xoff, Yoff, P, C, Moves, Acc) :-
            (C < 2 ; (P \== 'K', C \== 1) ; (P \== 'Q', C \== 1)),
            Xp is X - Xoff,
            Yp is Y - Yoff,
            piece(T, X, Y),
            (
                ((P == 'K', in_check(P, Xp, Yp)) ; (P == 'Q', in_check(P, Xp, Yp))) ->
                (
                    T == ' ' ->
                    (
                        \+ in_check(P, X, Y) ->
                        Moves = .([P, X, Y], Acc)
                        ;
                        Moves = Acc
                    )
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
                        Y1 is Y + 1,
                        piece(T1, X, Y1),
                        (
                            T1 == ' ' ->
                            (
                                (P == 'C' ; P == 'B') ->
                                piece('Q', Xk, Yk),
                                K = 'Q'
                                ;
                                piece('K', Xk, Yk),
                                K = 'K'
                            ),
                            retractall(piece(' ', X, Y)),
                            assert(piece('X', X, Y)),
                            (
                                \+ in_check(K, Xk, Yk) ->
                                Moves = .([P, X, Y1], Acc1)
                            ),
                            retractall(piece('X', X, Y)),
                            assert(piece(' ', X, Y))
                            ;
                            Moves = Acc1

                        )
                    )
                    ;
                    T == 'X' ->
                    Y1 is Y + Yoff,
                    X1 is X + Xoff,
                    valid_piece_mov(X, Y1, Xoff, Yoff, P, C, Moves, Acc)
                    ;
                    valid_piece_mov(X, Y, Xoff, Yoff, P, 2, Moves, Acc)
                )
            ).

                        
                    
                    

valid_piece_moves([T, X, Y], Acc) :-
            Y1 is Y + 1,
            Y2 is Y - 1,
            X1 is X - 1,
            X2 is X + 1,
            valid_piece_mov(X, Y1, 0, 1, T, 0, Up, []),
            valid_piece_mov(X, Y2, 0, -1, T, 0, Down, []),
            valid_piece_mov(X1, Y, -1, 0, T, 0, Left, []),
            valid_piece_mov(X2, Y, 0, 1, T, 0, Right, []),
            valid_piece_mov(X1, Y1, -1, 1, T, 0, Upleft, []),
            valid_piece_mov(X2, Y1, 1, 1, T, 0, Upright, []),
            valid_piece_mov(X1, Y2, -1, -1, T, 0, Downleft, []),
            valid_piece_mov(X2, Y2, 1, -1, T, 0, Downright, []),
            unpack_list(Up, Down, Sub1),
            unpack_list(Left, Right, Sub2),
            unpack_list(Upleft, Upright, Sub3),
            unpack_list(Downleft, Downright, Sub4),
            unpack_list(Sub1, Sub2, Sub5),
            unpack_list(Sub3, Sub4, Sub6),
            unpack_list(Sub5, Sub6, Acc).

valid_moves(Board, [H | T], Available_moves) :- valid_moves(Board, [H | T], Available_moves, []).
valid_moves(_, [], Available_moves, Available_moves).
valid_moves(Board, [H | T], Available_moves, Acc) :-
            valid_piece_moves(H, Acc1),
            unpack_list(Acc1, Acc, Acc2),
            valid_moves(Board, T, Available_moves, Acc2).


