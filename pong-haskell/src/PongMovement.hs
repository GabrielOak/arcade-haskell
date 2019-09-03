module PongMovement where

import PongBoard
import PongCollision

moveBall :: Float -> PongGame -> PongGame
moveBall seconds game = game 
    { ballLoc = (x', y')}
    where
        (x, y) = ballLoc game
        (vx, vy) = ballVel game

        x' = x + vx * seconds
        y' = y + vy * seconds

wallBounce :: PongGame -> PongGame
wallBounce game = game {ballVel = (vx, vy') }
        where
            radius = 10

            (vx, vy) = ballVel game
            vy' | wallCollision (ballLoc game) radius = -vy
                | otherwise = vy 