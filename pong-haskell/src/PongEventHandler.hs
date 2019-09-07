module PongEventHandler where

import PongBoard

import Graphics.Gloss.Interface.IO.Game


handleKeys :: Event -> PongGame -> PongGame


handleKeys (EventKey (Char 'r') _ _ _) game = 
    game {ballLoc = (0, 0)}

handleKeys (EventKey (Char 'p') Up _ _) game@ Game { gameState = Playing } =
    game { gameState = Paused }
handleKeys (EventKey (Char 'p') Up _ _) game@ Game { gameState = Paused } =
    game { gameState = Playing }
handleKeys (EventKey (Char 'p') Up _ _) game@ Game { gameState = Menu } =
    game { gameState = Playing }

handleKeys (EventKey (SpecialKey KeyUp) Down _ _  ) game = 
    game { player1v = 1 }
handleKeys (EventKey (SpecialKey KeyUp) Up _ _ ) game =
    game { player1v = 0 }
handleKeys (EventKey (SpecialKey KeyDown) Down _ _ ) game =
    game { player1v = -1 }
handleKeys (EventKey (SpecialKey KeyDown) Up _ _ ) game = 
    game { player1v = 0 }


handleKeys (EventKey (Char 'w') Down _ _  ) game = 
    game { player2v = 1 }
handleKeys (EventKey (Char 'w') Up _ _ ) game =
    game { player2v = 0 }
handleKeys (EventKey (Char 's') Down _ _ ) game =
    game { player2v = -1 }
handleKeys (EventKey (Char 's') Up _ _ ) game = 
    game { player2v = 0 }


handleKeys _ game = game