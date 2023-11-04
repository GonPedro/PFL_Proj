get_gamemode(Gm) :-
            write('Please select the gamemode you would like to play:'), nl,
            write('1 - Player vs Player'), nl,
            write('2 - Player vs Computer'), nl,
            write('3 - Computer vs Computer'), nl,
            read(Sub),
            (
                (Sub \== 1 , Sub \== 2 , Sub \== 3) ->
                get_gamemode(Gm)
                ;
                Gm = Sub
            ).


get_computer_level(Bl) :-
            write('Please select the computer level:'), nl,
            write('1 - Random'), nl,
            write('2 - Master'), nl,
            read(Sub),
            (
                (Sub \== 1 , Sub \== 2) ->
                get_computer_level(Bl)
                ;
                Bl = Sub
            ).

get_movement_piece(P, Player) :-
            write('Please type in the piece you would like to move (minimized):'), nl,
            read(Sub), nl,
            (
                (Player == 0, (Sub == 'c' ; Sub == 'q' ; Sub == 'b')) ->
                char_code(Sub, Code),
                Codec is Code - 32,
                char_code(Char, Codec),
                P = Char
                ;
                (Player == 1, (Sub == 't' ; Sub == 'k' ; Sub == 'p')) ->
                char_code(Sub, Code),
                Codec is Code - 32,
                char_code(Char, Codec),
                P = Char
                ;
                write('Invalid Piece!'), nl,
                get_movement_piece(P, Player)
            ).

get_movement_x(X) :-
            write('Please input the new X coordinate for the selected piece: '),
            read(Sub), nl,
            (
                (Sub > 7 ; Sub < 1) ->
                write('Cant move the piece out of the board'), nl,
                get_movement_x(X)
                ;
                X = Sub
            ).

get_movement_y(Y) :-
            write('Please input the new Y coordinate for the selected piece: '),
            read(Sub), nl,
            (
                (Sub > 7 ; Sub < 1) ->
                write('Cant move the piece out of the board'), nl,
                get_movement_y(Y)
                ;
                Y = Sub
            ).


