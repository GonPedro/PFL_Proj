# Trabalho Prático 1 : Shakti

Grupo Shakti_1:

- Bruno Pinto da Silva Drumond (up201202666) - Contribuição: 50%
- Gonçalo Pedro Nadais de Pinho (up202108672) - Contribuição: 50%


## Instalação e Execução

No caso de não possuir o software Sicstus Prolog 4.8, clique [aqui](https://sicstus.sics.se/download4.html) para download e instruções de instalação.

<p align="justify">
Para instalar e correr o jogo Shakti é necessário descarregar o ficheiro <b>PFL_TP1_T14_Shakti_1.zip</b> e, posteriormente, descompactá-lo. Uma vez descompactado, basta aceder ao diretório <b>src</b> e consultar o ficheiro <b>main.pl</b> (pela UI do Sicstus Prolog 4.8 ou através da linha de comandos). O jogo é iniciado com o predicado <b>play/0</b>, sendo suportado por ambientes Windows e Linux.
</p>

## Descrição do Jogo

<p align="justify">
"Shakti" é um jogo de estratégia rápido (10 a 20 minutos de duração) e abstrato, projetado para dois jogadores, que foi criado em 1982 por Christian Freeling. Muitas vezes sendo descrito como uma variante do Xadrez, o jogo é jogado num tabuleiro de dimensões 7x7, onde cada célula do tabuleiro, exceto as das extremidades, possui um azulejo e cada jogador possui um rei e dois guerreiros.
O jogo inicia-se com as peças de cada jogador alinhadas, sendo o jogador detentor das peças brancas a fazer a primeira jogada. As peças apenas podem mover-se para células que apresentem um azulejo. Ganha o jogo o jogador que conseguir dar <i>checkmate</i> ao Rei do oponente, ou seja, colocar as suas peças no tabuleiro de tal forma que o Rei do seu oponente, independentemente da célula para o qual se mova, acabe sempre capturado.
<br>
É possível verificar o início do jogo (imagem da esquerda) e um exemplo de fim do jogo, onde o Rei amarelo se encontra em <i>checkmate</i> (imagem da direita), nas imagens abaixo anexadas.
</p>

<p align="center" justify="center">
  <img width="300" alt="init_state" src="https://github.com/GonPedro/PFL_Proj/assets/93215985/83277c54-9d14-483d-98b9-909c8a05b2d0"/> 
  &nbsp; &nbsp; &nbsp; &nbsp;
  <img width="300" alt="init_state" src="https://github.com/GonPedro/PFL_Proj/assets/93215985/3f6519c1-fb3b-4118-a05a-d5fd696cd37d"/>
</p>

<p align="justify">
Porém existem algumas particularidades no movimento das diferentes peças:

Guerreiro:
- O Guerreiro pode mover-se para a primeira célula vazia do tabuleiro, em qualquer uma das oito direções;
- Se duas células subsquentes se encontrarem vazias e na mesma direção, o Guerreiro pode saltar a primeira e pousar na segunda. Neste caso, o azulejo da primeira célula é removido e esta deixa de ser uma posição válida no tabuleiro, não podendo ser acedida por nenhuma peça.
- Um Guerreiro pode deixar o Rei adversário em <i>check</i>, se este se encontrar na mesma direção que o Rei e não existirem azulejos entre eles.

Rei:
- O Rei pode mover-se para a primeira célula vazia do tabuleiro, em qualquer uma das oito direções;
- No caso de se encontrar em <i>check</i>, o Rei apenas se poderá mover para os azulejos adjacentes à sua posição.

Se um jogador não conseguir realizar nenhuma jogada válida é obrigado a desistir do seu turno e a passar a vez ao adversário.
</p>

Tanto as regras como o funcionamento do jogo foram consultadas nos seguintes websites: [Iggmaecenter](https://www.iggamecenter.com/en/rules/shakti), [Mindsports](https://mindsports.nl/index.php/the-pit/550-shakti) e [Boardgamegeek](https://boardgamegeek.com/boardgame/42595/shakti).

## Lógica do Jogo
### Representação Interna do Estado do Jogo
<p align="justify">
O nosso tabuleiro usa a representação típica de uma lista de listas (linhas do tabuleiro) com diferentes células para as peças.
</br>
Os jogadores são, também, uma lista de listas que contêm as peças desse jogador e as suas coordenadas. </br>
Para além destas listas nós tiramos proveito do predicado dinâmico <i>piece(Type, X, Y)</i> para estabelecer a posição de tudo no nosso tabuleiro, sejam telhas vazias, telhas bloqueadas ou telhas com peças.
Nós utilizamos os átomos 'P', 'T', 'C' e 'B' para representar os warriors, sendo 'C' e 'B' os warriors do Player 1 e 'T' e 'P' warriors do Player 2, e utilizamos ' ' e 'X' para representar telhas vazias e telhas bloqueadas, respetivamente.
</br>
Dito isto, utilizamos o predicado <i>make_board(+Length, +Char, -Board)</i> para criar o tabuleiro inicial, <i>create_player_1(-Player)</i> e <i>create_player_2(-Player)</i> para criar o Player 1 e Player 2, <i>create_blocked_list(-Blocked)</i> para criar a lista de telhas bloqueadas no inicio do jogo e fazemos uso do predicado <i>place_pieces(+Blocked, +Player1, +Player2)</i> para posicionar tudo no tabuleiro.
            
            create_player_1(Player) :-
                  Player = [['C', 2, 2], ['Q', 4, 2], ['B', 6, 2]].
                  
            create_player_2(Player) :-
                  Player = [['T', 2, 6], ['K', 4, 6], ['P', 6, 6]].
                  
            create_blocked_list(Blocked) :-
                  Blocked = [[1, 1], [7, 1], [1, 7], [7, 7]].
            
            place_pieces(Blocked, Player1, Player2) :-
                  place_blocked_pieces(Blocked),
                  place_player_pieces(Player1),
                  place_player_pieces(Player2).

  
</p>

<p align="center">
  <b><i>Estado Inicial</i></b>
</p>
<p align="center" justify="center">
<img width="500" alt="init_state" src="https://github.com/GonPedro/PFL_Proj/assets/93215985/477afb09-ff05-485f-9b4b-46faf7e1f883"/>
</p>

<p align="center">
  <b><i>Estado Intermédio</i></b>
</p>
<p align="center" justify="center">
<img width="500" alt="init_state" src="https://github.com/GonPedro/PFL_Proj/assets/93215985/3ae33337-e53d-4650-9d96-5b2149a010e3"/>
</p>

<p align="center">
  <b><i>Estado Final</i></b>
</p>
<p align="center" justify="center">
<img width="500" alt="init_state" src="https://github.com/GonPedro/PFL_Proj/assets/93215985/ef2909e9-ccbe-4422-992b-dc77171b4fda"/>
</p>

### Visualização do Estado do Jogo
<p align="justify">
Nós utilizamos o predicado <i>draw_board(+Board)</i> para desenhar o tabuleiro no ecrâ.
Este predicado começa por desenhar o cabeçalho da tabela e, seguidamente, vai ler e desenhar o tabuleiro linha a linha, consoante o conteúdo lido.
Também criámos o predicado <i>draw_player(+Player)</i> que anuncia o jogador que vai jogar no respetivo turno.
</br>
Embora o nosso tabuleiro não tenha um tamanho dinâmico, implementámos o predicado <i>initial_state(+Size, -Board)</i>, que faz uso do predicado <i>make_board(+Length, +Char, -Board)</i>, previamente falado, para criar o nosso tabuleiro.
</p>

### Lista de Movimentos Válidos
<p align="justify">
Como foi referido na representação interna do estado do jogo, utilizamos o predicado dinâmico <i>piece(Type, X, Y)</i> para estabelecer a posição de todas as telhas do tabuleiro.
Através deste predicado e das listas dos jogadores conseguimos verificar e validar todos os movimentos possiveis para todas as peças de um jogador.
Dito isto, criámos o predicado <i>valid_moves(+Board, +Player, -Available_moves)</i>, onde iteramos pelo Player para descobrirmos todos os movimentos válidos naquele turno para esse mesmo Player.
</br>
Ao iterármos pelo Player conseguimos ver as peças dele individualmente e passá-las por um novo predicado <i>valid_piece_moves(+[T, X, Y], -Acc)</i> que pega em cada uma delas e verifica, num espaço de 2 casas nas 8 direções, todas as telhas para onde as mesmas se podem mexer.
</br>
Esta verificação faz uso de um predicado auxiliar <i>valid_piece_mov(+X, +Y, +Xp, +Yp, +Xoff, +Yoff, +P, +C, -Moves, Acc)</i> que averigua se a peça pode ir para uma telha, consoante as regras do jogo.

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
</p>

### Validação e Execução de Movimento
<p align="justify">

Tendo a lista de movimentos válidos criada, a validação e execução do movimento das peças torna-se bastante simples.
Começámos por criar 3 predicados diferentes para pedir ao jogador para inserir a jogada que gostaria de fazer, sendo estes:

- <i>get_movement_piece(-P, +Player)</i>: Pede ao jogador para inserir a peça que pretende mexer e verifica se essa peça é valida com a ajuda do Player;
- <i>get_movement_x(X)</i>: Pede ao jogador para inserir a nova coordenada X da peça que pretende mover;
- <i>get_movement_y(Y)</i>: Pede ao jogador para inserir a nova coordenada Y da peça que pretende mover.

Criámos o predicado <i>move(+Board, +Move, +Valid_moves, -New_Board)</i> que tira proveito do predicado <i>member(+Element, +List)</i> para verificar se o movimento que o jogador fez está dentro da lista de valid_moves. Se o movimento estiver dentro da lista de movimentos válidos, ele procede a retirar telhas da board, caso necessário, seguido da criação do New_Board através do predicado <i>update_board(-UpdatedBoard, +Y, ?Acc)</i>, que faz uso do predicado <i>piece(Type, X, Y)</i> para descobrir o que está no tabuleiro naquelas coordenadas e da atualização do Player através do predicado <i>update_player(+Pieces, -Player)</i>.

            update_player([H | T], Player, Acc) :-
                        update_player_piece(H, Acc1),
                        Acc2 = .(Acc1, Acc),
                        update_player(T, Player, Acc2).
                        
            update_board(Board, Y, Acc) :- 
                        Y < 8,
                        update_board_row(Y, 7, Row),
                        Acc1 = .(Row, Acc),
                        Y1 is Y + 1,
                        update_board(Board, Y1, Acc1).

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
                            (...)

Com isto, criámos, também, o predicado <i>process_player_mov(+Board, +Curr_player, +Opp_player, +Valid, +Bl, +PlayerI)</i>, que utiliza os 3 predicados para pedir o movimento ao jogador e tenta realizar esse movimento executando o predicado <i>Move/4</i>. Se o movimento for bem sucedido ele passa para o proximo turno, caso contrário imprime "Invalid Move!" no ecrã e pede ao jogador para selecionar um novo movimento.

            process_player_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerID) :-
                        get_movement_piece(P, PlayerID),
                        get_movement_x(X),
                        get_movement_y(Y),
                        (
                            move(Board, [P, X, Y], Valid, Board1) ->
                            Player is PlayerID + 1,
                            New_player is Player mod 2,
                            update_player(Curr_player, New_curr),
                            update_player(Opp_player, New_opp),
                            (
                                Bl == 0 ->
                                pvp(Board1, New_opp, New_curr, New_player)
                                ;
                                pvc(Board1, New_opp, New_curr, New_player, 1)
                            )
                            ;
                            write('Invalid Move!'), nl,
                            process_player_mov(Board, Curr_player, Opp_player, Valid, Bl, PlayerID)
                        ).
  
</p>

### Fim do Jogo
<p align="justify">
Durante o decorrer do jogo é executado constantemente o predicado <i>check_mate(+Valid_Moves)</i>. Este predicado é responsável por percorrer a lista de movimentos válidos até encontrar pelo menos um movimento que inclua o Rei. Caso tal não se verifique, então significa que o jogador detentor do turno para jogar se encontra em checkmate. Neste caso, o predicado <i>check_mate(+Valid_Moves)</i> irá continuar a sua execução, retirando todas as peças do tabuleiro (através do predicado <i>retractall()</i>) e chamando o predicado <i>game_over(+Board, +Winner)</i> que declara o vencedor do jogo e o dá como terminado.
</p>

            valid_moves(Board, Curr_player, Valid),
            (
                check_mate(Valid) ->
                F1 is Player mod 2,
                Winner is F1 + 1,
                game_over(Board, Winner),
                retractall(piece(_,_,_))
                ;
                write('Here are your available moves:'), nl,
                draw_available_moves(Valid),
                process_player_mov(Board, Curr_player, Opp_player, Valid, 0, PlayerID)
            ).

### Avaliação do Estado do Jogo
<p align="justify">
Devido à maneira como implementámos o jogo e por falta de tempo, não nos foi possível desenvolver um predicado que tornasse possível a avaliação do estado do jogo.
</p>

### Jogadas de Computador
<p align="justify">
Uma vez mais devido à falta de tempo, não nos foi possível implementar o nivel 2 de dificuldade para o bot, o que significa que o seu poder de decisão será sempre baseado na escolha aleatória dos movimentos válidos disponíveis.
Para tal criámos o predicado <i>choose_move(+Valid, +Level, -Move)</i> para escolher o movimento do "computador",
tirando proveito da <i>library(random)</i> para utilizar o predicado <i>random_member(-Move, +Valid_Moves)</i> e, assim, poder escolher um movimento aleatório da lista de movimentos válidos.
</p>

            choose_move(Valid, Level, Move) :-
            (
                Level == 1 ->
                random_member(Move, Valid)
                ;
                fail
            ).

## Conclusão
<p align="justify">
Apesar deste projeto ter sido uma corrida contra o tempo, consideramos que o jogo Shakti foi implementado com sucesso em Prolog. Apresenta 3 modos de jogo distintos, sendo estes <i>Jogador vs Jogador</i>, <i>Jogador vs Computador</i> e <i>Computador vs Computador</i>. Apesar do bot implementado apenas ter uma única dificuldade baseada na escolha aleatória de jogadas válidas, todo o código desenvolvido foi escrutinamente verificado e testado de modo a assegurar uma jogabilidade robusta e garantir a validade do estado de jogo a todo o momento.
</br>
Por fim, acreditamos ter adquirido uma forte compreensão do conceito deste novo paradigma de programação e, apesar de sabermos que somos capazes de melhor, estamos satisfeitos com os resultados obtidos.
</p>


## Referências

As regras e funcionamento do jogo foram consultadas nos respetivos sites:
- https://www.iggamecenter.com/en/rules/shakti
- https://mindsports.nl/index.php/the-pit/550-shakti
- https://boardgamegeek.com/boardgame/42595/shakti
