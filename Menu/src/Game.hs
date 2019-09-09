module Game where


import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Menu
import Window

estadoInicial :: Menu
estadoInicial = Menu
    {
        posicao = (0,30)
    }

fps :: Int
fps = 60

desenhaNaTela :: Menu -> Picture
desenhaNaTela game = pictures 
    [ arcade
    , arcadeShadow
    , selecionador
    , pong
    , runAndTag
    , devilgotchi
    , snake
    ]
    where 
        arcade = renderText (-300) (180) 0.5 1 white $ "ARCADE HASKELL"
        arcadeShadow = renderText (-297) (183) 0.5 1 red $ "ARCADE HASKELL"
        pong = renderText (-250) (10) 0.5 0.5 white $ "   PONG"
        runAndTag = renderText (-250) (-70) 0.5 0.5 white $ "RUN AND TAG"
        devilgotchi = renderText (-250) (-140) 0.5 0.5 white $ " DEVILGOTCHI"
        snake = renderText (-250) (-220) 0.5 0.5 white $ "   SNAKE"
        selecionador = desenhaBarraContorno x y 510 80 white
        (x,y) = posicao game
            
    
input :: Event -> Menu -> Menu

input (EventKey (SpecialKey KeyDown) Down _ _) menu@ Menu { posicao = (0,-195) } =
    menu

input (EventKey (SpecialKey KeyUp) Down _ _) menu@ Menu { posicao = (0,30) } =
    menu

input (EventKey (SpecialKey KeyDown) Down _ _) menu = menu {posicao = (0,y')}
        where
            (x, y) = posicao menu
            y' = y - 75

input (EventKey (SpecialKey KeyUp) Down _ _) menu = menu {posicao = (0,y')}
        where
            (x, y) = posicao menu
            y' = y + 75

input _ menu = menu

atualizaJogo :: Float -> Menu -> Menu
atualizaJogo segundos menu = menu

