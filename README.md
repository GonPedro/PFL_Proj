# Trabalho Prático 1 : Shakti

Grupo Shakti_1:

- Bruno Pinto da Silva Drumond (up201202666) - Contribuição: 50%
- Gonçalo Pedro Nadais de Pinho (up202108672) - Contribuição: 50%


## Instalação e Execução

No caso de não possuir o software Sicstus Prolog 4.8, clique [aqui](https://sicstus.sics.se/download4.html) para download e instruções de instalação.

<p align="justify">
Para instalar e correr o jogo Shakti é necessário descarregar o ficheiro <b>PFL_TP1_T14_Shakti_1.zip</b> e, posteriormente, descompactá-lo. Uma vez descompactado, basta aceder ao diretório <b>source-code</b> e consultar o ficheiro <b>main.pl</b> (pela UI do Sicstus Prolog 4.8 ou através da linha de comandos). O jogo é iniciado com o predicado <b>play/0</b>, sendo suportado por ambientes Windows e Linux.
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
O nosso tabuleiro usa a representação tipica de uma lista de listas (linhas do tabuleiro) com diferentes átomos para as peças.
Os jogadores são, também, lista de listas que contêm as peças desse jogador e as suas coordenadas.
Para além destas listas nós tiramos proveito do predicado dinâmico piece(Type, X, Y) para estabelecer a posição de tudo no nosso tabuleiro, sejam telhas vazias, telhas bloqueadas e telhas com peças.
(Podemos incluir screenshots aqui do board secalhar, tanto no inicio como no fim (do jogo) maybe)
</p>

### Visualização do Estado do Jogo
<p align="justify">
Nós utilizamos o predicado draw_board(+Board) para desenhar o tabuleiro no ecrâ.
Este predicado começa por desenhar o cabeçalho da tabela e, conseguinte, vai ler e desenhar o tabuleiro linha a linha consoante o conteudo lido.
Também criamos o predicado draw_player(+Player) que anuncia o jogador que vai jogar naquele turno.
Embora o nosso tabuleiro não tenha um tamanho dinamico implementamos o predicado initial_state(+Size, -Board) para criar o nosso tabuleiro.
</p>

### Lista de Movimentos Válidos
<p align="justify">
Como foi referido na representação interna do estado do jogo, utilizamos o predicado dinâmico piece(Type, X, Y) para estabelecer a posição de todas as telhas do tabuleiro.
Através deste predicado e das listas dos jogadores conseguimos verificar e validar todos os moves possiveis para todas as peças de um jogador.
Com isto dito, criamos o predicado valid_moves(+Board, +Player, -Available_moves) onde iteramos pelo Player para descobrirmos todos os movimentos válidos naquele turno para aquele jogador.
</p>

### Validação e Execução de Movimento
<p align="justify">
Tendo a lista de movimentos válidos criadas a validação e execução de movimento torna-se bastante simples.
Começamos por criar 3 predicados diferentes para pedir ao user para inserir o move que gostaria de fazer, sendo estes:
  -get_movement_piece(-P, +Player): Pede ao user para inserir a peça que pretende mexer e verifica se essa peça é valida com a ajuda do Player.
  -get_movement_x(X): Pede ao user para inserir a nova coordenada X da peça que pretende mexer.
  -get_movement_y(Y): Pede ao user para inserir a nova coordenada y da peça que pretende mexer.

Criamos o predicado Move(+Board, +Move, +Valid_moves, -New_Board) que tira proveito do predicado member(+Element, +List) para verificar se o movimento que o jogador fez está dentro da lista de Valid_moves. Se o move tiver dentro da lista de movimentos validos ele procede a retirar telhas da board se for necessário, seguido da criação do New_Board através do predicado update_board(-UpdatedBoard, +Y, ?Acc), que faz uso do predicado piece(Type, X, Y) para descobrir o que esta no tabuleiro naquelas coordenadas.

Com isto, também fizemos o predicado process_player_mov(+Board, +Curr_player, +Opp_player, +Valid, +Bl, +PlayerI) que utiliza os 3 predicados para pedir o move ao user e tenta executar esse move correndo o predicado Move/4. Se o move suceder ele passa para o proximo turno, senão ele escreve "Invalid Move!" no ecrã e pede ao user para escrever o move outra vez.
  
</p>

### Fim do Jogo
<p align="justify">
Durante o decorrer do jogo ele está sempre a correr o predicado check_mate(+Valid_Moves) (percorre a lista de movimentos válidos até encontrar um movimento do rei, senão encontrar então está em check_mate) para verificar se o player está em check mate, se estiver em check mate então ele tira todas as peças do tabuleiro, fazendo uso do predicado retractall(), e chama o predicado game_over(+Board, +Winner) que declara o vencedor do jogo e acaba com ele.
</p>

### Avaliação do Estado do Jogo
<p align="justify">
Por má gestão de tempo, não conseguimos criar um predicado para avaliar o estado do jogo.
</p>

### Jogadas de Computador
<p align="justify">
Mais uma vez, por má gestão de tempo não conseguimos implementar o nivel 2 do computador o que significa que o computador vai estar sempre a fazer movimentos á sorte.
Criamos o predicado choose_move(+Valid, +Level, -Move) para escolher o movimento do computador consoante o seu nivel.
Tendo só o nivel 1 feito, tiramos proveito da libraria random para utilizar o predicado random_member(-Move, +Valid_Moves) para escolher um movimento á sorte da lista de movimentos válidos.
</p>

## Conclusão
Esta linguagem é uma merda


## Referências

As regras e funcionamento do jogo foram consultadas nos respetivos sites:
- https://www.iggamecenter.com/en/rules/shakti
- https://mindsports.nl/index.php/the-pit/550-shakti
- https://boardgamegeek.com/boardgame/42595/shakti
