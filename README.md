
# Projeto: Arcade de Jogos

**Ezequiel de Oliveira dos Reis - 160119316**  
**Felipe Campos de Almeida - 160119553**  
**Gabriel de Jesus Carvalho - 16/0120918**  
**Guilherme de Oliveira Aguiar - 160123119**  


## Haskell 
A linguagem haskell é uma linguagem puramente funcional e foi utilizada para a criação dos jogos  apresentados neste projeto. para o auxílio da criação da interface dos jogos falaremos adiante.

### Pacotes Externos	
Para elaborar a interface dos jogos nosso grupo optou por utilizar o Gloss, que é uma biblioteca de criar gráficos 2D, que também oferece funções de animação e simulação, que foram usadas para atualizar o estado do jogo. Para o download e integração do Gloss no projeto foi usado o Cabal, que é um gerenciador de bibliotecas e programas feitos em Haskell.


### Execução

Para executar um jogo, entre na pasta do jogo que deseja jogar, e execute o comando "cabal run".
A versão utilizada do cabal no projeto é: 3.0.0.0
Caso seja necessário, execute "cabal install pacote" para instalar os necessárias.

## Jogo 1 - Pong

Pong é um jogo multiplayer que simula o “Ténis de mesa” que surgiu na Inglaterra no século XIX, o jogo consiste em dois jogadores cada jogador tem uma ferramenta, e uma bola, quando a bola passa do jogador o adversário marca pontos. para iniciar e aprender a linguagem o grupo se baseou em um artigo sobre o uso das ferramentas e desenhar na tela o básico de um pong, o diferencial foi implementar os movimentos, melhorar o visual, criar menus e melhorar a jogabilidade, o artigo citado está nas referências.

Os comandos básicos são:

**P** - Para Iniciar e Pausar   
**C** - Recentralizar a Bola Na Tela  
**R** - Reinicia o jogo  

**Jogador 1**

**Up** - Movimento para cima  
**Down** - Movimento para Baixo  

**Jogador 2**

**W** - Movimento para cima  
**S** - Movimento para Baixo  


## Jogo 2 - Devilgotchi
Tamagotchi é um jogo single player onde seu objetivo é cuidar do seu demoninho, que tem quatro necessidades: Fome,  Vitalidade, Energia e Satisfação. Para cuidar do seu bichinho você pode realizar três ações: fazer um sacrifício, brincar com ele e realizar um ritual de cura. O jogo termina quando o status de vitalidade do seu demoninho chega a zero.   

Os controles são:  
**S** - Realizar sacrifício para o demoninho.  
**B** - Brincar com o demoninho.  
**C** - Realizar um ritual de cura para o demoninho.  


## Jogo 3 - Tag and Run

Tag and Run, é um jogo de dois jogadores, onde o objetivo é que um dos jogadores fuja enquanto o outro tente capturá-lo. O jogador Verde deve Correr, enquanto o jogador Vermelho deve capturar. 

Os controles são:  

**P** - Pausa  
**[** - Reset  

**Jogador 1**

**W** - Movimento para cima  
**A** - Movimento para esquerda  
**X** - Movimento para baixo  
**D** - Movimento para direita  
**Q** - Movimento para esquerda-cima  
**E** - Movimento para direita-cima  
**Z** - Movimento para esquerda-baixo  
**C** - Movimento para direita-baixo  

**Jogador 2**

**U** - Movimento para cima  
**H** - Movimento para esquerda  
**M** - Movimento para baixo  
**K** - Movimento para direita  
**Y** - Movimento para esquerda-cima  
**I** - Movimento para direita-cima  
**N** - Movimento para esquerda-baixo  
 **,** - Movimento para direita-baixo  

## Jogo 4 - Snake

Snake é o jogo clássico, lançado em 1976. É popularmente conhecido, no Brasil, como “jogo da cobrinha” e foi popularizado nos anos 90, por ser um jogo que vinha instalado nos aparelhos da Nokia da época.

**Seta para cima** - Movimenta a cobra para cima  
**Seta para baixo**  - Movimenta a cobra para baixo  
**Seta para esquerda** - Movimenta a cobra para esquerda  
**Seta para direita** - Movimenta a cobra para a direita  
**P** - Pausa o jogo  
**N** - Inicia um novo jogo  

## Cabal
Os integrantes do grupo apresentaram problemas na instalação e uso do cabal, e de outras dependências por isso o time guardou os comandos que funcionam na instalação das dependências em um shell script focado no ubuntu 18.04 para auxiliar quem quiser rodar o projeto. o script se encontra na raiz do projeto Script.

para executar o script no ubuntu 18.04 segue os comandos:

    chmod +x simple_cabal_haskell_environment_ubuntu18-04.sh

    ./simple_cabal_haskell_environment_ubuntu18-04.sh

## Execução
os arquivos estão separados por pastas para  executar o respectivo jogo, entre na pasta e use o comando 

    cabal && cabal run  
    
além dos jogos temos um menu principal que o grupo se comprometeu a fazer e teve problemas para integrar todos os módulos funcionais, resolvendo deixá-los separados.
caso seja necessário para limpar os arquivos executaveis, utilize:
    
        cabal clean
        


Referências:
- [Cabal](https://www.haskell.org/cabal/users-guide/intro.html)
- [Gloss](http://hackage.haskell.org/package/gloss)
- [Your First Haskell Application](http://andrew.gibiansky.com/blog/haskell/haskell-gloss/)
- [Making a Gloss Game](https://mmhaskell.com/blog/2019/3/25/making-a-glossy-game-part-1)
