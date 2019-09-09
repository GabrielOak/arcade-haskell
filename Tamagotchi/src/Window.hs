module Window where

import Graphics.Gloss

-- Largura da janela
width :: Int
width = 1200

-- Altura da janela
height :: Int
height = 800

-- Posição da janela
offset :: Int
offset = 100

-- Cor de fundo
background :: Color
background = black

-- Janela do jogo
window :: Display
window = InWindow "Menu" (width,height) (offset, offset)

renderText :: Float -> Float -> Float -> Float-> Color -> String -> Picture
renderText x y h w cor umaString = translate (x) (y) $ scale h w $ color cor $ text umaString 

