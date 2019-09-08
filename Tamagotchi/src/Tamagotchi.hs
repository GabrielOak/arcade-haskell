module Tamagotchi where

import Window
import Graphics.Gloss

data Estados = EstadoNormal 
    {
        fome :: Float,
        forca :: Float,
        energia :: Float,
        satisfacao :: Float,
        pupila :: Float,
        boca :: Float
    } deriving (Show)


incrementaStatus :: Float -> Float -> Float
incrementaStatus status i = if status < 100 then (status+i) else 100

decrementaStatus :: Float -> Float -> Float
decrementaStatus status i = if status > 0 then (status-i) else 0

sacrificio :: Estados -> Estados
sacrificio EstadoNormal 
    { 
        fome = fm,
        forca = fc,
        energia = e,
        satisfacao = s,
        pupila = p,
        boca  = b
    } 
    =
    EstadoNormal
    {
        fome = incrementaStatus fm 5,
        forca = if fm < 100 then (fc+1)
                else 
                    if fm >= 100 && fc /= 0 then (fc-2)
                    else s,
        energia = decrementaStatus e 5,
        satisfacao = s,
        pupila = if fm == 100 || e == 0 then (p+2) else (p-1),
        boca  = if fm == 100 then (b+4) else (b-1)
    }

brincar :: Estados -> Estados
brincar EstadoNormal 
    { 
        fome = fm,
        forca = fc,
        energia = e,
        satisfacao = s,
        pupila = p,
        boca  = b
    } 
    =
    EstadoNormal
    {
        fome = decrementaStatus fm 5,
        forca = if e == 0 && fc /= 0 then fc-5 else fc,
        energia = decrementaStatus e 5,
        satisfacao = if e > 0 then (s+5)
                        else 
                        if e == 0 && s /= 0 then (s-5)
                        else s,
        pupila = if e == 0 then (p+2) else (p-1),
        boca  = if e == 0 then (b+4) else (b-1)
    }    

cura :: Estados -> Estados 
cura EstadoNormal  
    { 
        fome = fm,
        forca = fc,
        energia = e,
        satisfacao = s,
        pupila = p,
        boca  = b
    } 
    =
    EstadoNormal
    {
        fome = fm,
        forca = incrementaStatus fc 10,
        energia = e,
        satisfacao = if e > 0 then (s+1)
                        else 
                        if e == 0 && s /= 0 then (s-1)
                        else s,
        pupila = decrementaStatus p 1,
        boca  = decrementaStatus b 1
    }    
mostrarStatusUnico :: Char -> Estados -> String
mostrarStatusUnico char (EstadoNormal 
    { 
        fome = fm,
        forca = fc,
        energia = e,
        satisfacao = s,
        pupila = p,
        boca  = b
    })  
        | (char == 'f') = "fome: " ++ show fm
        | (char == 'a') = "forca: " ++ show fc
        | (char == 'e') = "energia: " ++ show e
        | (char == 'l') = "satisfacao: " ++ show s
        | (char == 'p') = "pupila: " ++ show p
        | (char == 'b') = "boca: " ++ show b

mostrarStatusTodos :: Estados -> [Picture]
mostrarStatusTodos estado = [fm,fc,e,s,p,b]
    where
        fm = renderText (-600) (350) 1 1 white $ mostrarStatusUnico 'f' estado
        fc = renderText (-600) (300) 1 1 white $ mostrarStatusUnico 'a' estado
        e = renderText (-600) (250) 1 1 white $ mostrarStatusUnico 'e' estado
        s = renderText (-600) (200) 1 1 white $ mostrarStatusUnico 's' estado
        p = renderText (-600) (150) 1 1 white $ mostrarStatusUnico 'p' estado
        b = renderText (-600) (100) 1 1 white $ mostrarStatusUnico 'b' estado
        
drawEyes :: Float -> Float -> Float -> Float -> Picture
drawEyes x y t r = translate x y 
              $ color red
              $ thickCircle t r

desenhaBoca :: Float -> Float -> Float -> Float -> Float -> Color -> Picture
desenhaBoca x y fs sn rd c = translate x y
                       $ color c
                       $ arc fs sn rd
        
desenhaBarra :: Float -> Float -> Float -> Float -> Color -> Picture
desenhaBarra x y w h c = translate x y
                       $ color c
                       $ rectangleSolid w h

desenhaBarraContorno :: Float -> Float -> Float -> Float -> Color -> Picture
desenhaBarraContorno x y w h c = translate x y
                       $ color c
                       $ rectangleWire w h

desenhaCirculo :: Float -> Float -> Float -> Color -> Picture
desenhaCirculo x y r c = translate x y
                        $ color c
                        $ circleSolid r


