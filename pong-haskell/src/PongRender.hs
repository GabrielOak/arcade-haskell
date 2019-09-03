module PongRender where

import Graphics.Gloss

import PongBoard

render :: PongGame -> Picture
render game = pictures
    [ball
    , walls
    , mkPaddle rose 120 $ player1 game
    , mkPaddle orange (-120) $ player2 game
    ]
    where
        ball = uncurry translate (ballLoc game) $ color ballColor $ circleSolid 10
        ballColor = dark red   

wall :: Float -> Picture
wall offset = 
    translate 0 offset $
        color wallColor $
            rectangleSolid 270 10

wallColor = greyN 0.5
walls = pictures [wall 150, wall (-150)]

mkPaddle :: Color -> Float -> Float -> Picture
mkPaddle col x y = pictures
    [ translate x y $ color col $ rectangleSolid 26 86
    , translate x y $ color paddleColor $ rectangleSolid 20 80
    ]

paddleColor = light (light blue)