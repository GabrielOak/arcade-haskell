module PongCollision where

import PongBoard

type Radius = Float
type Position = (Float, Float)

wallCollision :: Position -> Radius -> Bool
wallCollision (_,y) radius = topCollision || bottomCollision
        where
            topCollision = y - radius <= -fromIntegral width / 2
            bottomCollision = y + radius >= fromIntegral width / 2 