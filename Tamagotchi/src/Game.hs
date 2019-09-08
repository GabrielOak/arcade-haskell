module Game where


import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Tamagotchi
import Window

estadoInicial :: Estados
estadoInicial = EstadoNormal
    {
        satisfação = 0,
        confiança = 0,
        força = 60,
        influência = 60,
        raiva = 20,
        pupila = 20,
        boca  = 75
    }

fps :: Int
fps = 60

desenhaNaTela :: Estados -> Picture
desenhaNaTela game = pictures [leftEye,
                               rightEye,
                               mouth,

                               statusSatisfacao,
                               barraSatisfacao,
                               barraSatisfacaoContorno,

                               statusConfianca,
                               barraConfianca,
                               barraConfiancaContorno,

                               statusForca,
                               barraForca,
                               barraForcaContorno,

                               statusInfluencia,
                               barraInfluencia,
                               barraInfluenciaContorno,

                               statusRaiva,
                               barraRaiva,
                               barraRaivaContorno]
    where 
        leftEye = drawEyes (-85) 150 30 (pupila game)
        rightEye = drawEyes 85 150 30 (pupila game)
        mouth = desenhaBoca 180 0 (boca game)

        -- Barra de satisfação
        statusSatisfacao = renderText (-555) (330) white $ "Satisfacao"
        barraSatisfacao = desenhaBarra  (-500) 300 (satisfação game) 30 red
        barraSatisfacaoContorno = desenhaBarraContorno (-500) 300 110 40 white

        -- Barra de confiança
        statusConfianca = renderText (-555) (230) white $ "Confianca"
        barraConfianca = desenhaBarra  (-500) 200 (confiança game) 30 red
        barraConfiancaContorno = desenhaBarraContorno (-500) 200 110 40 white

        -- Barra de confiança
        statusForca = renderText (-555) (130) white $ "Forca"
        barraForca = desenhaBarra  (-500) 100 (força game) 30 red
        barraForcaContorno = desenhaBarraContorno (-500) 100 110 40 white

        -- Barra de confiança
        statusInfluencia = renderText (-555) (30) white $ "Influencia"
        barraInfluencia = desenhaBarra  (-500) 0 (influência game) 30 red
        barraInfluenciaContorno = desenhaBarraContorno (-500) 0 110 40 white

        -- Barra de confiança
        statusRaiva = renderText (-555) (-70) white $ "Raiva"
        barraRaiva = desenhaBarra  (-500) (-100) (raiva game) 30 red
        barraRaivaContorno = desenhaBarraContorno (-500) (-100) 110 40 white
    
input :: Event -> Estados -> Estados
input (EventKey (Char 's') Down _ _) game = sacrificio game
input (EventKey (Char 'c') Down _ _) game = conhecer game
input (EventKey (Char 'e') Down _ _) game = exorcizar game
input _ game = game

atualizaJogo :: Float -> Estados -> Estados
atualizaJogo segundos game = game 
