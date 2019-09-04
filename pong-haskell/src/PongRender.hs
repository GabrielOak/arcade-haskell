module PongRender where

import Graphics.Gloss

import PongBoard

render :: PongGame -> Picture
render game = pictures
    [ball
    , walls
    , mkPaddle rose paddleDistance $ player1 game
    , mkPaddle orange (-paddleDistance) $ player2 game
    ]
    where
        ball = uncurry translate (ballLoc game) $ color ballColor $ circleSolid 10
        ballColor = dark red   

wall :: Float -> Picture
wall offset = 
    translate 0 offset $
        color wallColor $
            rectangleSolid 480 20

wallColor = greyN 0.5
walls = pictures [wall 250, wall (-250)]

mkPaddle :: Color -> Float -> Float -> Picture
mkPaddle col x y = pictures
    [ translate x y $ color col $ rectangleSolid 26 86
    , translate x y $ color paddleColor $ rectangleSolid 20 80
    ]

paddleColor = light (light blue)