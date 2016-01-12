module Main where

import Commons
import System.IO (Handle, hGetLine)

main :: IO ()
main = commonMain doCase

doCase :: Handle -> Int -> IO ()
doCase inh caseN = do
    line <- hGetLine inh
    putStrLn $ "Case #" ++ (show caseN) ++ ": " ++ t9Msg line

t9Msg :: String -> String
t9Msg = foldl t9CharFold []

t9CharFold :: String -> Char -> String
t9CharFold acc char
    | acc == [] || last acc == head translated = acc ++ (' ':translated)
    | otherwise = acc ++ translated
    where translated = case char of 'a' -> "2"
                                    'b' -> "22"
                                    'c' -> "222"
                                    'd' -> "3"
                                    'e' -> "33"
                                    'f' -> "333"
                                    'g' -> "4"
                                    'h' -> "44"
                                    'i' -> "444"
                                    'j' -> "5"
                                    'k' -> "55"
                                    'l' -> "555"
                                    'm' -> "6"
                                    'n' -> "66"
                                    'o' -> "666";
                                    'p' -> "7"
                                    'q' -> "77"
                                    'r' -> "777"
                                    's' -> "7777"
                                    't' -> "8"
                                    'u' -> "88"
                                    'v' -> "888"
                                    'w' -> "9"
                                    'x' -> "99"
                                    'y' -> "999"
                                    'z' -> "9999"
                                    ' ' -> "0"

