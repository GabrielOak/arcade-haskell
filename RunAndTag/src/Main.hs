module Main(main) where

  import Graphics.Gloss
  import Graphics.Gloss.Interface.Pure.Game
  
  width, height, offset :: Int
  width = 300
  height = 300
  offset = 100
  fps = 60
  
  wallWidth = 10
  
  runnerSpeed = 15.0 
  taggerSpeed = runnerSpeed/3*2
  
  runnerInitialPosition = ((-400.0), 0.0)
  taggerInitialPosition = (300.0, 0.0)
  
  runnerRadius = 25.0
  taggerRadius = 45.0
  
  window :: Display
  window = FullScreen
  
  background :: Color
  background = dark black
  
  type Position = (Float, Float)
  data PlayerMovement = PlayerUp | 
    PlayerLeft | 
    PlayerRight | 
    PlayerDown | 
    PlayerStill |
    PlayerLeftUp |
    PlayerLeftDown |
    PlayerRightUp |
    PlayerRightDown deriving Show
  
  data RunAndTag = Game
    { runner :: Position
    , runnerMovement :: PlayerMovement
    , tagger :: Position
    , taggerMovement :: PlayerMovement
    , score :: Float
    , over :: Bool
    , paused :: Bool
    } deriving Show
  
  initialState :: RunAndTag
  initialState = Game 
    runnerInitialPosition 
    PlayerStill 
    taggerInitialPosition 
    PlayerStill
    0
    False
    False
    
  main :: IO ()
  main = play
    window
    background
    fps  
    initialState  
    drawing
    inputHandler
    update
  
  drawing :: RunAndTag -> Picture
  drawing game = pictures [runnerBall, taggerBall, scoreText, pause, walls]
    where
  
      runnerBall = uncurry translate (runner game) $ color runnerColor $ (circleSolid runnerRadius)
      runnerColor = green
  
      taggerBall =  uncurry translate (tagger game) $ color taggerColor $ (circleSolid taggerRadius)
      taggerColor = red
  
      scoreText = translate (-15) (300) $
        scale 0.5 0.5 $
        color white $
        text $ (show (round (score game)))
  
      wallHorizontal :: Float -> Picture
      wallHorizontal offset =
        translate 0 offset $
          color wallColor $
            rectangleSolid 1280 wallWidth
  
      wallVertical :: Float -> Picture
      wallVertical offset =
        translate offset 0 $
          color wallColor $
            rectangleSolid wallWidth 720 
  
      wallColor = dark white
      walls = pictures [wallHorizontal 370, wallHorizontal (-370), wallVertical (650), wallVertical (-650)]
  
      pause = if (paused game)
        then translate (420) (330) $
          scale 0.25 0.25 $
          color white $ 
          Text "Game Paused"   
        else if (over game)
          then translate (420) (330) $
            scale 0.25 0.25 $
            color white $ 
            Text "Game Over"
        else translate (500) (270) $
        scale 0.25 0.25 $
        color white $ 
        Text ""
    
  moveRunner :: Position -> PlayerMovement -> Position
  moveRunner (px, py) PlayerUp = if abs (py - 365) <= runnerRadius 
    then (px, py) 
    else (px, py + runnerSpeed)
  moveRunner (px, py) PlayerLeft = if abs (px + 645) <= runnerRadius 
    then (px, py) 
    else (px - runnerSpeed, py)
  moveRunner (px, py) PlayerRight = if abs (px - 645) <= runnerRadius 
    then (px, py) 
    else (px + runnerSpeed, py)
  moveRunner (px, py) PlayerDown = if abs (py + 365) <= runnerRadius 
    then (px, py) 
    else (px, py - runnerSpeed)
  moveRunner (px, py) PlayerRightUp = if abs (py - 365) <= runnerRadius || abs (px - 645) <= runnerRadius
    then (px, py) 
    else (px + runnerSpeed, py + runnerSpeed)
  moveRunner (px, py) PlayerLeftUp = if abs (py - 365) <= runnerRadius || abs (px + 645) <= runnerRadius
    then (px, py) 
    else (px - runnerSpeed, py + runnerSpeed)
  moveRunner (px, py) PlayerRightDown = if abs (py + 365) <= runnerRadius || abs (px - 645) <= runnerRadius
    then (px, py) 
    else (px + runnerSpeed, py - runnerSpeed)
  moveRunner (px, py) PlayerLeftDown = if abs (py + 365) <= runnerRadius || abs (px + 645) <= runnerRadius
    then (px, py) 
    else (px - runnerSpeed, py - runnerSpeed)
  moveRunner (px, py) PlayerStill = (px, py)
  
  moveTagger :: Position -> PlayerMovement -> Position
  moveTagger (px, py) PlayerUp = if abs (py - 365) <= taggerRadius 
    then (px, py) 
    else (px, py + taggerSpeed)
  moveTagger (px, py) PlayerLeft = if abs (px + 645) <= taggerRadius 
    then (px, py) 
    else (px - taggerSpeed, py)
  moveTagger (px, py) PlayerRight = if abs (px - 645) <= taggerRadius 
    then (px, py) 
    else (px + taggerSpeed, py)
  moveTagger (px, py) PlayerDown = if abs (py + 365) <= taggerRadius 
    then (px, py) 
    else (px, py - taggerSpeed)
  moveTagger (px, py) PlayerRightUp = if abs (py - 365) <= taggerRadius || abs (px - 645) <= taggerRadius
    then (px, py) 
    else (px + taggerSpeed, py + taggerSpeed)
  moveTagger (px, py) PlayerLeftUp = if abs (py - 365) <= taggerRadius || abs (px + 645) <= taggerRadius
    then (px, py) 
    else (px - taggerSpeed, py + taggerSpeed)
  moveTagger (px, py) PlayerRightDown = if abs (py + 365) <= taggerRadius || abs (px - 645) <= taggerRadius
    then (px, py) 
    else (px + taggerSpeed, py - taggerSpeed)
  moveTagger (px, py) PlayerLeftDown = if abs (py + 365) <= taggerRadius || abs (px + 645) <= taggerRadius
    then (px, py) 
    else (px - taggerSpeed, py - taggerSpeed)
  moveTagger (px, py) PlayerStill = (px, py)
  
  movePlayers :: RunAndTag  -> RunAndTag 
  movePlayers game = game { runner = moveRunner (runner game) (runnerMovement game)
                          , tagger = moveTagger (tagger game) (taggerMovement game)
                          , score = (score game) + 0.1
                          }
  
  inputHandler :: Event -> RunAndTag  -> RunAndTag 
  inputHandler (EventKey (Char 'w') Down _ _) game = game { runnerMovement = PlayerUp }
  inputHandler (EventKey (Char 'x') Down _ _) game = game { runnerMovement = PlayerDown }
  inputHandler (EventKey (Char 'a') Down _ _) game = game { runnerMovement = PlayerLeft }
  inputHandler (EventKey (Char 'd') Down _ _) game = game { runnerMovement = PlayerRight }
  inputHandler (EventKey (Char 'e') Down _ _) game = game { runnerMovement = PlayerRightUp }
  inputHandler (EventKey (Char 'c') Down _ _) game = game { runnerMovement = PlayerRightDown }
  inputHandler (EventKey (Char 'q') Down _ _) game = game { runnerMovement = PlayerLeftUp }
  inputHandler (EventKey (Char 'z') Down _ _) game = game { runnerMovement = PlayerLeftDown }
  
  inputHandler (EventKey (Char 'u') Down _ _) game = game { taggerMovement = PlayerUp }
  inputHandler (EventKey (Char 'm') Down _ _) game = game { taggerMovement = PlayerDown }
  inputHandler (EventKey (Char 'h') Down _ _) game = game { taggerMovement = PlayerLeft }
  inputHandler (EventKey (Char 'k') Down _ _) game = game { taggerMovement = PlayerRight }
  inputHandler (EventKey (Char 'i') Down _ _) game = game { taggerMovement = PlayerRightUp }
  inputHandler (EventKey (Char ',') Down _ _) game = game { taggerMovement = PlayerRightDown }
  inputHandler (EventKey (Char 'y') Down _ _) game = game { taggerMovement = PlayerLeftUp }
  inputHandler (EventKey (Char 'n') Down _ _) game = game { taggerMovement = PlayerLeftDown }
  
  
  inputHandler (EventKey (Char 'p')  Down _ _) game = game { paused = not (paused game) } 
  inputHandler (EventKey (Char '[') Down _ _) game = initialState
  inputHandler _ w = w
  
  distance (x1 , y1) (x2 , y2) = sqrt (x'*x' + y'*y')
          where
            x' = x1 - x2
            y' = y1 - y2
  
  update :: Float -> RunAndTag -> RunAndTag
  update seconds game = if (paused game || over game)
    then game
    else if distance (runner game) (tagger game) <= (runnerRadius + taggerRadius ) 
        then  game { over = True }
        else do (movePlayers) game                