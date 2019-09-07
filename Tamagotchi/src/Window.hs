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
background = white

-- Janela do jogo
window :: Display
window = InWindow "Tamagotchi" (width,height) (offset, offset)

renderText :: Float -> Float -> Color -> String -> Picture
renderText x y cor umaString = translate (x) (y) $ scale 0.2 0.3 $ color cor $ text umaString 

