module Main where

import Commons
import System.IO (Handle, hGetLine)
import Data.List (intercalate)

main :: IO ()
main = commonMain doCase

doCase :: Handle -> Int -> IO ()
doCase inh caseN = do
    line <- hGetLine inh
    let list = intercalate " " $ reverse . words $ line
    putStrLn $ "Case #" ++ (show caseN) ++ ": " ++ list
