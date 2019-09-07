module PongBoard where

import Graphics.Gloss
import Graphics.Gloss.Interface.Environment

background :: Color
background = black

width, heigth, offset, screenOffset :: Int
width = 700
heigth = 600
offset = 240
screenOffset = 100

paddleWidth, paddleHeigth, paddleBorder, paddleDistance, ballRadius :: Float
paddleWidth = 26
paddleHeigth = 86
paddleBorder = 11
paddleDistance = 330
ballRadius = 10

data GameState =
    Playing | Paused | Menu
    deriving Show

data PongGame = Game 
    { ballLoc :: (Float, Float)
    , ballVel :: (Float, Float)
    , player1 :: Float
    , player1v :: Float
    , player1s :: Float
    , player2 :: Float
    , player2v :: Float
    , player2s :: Float
    , paused :: Bool
    , gameState :: GameState
    , paddleStep :: Float
    }  deriving Show

initialState :: PongGame
initialState = Game 
    { ballLoc = (-10, 30)
    , ballVel = (150, -150)
    , player1 = 0
    , player1v = 0
    , player1s = 0
    , player2 = -80
    , player2v = 0
    , player2s = 0
    , paused = False
    , gameState = Menu
    , paddleStep = 4
    }