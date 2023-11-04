# Trabalho Prático 1 : Shakti

Grupo Shakti_1:

- Bruno Drumond (up201202666) - Contribuição: 0.1%
- Gonçalo Nadais de Pinho (up202108672) - Contribuição: 99.9%


## Instalação e Execução

No caso de não possuir o software Sicstus Prolog 4.8, clique [aqui](https://sicstus.sics.se/download4.html) para download e instruções de instalação.

<p align="justify">
Para instalar e correr o jogo Shakti é necessário descarregar o ficheiro <b>PFL_TP1_T14_Shakti_1.zip</b> e, posteriormente, descompactá-lo. Uma vez descompactado, basta aceder ao diretório <b>source-code</b> e consultar o ficheiro <b>main.pl</b> (pela UI do Sicstus Prolog 4.8 ou através da linha de comandos). O jogo é iniciado com o predicado <b>play/0</b>, sendo suportado por ambientes Windows e Linux.
</p>

## Descrição do Jogo

<p align="justify">
"Shakti" é um jogo de estratégia rápido (10 a 20 minutos de duração) e abstrato, projetado para dois jogadores, que foi criado em 1982 por Christian Freeling. Muitas vezes sendo descrito como uma variante do Xadrez, o jogo é jogado num tabuleiro de dimensões 7x7, onde cada célula do tabuleiro, exceto as das extremidades, possui um azulejo e cada jogador possui um rei e dois guerreiros.
O jogo inicia-se com as peças de cada jogador alinhadas, sendo o jogador detentor das peças brancas a fazer a primeira jogada. As peças apenas podem mover-se para células que apresentem um azulejo. Ganha o jogo o jogador que conseguir dar <i>checkmate</i> ao Rei do oponente, ou seja, colocar as suas peças no tabuleiro de tal forma que o Rei do seu oponente, independentemente da célula para o qual se mova, acabe sempre capturado. É possível verificar o início do jogo (imagem da esquerda) e um exemplo de fim do jogo (imagem da direita) nas imagens abaixo anexadas.
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

Se um jogador não conseguir realizar nenhuma jogada válida é obrigado a desistir do seu turno e passar a vez ao adversário.
</p>

Tanto as regras como o funcionamento do jogo foram consultadas nos seguintes websites: [Iggmaecenter](https://www.iggamecenter.com/en/rules/shakti), [Mindsports](https://mindsports.nl/index.php/the-pit/550-shakti) e [Boardgamegeek](https://boardgamegeek.com/boardgame/42595/shakti).

## Lógica do Jogo



## Conclusão


## Referências

As regras e funcionamento do jogo foram consultadas nos respetivos sites:
- https://www.iggamecenter.com/en/rules/shakti
- https://mindsports.nl/index.php/the-pit/550-shakti
- https://boardgamegeek.com/boardgame/42595/shakti
