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

movePaddles :: PongGame -> PongGame
movePaddles game = game { player1 = movePaddle paddleStep (player1v game) (player1 game)
                        , player2 = movePaddle paddleStep (player2v game) (player2 game)
                        }

movePaddle :: Float -> Float -> Float -> Float
movePaddle step velocity player | velocity == 0 = player
                                | player >= fromIntegral offset && velocity < 0 = player + (step * velocity)
                                | player <= fromIntegral (-offset) && velocity > 0 = player + (step * velocity)
                                | player > fromIntegral (-offset) && player < fromIntegral offset = player + (step * velocity)
                                | otherwise = player
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