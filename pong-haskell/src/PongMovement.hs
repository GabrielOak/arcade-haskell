module PongMovement where

import PongBoard
import PongCollision

moveBall :: Float -> PongGame -> PongGame

moveBall _ game @ Game { gameState = Paused} = game
moveBall _ game @ Game { gameState = Menu} = game
moveBall seconds game = game { ballLoc = (x', y')}
                    where
                        (x, y) = ballLoc game
                        (vx, vy) = ballVel game
                    
                        x' = x + (vx + 1) * seconds
                        y' = y + (vy + 1) * seconds

movePaddles :: PongGame -> PongGame
movePaddles game @ Game { gameState = Paused} = game
movePaddles game @ Game { gameState = Menu} = game
movePaddles game = game { player1 = movePaddle (paddleStep game) (player1v game) (player1 game)
                        , player2 = movePaddle (paddleStep game) (player2v game) (player2 game)
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

updateScore :: PongGame -> PongGame
updateScore game | x > (paddleDistance + paddleWidth) = game {player1s = scorep1, ballLoc = (x',0), ballVel = (vx'* 1.2, vy* 1.2), paddleStep = pt}
                 | x < (-(paddleDistance + paddleWidth)) = game {player2s = scorep2, ballLoc = (x'',0), ballVel = (vx'* 1.2, vy* 1.2), paddleStep = pt}
                 | otherwise = game
            where 
                (x, y) = ballLoc game

                scorep1 = (player1s game) + 1
                scorep2 = (player2s game) + 1

                (vx, vy) = ballVel game

                vx' = vx * (-1) 

                pt = (paddleStep game) + 1

                x' = paddleDistance - paddleWidth * 2
                x'' = -paddleDistance + paddleWidth * 2
