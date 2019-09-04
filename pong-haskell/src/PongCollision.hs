module PongCollision where

import PongBoard

type Radius = Float
type Position = (Float, Float)

wallCollision :: Position -> Radius -> Bool
wallCollision (_,y) radius = topCollision || bottomCollision
        where
            topCollision = y - radius <= -fromIntegral width / 2
            bottomCollision = y + radius >= fromIntegral width / 2 

paddleCollision :: PongGame -> Bool
paddleCollision game = 
    ((deltaXP1 * deltaXP1 + deltaYP1 * deltaYP1) < (ballRadius * ballRadius))
    || ((deltaXP2 * deltaXP2 + deltaYP2 * deltaYP2) < (ballRadius * ballRadius))
    where

        (x, y) = ballLoc game

        paddleXP1 = paddleDistance
        paddleYP1 = player1 game

        paddleXP2 = -paddleDistance
        paddleYP2 = player2 game

        paddleCornerXP1 = paddleXP1 -paddleWidth / 2
        paddleCornerYP1 = paddleYP1 -paddleWidth / 2

        paddleCornerXP2 = paddleXP2 -paddleWidth / 2
        paddleCornerYP2 = paddleYP2 -paddleWidth / 2

        deltaXP1 = x - max paddleCornerXP1 (min x (paddleCornerXP1 + paddleWidth))
        deltaYP1 = y - max paddleCornerYP1 (min y (paddleCornerYP1 + paddleWidth))

        deltaXP2 = x - max paddleCornerXP2 (min x (paddleCornerXP2 + paddleWidth))
        deltaYP2 = y - max paddleCornerYP2 (min y (paddleCornerYP2 + paddleWidth))