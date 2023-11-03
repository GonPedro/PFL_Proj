get_gamemode(Gm) :-
            write('Please select the gamemode you would like to play:'), nl,
            write('1 - Player vs Player'), nl,
            write('2 - Player vs Computer'), nl,
            write('3 - Computer vs Computer'), nl,
            read(Sub),
            (
                Sub \== 1 , Sub \== 2 , Sub \== 3 ->
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
                Sub \== 1 , Sub \== 2 ->
                get_computer_level(Bl)
                ;
                Bl = Sub
            ).
