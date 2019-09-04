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

            (vx, vy) = ballVel game
            vy' | wallCollision (ballLoc game) ballRadius = -vy
                | otherwise = vy 


paddleBounce :: PongGame -> PongGame
paddleBounce game = game { ballVel = (vx', vy)}
        where
            (vx, vy) = ballVel game

            vx' | paddleCollision game = (-vx)
                | otherwise = vx