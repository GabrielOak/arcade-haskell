module Game where


import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Tamagotchi
import Window

estadoInicial :: Estados
estadoInicial = EstadoNormal
    {
        idade = 0,
        saude = 100,
        energia = 100,
        limpeza = 100,
        peso = 3,
        felicidade = 100 
    }

fps :: Int
fps = 60
estadoAtual = brincar estadoInicial
estadoAtual2 = darRemedio estadoAtual

stringEstado =  renderText 0 0 black $ mostrarStatusUnico 'f' estadoAtual

stringEstado2 =  renderText 0 (-100) blue $ mostrarStatusUnico 'f' estadoAtual2

todos = mostrarStatusTodos estadoAtual2

estados = pictures todos

desenhaNaTela :: Estados -> Picture
desenhaNaTela game = pictures todos

    
input :: Event -> Estados -> Estados

