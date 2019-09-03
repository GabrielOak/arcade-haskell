module Main(main) where

import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort
import Graphics.Gloss.Interface.IO.Game

import PongRender
import PongBoard
import PongMovement
import PongEventHandler

window :: Display
window = InWindow "Pong" (width, height) (offset, offset)

fps :: Int
fps = 60

updateIO :: Float -> PongGame -> IO PongGame
updateIO seconds game = return $ update seconds game

update :: Float -> PongGame -> PongGame
update seconds = wallBounce . moveBall seconds

main :: IO ()
main = play window background fps initialState render handleKeys update