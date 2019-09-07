module Tamagotchi where

import Window
import Graphics.Gloss

data Estados = EstadoNormal 
    {
        idade :: Int,
        saude :: Int,
        energia :: Int,
        limpeza :: Int,
        peso :: Int,
        felicidade :: Int
    } deriving (Show)

comer :: Estados -> Estados
comer EstadoNormal 
    { 
        idade = i, 
        saude = s, 
        energia = e, 
        limpeza = l,
        peso = p,
        felicidade = f
    } 
    =
    EstadoNormal
    {
        idade = i, 
        saude = if(s >= 100) then (s+1) else s,
        energia = if(e /= 100) then (e+1) else e, 
        limpeza = if(l /= 0) then (l-1) else l,
        peso = p+1,
        felicidade = if(s >= 100) then (s+1) else s  
    }

tomarBanho :: Estados -> Estados
tomarBanho EstadoNormal     
    { 
        idade = i, 
        saude = s, 
        energia = e, 
        limpeza = l,
        peso = p,
        felicidade = f
    } 
    =
    EstadoNormal
    {
        idade = i, 
        saude = s,
        energia = e, 
        limpeza = if(l /= 100) then (l+1) else l,
        peso = p,
        felicidade = f
    }

brincar :: Estados -> Estados
brincar EstadoNormal     
    { 
        idade = i, 
        saude = s, 
        energia = e, 
        limpeza = l,
        peso = p,
        felicidade = f
    } 
    =
    EstadoNormal
    {
        idade = i, 
        saude = s,
        energia = if(e >= 25) then (e-25) else 0, 
        limpeza = if(l /= 0) then (l-1) else l,
        peso = p-1,
        felicidade = if (f /= 100) then (f+1) else f  
    }

darRemedio :: Estados -> Estados
darRemedio EstadoNormal     
    { 
        idade = i, 
        saude = s, 
        energia = e, 
        limpeza = l,
        peso = p,
        felicidade = f
    } 
    =
    EstadoNormal
    {
        idade = i, 
        saude = if(s >= 80) then 100 else (s+20),
        energia = e, 
        limpeza = l,
        peso = p,
        felicidade = if(s >= 25) then (s-25) else 0  
    }

envelhecer :: Estados -> Estados
envelhecer EstadoNormal     
    { 
        idade = i, 
        saude = s, 
        energia = e, 
        limpeza = l,
        peso = p,
        felicidade = f
    } 
    =
    EstadoNormal
    {
        idade = i+1, 
        saude = s,
        energia = e, 
        limpeza = l,
        peso = p,
        felicidade = f  
    }
    
mostrarStatusUnico :: Char -> Estados -> String
mostrarStatusUnico char (EstadoNormal 
    { 
        idade = i, 
        saude = s, 
        energia = e, 
        limpeza = l,
        peso = p,
        felicidade = f
    })  
        | (char == 'i') = "\nIdade: " ++ show i
        | (char == 's') = "\nSaude: " ++ show s
        | (char == 'e') = "\nEnergia: " ++ show e
        | (char == 'l') = "\nLimpeza: " ++ show l
        | (char == 'p') = "\nPeso: " ++ show p
        | (char == 'f') = "\nFelicidade: " ++ show f

mostrarStatusTodos :: Estados -> [Picture]
mostrarStatusTodos estado = [i,s,e,l,p,f]
    where
        i = renderText (-600) (350) black $ mostrarStatusUnico 'i' estado
        s = renderText (-600) (300) black $ mostrarStatusUnico 's' estado
        e = renderText (-600) (250) black $ mostrarStatusUnico 'e' estado
        l = renderText (-600) (200) black $ mostrarStatusUnico 'l' estado
        p = renderText (-600) (150) black $ mostrarStatusUnico 'p' estado
        f = renderText (-600) (100) black $ mostrarStatusUnico 'f' estado
        
        
        

