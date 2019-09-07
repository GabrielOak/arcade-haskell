module PongRender where

import Graphics.Gloss

import PongBoard

import System.Exit


render :: PongGame -> Picture

render game @ Game { gameState = Menu } =
    pictures [ mKmenu orange "PONG" 0.5 0.5 (-100) 200
             , mKmenu orange "Keys :" 0.3 0.3 (-paddleDistance) 160
             , mKmenu orange "Press ''P'' to Play/Pause" 0.3 0.3 (-paddleDistance) 100
             , mKmenu orange "Press ''R'' to Recenter Ball" 0.3 0.3 (-paddleDistance) 60
             , mKmenu orange "Player 1 :" 0.3 0.3 (-paddleDistance) 0
             , mKmenu orange "Key Up" 0.3 0.3 (-paddleDistance) (-40)
             , mKmenu orange "Key Down" 0.3 0.3 (-paddleDistance) (-80)
             , mKmenu orange "Player 2 :" 0.3 0.3 (-paddleDistance) (-140)
             , mKmenu orange "''W'' to Up " 0.3 0.3 (-paddleDistance) (-180)
             , mKmenu orange "''S'' to Down" 0.3 0.3 (-paddleDistance) (-220)
             ]

render game @ Game { gameState = Paused } =
    mkStateText orange "GAME PAUSED" 0.5 0.5

render game @ Game { gameState = Playing } = pictures
            [ball
            , walls
            , scorePlayer2 game heigth
            , scorePlayer1 game heigth
            , mkPaddle rose paddleDistance $ player1 game
            , mkPaddle orange (-paddleDistance) $ player2 game
            ]
            where
                ball = uncurry translate (ballLoc game) $ color ballColor $ circleSolid 10
                ballColor = dark blue 

mKmenu :: Color -> String -> Float -> Float -> Float -> Float -> Picture
mKmenu col text x y x' y' = translate x' y' $ scale x y $ color col $ Text text 
                                
mkStateText :: Color -> String -> Float -> Float -> Picture
mkStateText col text x y = translate (-(realToFrac offset)) 0 $ scale x y $ color col $ Text text 

scorePlayer1 :: PongGame -> Int -> Picture
scorePlayer1 game offset = 
    translate (-100) 240 $
        scale 0.3 0.3 $
            color white $    
                Text  $ show $ round $ player1s game 

scorePlayer2 :: PongGame -> Int -> Picture
scorePlayer2 game offset = 
    translate (100) 240 $
        scale 0.3 0.3 $
            color white $    
                Text  $ show $ round $ player2s game 

wall :: Float -> Picture
wall offset = 
    translate 0 offset $
        color wallColor $
            rectangleSolid  (realToFrac width - 10) 20

wallColor = greyN 0.3 
walls = pictures [wall (realToFrac heigth/2 + 2), wall (-(realToFrac heigth/2 + 2))]

mkPaddle :: Color -> Float -> Float -> Picture
mkPaddle col x y = pictures
  [ translate x y $ color col $ rectangleSolid paddleWidth paddleHeigth
  , translate x y $ color paddleColor $ rectangleSolid
        (paddleWidth - paddleBorder) (paddleHeigth - paddleBorder)
  ]

paddleColor = black

