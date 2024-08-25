module Sprites where

import Text.Printf (printf)



getLetra:: Char -> String
getLetra 'a' = unlines [
    "▄▀▀▄",
    "█■■█",
    "█  █"
    ]
getLetra 'b' = unlines [
    "█▀▀▄",
    "█■■█",
    "█▄▄▀"
    ]
getLetra 'c' = unlines [
    "▄▀▀▄",
    "█   ",
    "▀▄▄▀"
    ]
getLetra 'd' = unlines [
    "█▀▀▄",
    "█  █",
    "█▄▄▀"
    ]
getLetra 'e' = unlines [
    "▄▀▀▀",
    "█■■ ",
    "▀▄▄▄"
    ]
getLetra 'f' = unlines [
    "▄▀▀▀",
    "█■■ ",
    "█   "
    ]
getLetra 'g' = unlines [
    "▄▀▀ ",
    "█ ▀█",
    "▀▄▄▀"
    ]
getLetra 'h' = unlines [
    "█  █",
    "█■■█",
    "█  █"
    ]
getLetra 'i' = unlines [
    " ▐▌ ",
    " ▐▌ ",
    " ▐▌ "
    ]
getLetra 'j' = unlines [
    "   █",
    "   █",
    "▀▄▄▀"
    ]
getLetra 'k' = unlines [
    "█ ▄▀",
    "██  ",
    "█ ▀▄"
    ]
getLetra 'l' = unlines [
    "█   ",
    "█   ",
    "▀▄▄▄"
    ]
getLetra 'm' = unlines [
    "█▄▄█",
    "█▐▌█",
    "█  █"
    ]
getLetra 'n' = unlines [
    "█▄ █",
    "█ ▀█",
    "█  █"
    ]
getLetra 'o' = unlines [
    "▄▀▀▄",
    "█  █",
    "▀▄▄▀"
    ]
getLetra 'p' = unlines [
    "█▀▀▄",
    "█▄▄▀",
    "█   "
    ]
getLetra 'q' = unlines [
    "▄▀▀▄",
    "█  █",
    " ▀▀▄"
    ]
getLetra 'r' = unlines [
    "█▀▀▄",
    "█▄▄▀",
    "█  █"
    ]
getLetra 's' = unlines [
    "▄▀▀▀",
    " ▀▀▄",
    "▄▄▄▀"
    ]
getLetra 't' = unlines [
    "▀▐▌▀",
    " ▐▌ ",
    " ▐▌ "
    ]
getLetra 'u' = unlines [
    "█  █",
    "█  █",
    "▀▄▄▀"
    ]
getLetra 'v' = unlines [
    "█  █",
    "▐▌▐▌",
    " ▐▌ "
    ]
getLetra 'w' = unlines [
    "█  █",
    "█▐▌█",
    "█▀▀█"
    ]
getLetra 'x' = unlines [
    "▀▄▄▀",
    " ▐▌ ",
    "▄▀▀▄"
    ]
getLetra 'y' = unlines [
    "▀▄▄▀",
    " ▐▌ ",
    " ▐▌ "
    ]
getLetra 'z' = unlines [
    "▀▀▀█",
    " ▄▀ ",
    "█▄▄▄"
    ]

getLetra ' ' = unlines [
    "    ",
    "    ",
    "████"
    ]

getLetra '.' = unlines [
    "    ",
    "    ",
    " ▄  "
    ]

getLetra ',' = unlines [
    "    ",
    "    ",
    "▄▀  "
    ]

getLetra ';' = unlines [
    "    ",
    " ▀  ",
    "▄▀  "
    ]

getLetra '~' = unlines [
    "    ",
    "▀▄▀▄",
    "    "
    ]

getLetra '´' = unlines [
    "  ▄▀",
    "    ",
    "    "
    ]

getLetra '`' = unlines [
    "▀▄  ",
    "    ",
    "    "
    ]

getLetra '^' = unlines [
    "▄▀▀▄",
    "    ",
    "    "
    ]

getLetra 'ç' = unlines [
    "▄▀▀▄",
    "█  ▄",
    "▀█▀▀"
    ]

getCor :: String -> String
getCor "red" = "\ESC[31m"
getCor "green" = "\ESC[32m"
getCor "yellow" = "\ESC[33m"
getCor "orange" = "\ESC[38;5;208m"
getCor "default" = "\ESC[0m"

aplicarCorPixels :: String -> String -> String
aplicarCorPixels cor content = getCor cor ++ content ++ getCor "default"

aplicarCor :: [Char] -> String -> String
aplicarCor [] cor = ""
aplicarCor (head : tail) cor = aplicarCorPixels cor [head] ++ aplicarCor tail cor

concatLinha :: [[String]] -> Int -> String -> String
concatLinha (h: []) numeroLinha espaco = h !! numeroLinha
concatLinha (h: t) numeroLinha espaco = h !! numeroLinha ++ espaco ++ concatLinha t numeroLinha espaco

concatLinhas:: [[String]] -> Int -> String -> [String]
concatLinhas sprites numeroLinha espaco
  | numeroLinha < length (sprites !! 0) = [concatLinha sprites numeroLinha espaco] ++ concatLinhas sprites (numeroLinha + 1) espaco
  | otherwise = []

formatarLinhasTexto:: [(Char, String)] -> String -> [String]
formatarLinhasTexto [] spacer = []
formatarLinhasTexto dados espaco =
    let sprites = map (\(char, cor) -> aplicarCor (getLetra char) cor) dados
    in (concatLinhas (map (\sprite -> lines sprite) sprites) 0 espaco)

aplicarCorProgresso :: String -> String -> String
aplicarCorProgresso cor conteudo = getCor cor ++ conteudo ++ getCor "default"

preencherProgresso :: String -> Int -> String
preencherProgresso cor total = 
    let totalBlocos = 45 -- número de "blocos" na barra de progresso
        blocosPreenchidos = total * 3
    in aplicarCorProgresso cor (replicate blocosPreenchidos '▓') ++ replicate (45 - blocosPreenchidos) '░'

getCorProgresso :: Int -> String
getCorProgresso total
  | total == 15 = "green"
  | total >= 10 = "yellow"
  | total >= 5 = "orange"
  | otherwise = "red" 

exibirProgresso :: Int -> String
exibirProgresso total = "                                                    Progresso: ["
    ++ preencherProgresso (getCorProgresso total) total ++ "] " ++ printf "%.1f" percentual ++ "%"
  where 
    percentual = (fromIntegral total / 15 * 100) :: Double

colorirPalavra :: Bool -> String -> String
colorirPalavra True palavra = getCor "green" ++ palavra ++ getCor "default"
colorirPalavra False palavra = getCor "red" ++ palavra ++ getCor "default"

