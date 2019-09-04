module PongEventHandler where

import PongBoard

import Graphics.Gloss.Interface.IO.Game

handleKeys :: Event -> PongGame -> PongGame
handleKeys (EventKey (Char 's') _ _ _) game = 
    game {ballLoc = (0, 0)}


handleKeys (EventKey (SpecialKey KeyUp) Down _ _  ) game = 
    game { player1v = 1 }
handleKeys (EventKey (SpecialKey KeyUp) Up _ _ ) game =
    game { player1v = 0 }
handleKeys (EventKey (SpecialKey KeyDown) Down _ _ ) game =
    game { player1v = -1 }
handleKeys (EventKey (SpecialKey KeyDown) Up _ _ ) game = 
    game { player1v = 0 }


handleKeys _ game = game