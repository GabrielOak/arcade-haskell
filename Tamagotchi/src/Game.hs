module Game where


import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Tamagotchi
import Window

estadoInicial :: Estados
estadoInicial = EstadoNormal
    {
        fome = 50,
        forca = 60,
        energia = 50,
        satisfacao = 50,
        pupila = 20,
        boca  = 75,
        contador = 0,
        nComida = 3,
        nRemedio = 2
    }

fps :: Int
fps = 10

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

                               quadradoSacrificio,
                               caveiraInferior,
                               caveiraSuperior,
                               caveiraOlhoE,
                               caveiraOlhoD,
                               letraS,

                               quadradoBrincar,
                               sorriso,
                               bOlhoE,
                               bOlhoD,
                               letraB,

                               quadradoCurar,
                               wCruz,
                               hCruz,
                               letraC,

                               comidaCounter,
                               cx,
                               remedioCounter,
                               rx, cont

                              
                               ]
    where 
        leftEye = drawEyes (-85) 150 30 (pupila game)
        rightEye = drawEyes 85 150 30 (pupila game)
        mouth = desenhaBoca 0 50 180 0 (boca game) red

        -- Barra de satisfação
        statusSatisfacao = renderText (-555) (330) 0.2 0.3 white $ "Satisfacao"
        barraSatisfacao = desenhaBarra  (-500) 300 (satisfacao game) 30 red
        barraSatisfacaoContorno = desenhaBarraContorno (-500) 300 110 40 white

        -- Barra de fome
        statusFome = renderText (-555) (230) 0.2 0.3 white $ "Fome"
        barraFome = desenhaBarra  (-500) 200 (fome game) 30 red
        barraFomeContorno = desenhaBarraContorno (-500) 200 110 40 white

        -- Barra de força
        statusForca = renderText (-555) (130) 0.2 0.3 white $ "Vitalidade"
        barraForca = desenhaBarra  (-500) 100 (forca game) 30 red
        barraForcaContorno = desenhaBarraContorno (-500) 100 110 40 white

        -- Barra de energia
        statusEnergia = renderText (-555) (30) 0.2 0.3 white $ "Energia"
        barraEnergia = desenhaBarra  (-500) 0 (energia game) 30 red
        barraEnergiaContorno = desenhaBarraContorno (-500) 0 110 40 white


        -- Interface da ação de satisfação
        quadradoSacrificio = desenhaBarraContorno (-100) (-250) 50 50 white
        caveiraInferior = desenhaBarra (-100) (-260) 20 15 white
        caveiraSuperior = desenhaCirculo (-100) (-245) 15 white
        caveiraOlhoE = desenhaCirculo (-107) (-245) 5 black
        caveiraOlhoD = desenhaCirculo (-93) (-245) 5 black
        letraS = renderText (-107) (-300) 0.2 0.2 white "S"


        quadradoBrincar = desenhaBarraContorno (0) (-250) 50 50 white
        sorriso = desenhaBoca 0 (-255) 180 0 10 white
        bOlhoE = desenhaCirculo (-7) (-245) 2 white
        bOlhoD = desenhaCirculo (7) (-245) 2 white
        letraB = renderText (-7) (-300) 0.2 0.2 white "B"

        quadradoCurar = desenhaBarraContorno (100) (-250) 50 50 white
        wCruz = desenhaBarra 100 (-250) 30 7 white
        hCruz = desenhaBarra (100) (-250) 7 30 white
        letraC = renderText (93) (-300) 0.2 0.2 white "C"

        comidaCounter = renderText (-100) (-220) 0.2 0.2 white $ show (nComida game)
        remedioCounter = renderText (100) (-220) 0.2 0.2 white $ show (nRemedio game)
        cx = renderText (-115) (-220) 0.2 0.2 white $ "x"
        rx = renderText (85) (-220) 0.2 0.2 white $ "x"

        cont = renderText (0) (0) 0.2 0.2  white $ show $ contador game 
    
input :: Event -> Estados -> Estados
input (EventKey (Char 's') Down _ _) game = if (nComida game) > 0 then sacrificio game else game
input (EventKey (Char 'b') Down _ _) game = if (energia game) > 0 then  brincar game else game
input (EventKey (Char 'c') Down _ _) game = if (nRemedio game) > 0 then cura game else game
input _ game = game

atualizaJogo :: Float -> Estados -> Estados
atualizaJogo segundos game = atualizaCont segundos game

atualizaCont :: Float -> Estados -> Estados 
atualizaCont  segundos  game = game {contador = x, fome = fm, satisfacao = s, energia = e, pupila = p, boca = b, nComida = nc, nRemedio = nr}
        where
            fm | ((contador game) >= 20 && (contador game) <= 20.1) || ((contador game) >= 40  && (contador game) <= 40.1) = (fome game) - 20
               | (fome game ) <= 0                                                   = 0
               | otherwise                                                           = (fome game)
            x | (contador game) >= 41                                                = 0
              | otherwise                                                            = (contador game) + segundos
            s | (contador game) >= 20  && (contador game) <= 20.1 &&(fome game) <= 0 = (satisfacao game) - 12
              | otherwise                                                            = (satisfacao game)
            e | (contador game) >= 20  && (contador game) <= 20.1 && (fome game) > 0 = (energia game) + 10
              | (energia game) >= 100                                                = 100
              | otherwise                                                            = (energia game)
            p | (contador game) >= 20  && (contador game) <= 20.1 &&(fome game) <= 0 = (pupila game) + 3
              | otherwise                                                            = (pupila game)
            b | (contador game) >= 20  && (contador game) <= 20.1 &&(fome game) <= 0 = (boca game) + 4
              | otherwise                                                            = (boca game)
            nc | (contador game) >= 30  && (contador game) <= 30.1                   = (nComida game) + 1
               | otherwise                                                            = (nComida game)
            nr | (contador game) >= 40  && (contador game) <= 40.1                   = (nRemedio game) + 1
               | otherwise                                                            = (nRemedio game)     
            
         
