module Main(main) where

import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort

import PongRender
import PongBoard
import PongMovement
import PongEventHandler

window :: Display
window = InWindow "Pong" (width, heigth) (screenOffset, screenOffset)

fps :: Int
fps = 60

update :: Float -> PongGame -> PongGame
update seconds = updateScore . movePaddles . wallBounce . paddleBounce . moveBall seconds


main :: IO ()
main = play window background fps initialState render handleKeys update