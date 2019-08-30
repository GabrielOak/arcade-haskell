module Main(main) where

import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort
import Graphics.Gloss.Interface.Pure.Game

width, height, offset :: Int
width = 300
height = 300
offset = 100

window :: Display
window = InWindow "Pong" (width, height) (offset, offset)

background :: Color
background = black

--drawing :: Picture
--drawing = pictures  [ball ,walls,
--                    mkPaddle rose 120 (-20),
--                    mkPaddle orange (-120) 40]
--    where
--        ball = translate (-10) 40 $ color ballColor $ circleSolid 10
--        ballColor = dark red


data PongGame = Game
    { ballLoc :: (Float, Float)
    , ballVel :: (Float, Float)
    , player1 :: Float
    , player2 :: Float
    } deriving Show


initialState :: PongGame
initialState = Game
    { ballLoc = (-10, 30)
    , ballVel = (1, -3)
    , player1 = 40
    , player2 = -80
    }


render :: PongGame -> Picture
render game = pictures [ball , walls,
                        mkPaddle rose 120 $ player1 game,
                        mkPaddle orange (-120) $ player2 game]
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
    [translate x y $ color col $ rectangleSolid 26 86
    ,translate x y $ color paddleColor $ rectangleSolid 20 80
    ]

paddleColor = light (light blue)

moveBall :: Float -> PongGame -> PongGame
moveBall seconds game = game { ballLoc = (x', y')}
    where 
        (x, y) = ballLoc game
        (vx, vy) = ballVel game

        x' = x + vx * seconds
        y' = y + vy * seconds
       
        
-- simulate :: Display -> Color -> Int -> a -> (a -> Picture) -> (ViewPort -> Float -> a -> a) -> IO ()

fps :: Int
fps = 60


-- paddleBounce :: PongGame -> PongGame



type Radius = Float
type Position = (Float, Float)

wallCollision :: Position -> Radius -> Bool
wallCollision (_ , y) radius = topCollision || bottomCollision
    where
        topCollision = y - radius <= -fromIntegral width / 2
        bottomCollision = y + radius >= fromIntegral width / 2
    
wallBounce :: PongGame -> PongGame
wallBounce game = game { ballVel = (vx, vy') }
  where
    -- Radius. Use the same thing as in `render`.
    radius = 10

    -- The old velocities.
    (vx, vy) = ballVel game

    vy' = if wallCollision (ballLoc game) radius
          then
             -- Update the velocity.
             -vy
           else
            -- Do nothing. Return the old velocity.
            vy


update ::Float -> PongGame -> PongGame
update seconds = wallBounce . moveBall seconds

handleKeys :: Event -> PongGame -> PongGame
handleKeys (EventKey (Char 's') _ _ _ ) game = game {ballLoc = (0,0)}
handleKeys _ game = game

-- play :: Display -> Color -> Int -> a -> (a -> Picture) -> (Event -> a -> a) -> (Float -> a -> a) -> IO ()

main :: IO ()
main = play window background fps initialState render handleKeys update