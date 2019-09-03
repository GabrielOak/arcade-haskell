module PongEventHandler where

import PongBoard

import Graphics.Gloss.Interface.IO.Game

handleKeys :: Event -> PongGame -> PongGame
handleKeys (EventKey (Char 's') _ _ _) game = 
    game {ballLoc = (0, 0)}
handleKeys _ game = game