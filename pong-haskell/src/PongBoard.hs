module PongBoard where

import Graphics.Gloss

background :: Color
background = black

width, height, offset :: Int
width = 500
height = 500
offset = 100

paddleWidth, paddleHeight, paddleBorder, paddleDistance, paddleStep, ballRadius :: Float
paddleWidth = 26
paddleHeight = 86
paddleBorder = 11
paddleDistance = 230
paddleStep = 5
ballRadius = 10

data PongGame = Game 
    { ballLoc :: (Float, Float)
    , ballVel :: (Float, Float)
    , player1 :: Float
    , player1v :: Float
    , player2 :: Float
    , player2v :: Float
    }  deriving Show

initialState :: PongGame
initialState = Game 
    { ballLoc = (-10, 30)
    , ballVel = (40, -100)
    , player1 = 40
    , player1v = 0
    , player2 = -80
    , player2v = 0
    }