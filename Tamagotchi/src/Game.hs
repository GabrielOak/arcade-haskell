module Game where


import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Tamagotchi
import Window

estadoInicial :: Estados
estadoInicial = EstadoNormal
    {
        fome = 40,
        forca = 60,
        energia = 50,
        satisfacao = 50,
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

                               statusForca,
                               barraForca,
                               barraForcaContorno,

                               statusFome,
                               barraFome,
                               barraFomeContorno,

                               statusEnergia,
                               barraEnergia,
                               barraEnergiaContorno,
                               
                               fomi]
    where 
        leftEye = drawEyes (-85) 150 30 (pupila game)
        rightEye = drawEyes 85 150 30 (pupila game)
        mouth = desenhaBoca 180 0 (boca game)

        -- Barra de satisfação
        statusSatisfacao = renderText (-555) (330) white $ "Satisfacao"
        barraSatisfacao = desenhaBarra  (-500) 300 (satisfacao game) 30 red
        barraSatisfacaoContorno = desenhaBarraContorno (-500) 300 110 40 white

        fomi = renderText 0 (-100) white $ mostrarStatusUnico 'f' game

        -- Barra de fome
        statusFome = renderText (-555) (230) white $ "Fome"
        barraFome = desenhaBarra  (-500) 200 (fome game) 30 red
        barraFomeContorno = desenhaBarraContorno (-500) 200 110 40 white

        -- Barra de força
        statusForca = renderText (-555) (130) white $ "Vitalidade"
        barraForca = desenhaBarra  (-500) 100 (forca game) 30 red
        barraForcaContorno = desenhaBarraContorno (-500) 100 110 40 white

        -- Barra de energia
        statusEnergia = renderText (-555) (30) white $ "Energia"
        barraEnergia = desenhaBarra  (-500) 0 (energia game) 30 red
        barraEnergiaContorno = desenhaBarraContorno (-500) 0 110 40 white
    
input :: Event -> Estados -> Estados
input (EventKey (Char 's') Down _ _) game = sacrificio game
input (EventKey (Char 'b') Down _ _) game = brincar game
input (EventKey (Char 'c') Down _ _) game = cura game
input _ game = game

atualizaJogo :: Float -> Estados -> Estados
atualizaJogo segundos game = game 
