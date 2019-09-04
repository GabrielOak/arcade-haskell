module PongBoard where

import Graphics.Gloss

background :: Color
background = black

width, height, offset :: Int
width = 500
height = 500
offset = 100

data PongGame = Game 
    { ballLoc :: (Float, Float)
    , ballVel :: (Float, Float)
    , player1 :: Float
    , player2 :: Float
    }  deriving Show

initialState :: PongGame
initialState = Game 
    { ballLoc = (-10, 30)
    , ballVel = (40, -100)
    , player1 = 40
    , player2 = -80
    }