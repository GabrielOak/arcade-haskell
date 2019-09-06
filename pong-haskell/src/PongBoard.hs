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

paddleWidth, paddleHeigth, paddleBorder, paddleDistance, paddleStep, ballRadius :: Float
paddleWidth = 26
paddleHeigth = 86
paddleBorder = 11
paddleDistance = 330
paddleStep = 5
ballRadius = 10

data GameState =
    Playing | Paused
    deriving Show

data PongGame = Game 
    { ballLoc :: (Float, Float)
    , ballVel :: (Float, Float)
    , player1 :: Float
    , player1v :: Float
    , player2 :: Float
    , player2v :: Float
    , paused :: Bool
    , gameState :: GameState
    }  deriving Show

initialState :: PongGame
initialState = Game 
    { ballLoc = (-10, 30)
    , ballVel = (200, -200)
    , player1 = 40
    , player1v = 0
    , player2 = -80
    , player2v = 0
    , paused = False
    , gameState = Playing
    }