:- use_module(library(random)).

choose_move(Valid, Level, Move) :-
            (
                Level == 1 ->
                random_member(Move, Valid)
                ;
                %implementar euristica aqui
                fail
            ).
