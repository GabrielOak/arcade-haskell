module PongRender where

import Graphics.Gloss

import PongBoard

render :: PongGame -> Picture
render game @ Game { gameState = Paused } =
    mkStateText orange "PAUSED" 0.5 0.5

render game @ Game { gameState = Playing } = pictures
            [ball
            , walls
            , mkPaddle rose paddleDistance $ player1 game
            , mkPaddle orange (-paddleDistance) $ player2 game
            ]
            where
                ball = uncurry translate (ballLoc game) $ color ballColor $ circleSolid 10
                ballColor = dark red 
                
mkStateText :: Color -> String -> Float -> Float -> Picture
mkStateText col text x y = translate (-120) 0 $ scale x y $ color col $ Text text 

wall :: Float -> Picture
wall offset = 
    translate 0 offset $
        color wallColor $
            rectangleSolid  (realToFrac width - 10) 20

wallColor = greyN 0.5 
walls = pictures [wall (realToFrac heigth/2 + 2), wall (-(realToFrac heigth/2 + 2))]

mkPaddle :: Color -> Float -> Float -> Picture
mkPaddle col x y = pictures
    [ translate x y $ color col $ rectangleSolid 26 86
    , translate x y $ color paddleColor $ rectangleSolid 20 80
    ]

paddleColor = light (light blue)

