module Main where

import Graphics.Gloss
import Window 
import Game
import Menu

main :: IO ()
main = play
       window
       background
       fps
       estadoInicial
       desenhaNaTela
       input
       atualizaJogo
