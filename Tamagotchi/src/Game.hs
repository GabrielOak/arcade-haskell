module Game where


import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Tamagotchi
import Window

estadoInicial :: Estados
estadoInicial = EstadoNormal
    {
        idade = 0,
        saude = 50,
        energia = 60,
        limpeza = 50,
        peso = 3,
        felicidade = 50 
    }

fps :: Int
fps = 60

estadoAtual = brincar estadoInicial
estadoAtual2 = darRemedio estadoAtual

todos = mostrarStatusTodos estadoInicial

estados = pictures todos

desenhaNaTela :: Estados -> Picture
desenhaNaTela game = pictures $ mostrarStatusTodos game
    
input :: Event -> Estados -> Estados
input (EventKey (Char 'c') Down _ _) game = comer game
input (EventKey (Char 'b') Down _ _) game = brincar game
input (EventKey (Char 't') Down _ _) game = tomarBanho game
input (EventKey (Char 'd') Down _ _) game = darRemedio game
input (EventKey (Char 'e') Down _ _) game = envelhecer game
input _ game = game

atualizaJogo :: Float -> Estados -> Estados
atualizaJogo segundos game = game 
