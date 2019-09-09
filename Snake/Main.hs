import Graphics.Gloss.Interface.Pure.Game
import System.Random

window :: World -> Display
window world = InWindow "Snake" (resolution world) (200, 200)

backgroundColor ::Color
backgroundColor = black

fps :: Int
fps = 5

initialWorld :: Int -> World
initialWorld seed = moveFood NewWorld
    { resolution = (512, 512)
    , direction = SnakeStoped
    , dimencion = 11
    , snake = [(0, 2), (0, 1), (0, 0)]
    , isOver = False
    , gen = mkStdGen seed
    , food = (0, 0)
    , isPaused = False
    }

drawWorld :: World -> Picture
drawWorld world = pictures
    [ drawBounds world
    , drawFood world
    , drawSnake world
    , drawPause world
    , drawGameOver world
    ]

handleStep :: Float -> World -> World
handleStep _time world =
    if isOver world
    then world
    else if isPaused world 
    then world 
    else
        let oldSnake = snake world
            newSnake@((x, y) : _) = init oldSnake
            (x', y') = case direction world of
                SnakeUp -> (x, y + 1)
                SnakeRight -> (x + 1, y)
                SnakeDown -> (x, y - 1)
                SnakeLeft -> (x - 1, y)
                SnakeStoped -> (x, y)
        in  if inBounds world (x', y') && not (isSnake world (x', y'))
            then if isFood world (x', y')
                then
                    let world' = moveFood world
                    in  world' { snake = (x', y') : oldSnake }
                else world { snake = (x', y') : newSnake }
            else if  direction world == SnakeStoped
                then world 
            else world { isOver = True }

--

drawBounds :: World -> Picture
drawBounds world =
    let x = size world
    in  rectangleWire x x

drawFood :: World -> Picture
drawFood world = color green (drawBox (food world) world)

drawSnake :: World -> Picture
drawSnake world = case snake world of
    (p : ps) -> pictures
        ( color white (drawBox p world)
        : map (\ x -> color white (drawBox x world)) ps
        )
    _ -> blank

drawBox :: (Int, Int) -> World -> Picture
drawBox (x, y) world =
    let s = size world / fromIntegral (dimencion world)
        x' = s * fromIntegral x
        y' = s * fromIntegral y
    in  translate x' y' (rectangleSolid s s)

drawGameOver :: World -> Picture
drawGameOver world = if isOver world
    then pictures
        [ color red  (translate (-110) (-0)(scale 0.3 0.3 (text "Game Over")))
        , color blue (translate (-50) (-50) (scale 0.2 0.2 (text ("Score: " ++ show (length (snake world))))))
        ]
    else blank 

drawPause :: World -> Picture
drawPause world = if isOver world
    then blank
    else if isPaused world
    then pictures
        [ color red  (translate (-110) (-0)(scale 0.3 0.3 (text "Paused")))
        , color blue (translate (-150) (-50) (scale 0.1 0.1 (text ("Press P to unpause"))))
        ]
    else blank 


handleResize :: (Int, Int) -> World -> World
handleResize newResolution world = world { resolution = newResolution }

handleKeys :: Event -> World -> World
handleKeys (EventKey (SpecialKey KeyRight) Down _ _) world = world { direction = SnakeRight}
handleKeys (EventKey (SpecialKey KeyLeft) Down _ _) world = world { direction = SnakeLeft}
handleKeys (EventKey (SpecialKey KeyUp) Down _ _) world = world { direction = SnakeUp}
handleKeys (EventKey (SpecialKey KeyDown) Down _ _) world = world { direction = SnakeDown}
handleKeys (EventKey (Char 'p') Down _ _) world = world {direction = SnakeStoped, isPaused = not (isPaused world)}
handleKeys _ world = world

data World = NewWorld
    { resolution :: (Int, Int)
    , direction :: Direction
    , dimencion :: Int
    , snake :: [(Int, Int)]
    , isOver :: Bool
    , gen :: StdGen
    , food :: (Int, Int)
    , isPaused :: Bool
    } deriving (Read, Show)

size :: (Num a) => World -> a
size world =
    let (width, height) = resolution world
    in  fromIntegral (min width height) 

inBounds :: World -> (Int, Int) -> Bool
inBounds world (x, y) =
    let s = dimencion world `div` 2
    in  -s <= x && x <= s && -s <= y && y <= s

isSnake :: World -> (Int, Int) -> Bool
isSnake world (x, y) = any (== (x, y)) (snake world)

isFood :: World -> (Int, Int) -> Bool
isFood world (x, y) = (x, y) == food world

moveFood :: World -> World
moveFood world =
    let g0 = gen world
        a = dimencion world `div` 2
        (x, g1) = randomR (-a, a) g0
        (y, g2) = randomR (-a, a) g1
    in  if isSnake world (x, y)
        then moveFood world { gen = g2 }
        else world { gen = g2 , food = (x, y) }

data Direction
    = SnakeUp
    | SnakeRight
    | SnakeDown
    | SnakeLeft
    | SnakeStoped 
    deriving (Bounded, Enum, Eq, Ord, Read, Show)

main :: IO ()
main = do
    seed <- randomIO
    let world = initialWorld seed

    play
        (window world)
        backgroundColor
        fps
        world
        drawWorld
        handleKeys
        handleStep
        