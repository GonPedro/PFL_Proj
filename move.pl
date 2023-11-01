:- use_module(library(lists)).

unpack_list([], Dest, Ret, Ret) :- !.
unpack_list(StartList, Dest, Ret) :-
            unpack_list(StartList, Dest, Ret, Dest).
unpack_list([H | T], Dest, Ret, Acc) :-
            Dest1 = .(H, Acc),
            unpack_list(T, Dest, Ret, Dest1).


valid_piece_up(_,_,_,2, Moves, Moves).
valid_piece_up(_,8,_,_, Moves, Moves).
valid_piece_up(X, Y, P, C, Moves, Acc) :-
            C < 2,
            piece(T, X, Y),
            (
                T == ' ' ->
                Acc1 = .([P,X,Y], Acc),
                C1 is C + 1,
                Y1 is Y + 1,
                valid_piece_up(X, Y1, P, C1, Moves, Acc1)
                ;
                T == 'X' ->
                Y1 is Y + 1,
                valid_piece_up(X, Y1, P, C, Moves, Acc)
                ;
                valid_piece_up(X, Y, P, 2, Moves, Acc)
            ).

valid_piece_down(_,_,_,2, Moves, Moves).
valid_piece_down(_,0,_,_, Moves, Moves).
valid_piece_down(X, Y, P, C, Moves, Acc):-
            C < 2,
            piece(T, X, Y),
            (
                T == ' ' ->
                Acc1 = .([P,X,Y], Acc),
                C1 is C + 1,
                Y1 is Y - 1,
                valid_piece_down(X, Y1, P, C1, Moves, Acc1)
                ;
                T == 'X' ->
                Y1 is Y - 1,
                valid_piece_down(X, Y1, P, C, Moves, Acc)
                ;
                valid_piece_down(X, Y, P, 2, Moves, Acc)
            ).

valid_piece_left(_,_,_,2, Moves, Moves).
valid_piece_left(0,_,_,_, Moves, Moves).
valid_piece_left(X, Y, P, C, Moves, Acc) :-
            C < 2,
            piece(T, X, Y),
            (
                T == ' ' ->
                Acc1 = .([P,X,Y], Acc),
                C1 is C + 1,
                X1 is X - 1,
                valid_piece_left(X1, Y, P, C1, Moves, Acc1)
                ;
                T == 'X' ->
                X1 is X - 1,
                valid_piece_left(X1, Y, P, C, Moves, Acc)
                ;
                valid_piece_left(X, Y, P, 2, Moves, Acc)
            ).

valid_piece_right(_,_,_,2, Moves, Moves).
valid_piece_right(8,_,_,_, Moves, Moves).
valid_piece_right(X, Y, P, C, Moves, Acc) :-
            C < 2,
            piece(T, X, Y),
            (
                T == ' ' ->
                Acc1 = .([P,X,Y], Acc),
                C1 is C + 1,
                X1 is X + 1,
                valid_piece_right(X1, Y, P, C1, Moves, Acc1)
                ;
                T == 'X' ->
                X1 is X + 1,
                valid_piece_right(X1, Y, P, C, Moves, Acc)
                ;
                valid_piece_right(X, Y, P, 2, Moves, Acc)
            ).

valid_piece_upleft(_,_,_,2, Moves, Moves).
valid_piece_upleft(0,_,_,_, Moves, Moves).
valid_piece_upleft(_, 8,_,_, Moves, Moves).
valid_piece_upleft(X, Y, P, C, Moves, Acc) :-
            C < 2,
            piece(T, X, Y),
            (
                T == ' ' ->
                Acc1 = .([P,X,Y], Acc),
                C1 is C + 1,
                X1 is X - 1,
                Y1 is Y + 1,
                valid_piece_upleft(X1, Y1, P, C1, Moves, Acc1)
                ;
                T == 'X' ->
                X1 is X - 1,
                Y1 is Y + 1,
                valid_piece_upleft(X1, Y1, P, C, Moves, Acc)
                ;
                valid_piece_upleft(X, Y, P, 2, Moves, Acc)
            ).

valid_piece_upright(_,_,_,2, Moves, Moves).
valid_piece_upright(8,_,_,_, Moves, Moves).
valid_piece_upright(_,8,_,_, Moves, Moves).
valid_piece_upright(X, Y, P, C, Moves, Acc) :-
            C < 2,
            piece(T, X, Y),
            (
                T == ' ' ->
                Acc1 = .([P,X,Y], Acc),
                C1 is C + 1,
                X1 is X + 1,
                Y1 is Y + 1,
                valid_piece_upright(X1, Y1, P, C1, Moves, Acc1)
                ;
                T == 'X' ->
                X1 is X + 1,
                Y1 is Y + 1,
                valid_piece_upright(X1, Y1, P, C, Moves, Acc)
                ;
                valid_piece_upright(X, Y, P, 2, Moves, Acc)
            ).

valid_piece_downleft(_,_,_,2, Moves, Moves).
valid_piece_downleft(0,_,_,_, Moves, Moves).
valid_piece_downleft(_,0,_,_, Moves, Moves).
valid_piece_downleft(X, Y, P, C, Moves, Acc) :-
            C < 2,
            piece(T, X, Y),
            (
                T == ' ' ->
                Acc1 = .([P,X,Y], Acc),
                C1 is C + 1,
                X1 is X - 1,
                Y1 is Y - 1,
                valid_piece_downleft(X1, Y1, P, C1, Moves, Acc1)
                ;
                T == 'X' ->
                X1 is X - 1,
                Y1 is Y - 1,
                valid_piece_downleft(X1, Y1, P, C, Moves, Acc)
                ;
                valid_piece_downleft(X, Y, P, 2, Moves, Acc)
            ).

valid_piece_downright(_,_,_,2, Moves, Moves).
valid_piece_downright(8,_,_,_, Moves, Moves).
valid_piece_downright(_,0,_,_, Moves, Moves).
valid_piece_downright(X, Y, P, C, Moves, Acc) :-
            C < 2,
            piece(T, X, Y),
            (
                T == ' ' ->
                Acc1 = .([P,X,Y], Acc),
                C1 is C + 1,
                X1 is X + 1,
                Y1 is Y - 1,
                valid_piece_downright(X1, Y1, P, C1, Moves, Acc1)
                ;
                T == 'X' ->
                X1 is X + 1,
                Y1 is Y - 1,
                valid_piece_downright(X1, Y1, P, C, Moves, Acc)
                ;
                valid_piece_downright(X, Y, P, 2, Moves, Acc)
            ).


valid_piece_moves([T, X, Y], Acc) :-
            Y1 is Y + 1,
            Y2 is Y - 1,
            X1 is X - 1,
            X2 is X + 1,
            valid_piece_up(X, Y1, T, 0, Up, []),
            valid_piece_down(X, Y2, T, 0, Down, []),
            valid_piece_left(X1, Y, T, 0, Left, []),
            valid_piece_right(X2, Y, T, 0, Right, []),
            valid_piece_upleft(X1, Y1, T, 0, Upleft, []),
            valid_piece_upright(X2, Y1, T, 0, Upright, []),
            valid_piece_downleft(X1, Y2, T, 0, Downleft, []),
            valid_piece_downright(X2, Y2, T, 0, Downright, []),
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


