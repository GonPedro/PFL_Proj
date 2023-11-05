:- use_module(library(random)).

% choose_move(+Valid, +Level, -Move)
% Chooses a random move based on the provided list of valid moves.
choose_move(Valid, Level, Move) :-
            (
                Level == 1 ->
                random_member(Move, Valid)
                ;
                % Implementar Heuristica Aqui
                fail
            ).
