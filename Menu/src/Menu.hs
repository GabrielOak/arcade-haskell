module Menu where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Window

data Menu = Menu 
    {
        posicao :: (Float,Float)
    }


desenhaBarraContorno :: Float -> Float -> Float -> Float -> Color -> Picture
desenhaBarraContorno x y w h c = translate x y
                        $ color c
                        $ rectangleWire w h


