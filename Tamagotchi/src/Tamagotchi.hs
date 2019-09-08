module Tamagotchi where

import Window
import Graphics.Gloss

data Estados = EstadoNormal 
    {
        satisfação :: Float,
        confiança :: Float,
        força :: Float,
        influência :: Float,
        raiva :: Float,
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
        satisfação = s,
        confiança = c,
        força = f,
        influência = i,
        raiva = r,
        pupila = p,
        boca  = b
    } 
    =
    EstadoNormal
    {
        satisfação = incrementaStatus s 5,
        confiança = incrementaStatus c 5,
        força = incrementaStatus f 5,
        influência = i,
        raiva = r,
        pupila = p-1,
        boca  = b-1
    }

conhecer :: Estados -> Estados
conhecer EstadoNormal 
    { 
        satisfação = s,
        confiança = c,
        força = f,
        influência = i,
        raiva = r,
        pupila = p,
        boca  = b
    } 
    =
    EstadoNormal
    {
        satisfação = s,
        confiança = decrementaStatus c 5,
        força = f,
        influência = decrementaStatus i 5,
        raiva = incrementaStatus r 2,
        pupila = p+1,
        boca  = b+1
    }

exorcizar :: Estados -> Estados
exorcizar EstadoNormal 
    { 
        satisfação = s,
        confiança = c,
        força = f,
        influência = i,
        raiva = r,
        pupila = p,
        boca  = b
    } 
    =
    EstadoNormal
    {
        satisfação = decrementaStatus s 5,
        confiança = decrementaStatus c 5,
        força = decrementaStatus f 5,
        influência = decrementaStatus i 5,
        raiva = incrementaStatus r 5,
        pupila = p+1,
        boca  = b+1
    }
    
mostrarStatusUnico :: Char -> Estados -> String
mostrarStatusUnico char (EstadoNormal 
    { 
        satisfação = s,
        confiança = c,
        força = f,
        influência = i,
        raiva = r,
        pupila = p,
        boca  = b
    })  
        | (char == 'i') = "\nIdade: " ++ show s
        | (char == 's') = "\nSaude: " ++ show c
        | (char == 'e') = "\nEnergia: " ++ show f
        | (char == 'l') = "\nLimpeza: " ++ show i
        | (char == 'p') = "\nPeso: " ++ show r
        | (char == 'f') = "\nFelicidade: " ++ show p

mostrarStatusTodos :: Estados -> [Picture]
mostrarStatusTodos estado = [i,s,e,l,p,f]
    where
        i = renderText (-600) (350) white $ mostrarStatusUnico 'i' estado
        s = renderText (-600) (300) white $ mostrarStatusUnico 's' estado
        e = renderText (-600) (250) white $ mostrarStatusUnico 'e' estado
        l = renderText (-600) (200) white $ mostrarStatusUnico 'l' estado
        p = renderText (-600) (150) white $ mostrarStatusUnico 'p' estado
        f = renderText (-600) (100) white $ mostrarStatusUnico 'f' estado
        
drawEyes :: Float -> Float -> Float -> Float -> Picture
drawEyes x y t r = translate x y 
              $ color red
              $ thickCircle t r

desenhaBoca :: Float -> Float -> Float -> Picture
desenhaBoca fs sn rd = translate 0 (50) 
                       $ color red
                       $ arc fs sn rd
        
desenhaBarra :: Float -> Float -> Float -> Float -> Color -> Picture
desenhaBarra x y w h c = translate x y
                       $ color c
                       $ rectangleSolid w h

desenhaBarraContorno :: Float -> Float -> Float -> Float -> Color -> Picture
desenhaBarraContorno x y w h c = translate x y
                       $ color c
                       $ rectangleWire w h


