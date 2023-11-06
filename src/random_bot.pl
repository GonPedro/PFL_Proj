:- use_module(library(random)).

% choose_move(+Valid, +Level, -Move)
% Chooses a move based on the provided list of valid moves and on the provided level.
choose_move(Valid, Level, Move) :-
            (
                Level == 1 ->
                random_member(Move, Valid)
                ;
                fail
            ).
