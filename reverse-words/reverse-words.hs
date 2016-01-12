module Main where

import System.Environment (getProgName, getArgs)
import System.IO
import Data.List (intercalate)


main :: IO ()
main = do
    args <- getArgs
    if length args == 1 then
        doFile (head args)
    else do
        progName <- getProgName
        putStrLn $ "Usage: " ++ progName ++ " input.txt"

doFile :: String -> IO ()
doFile fileName = do
    inh <- openFile fileName ReadMode
    line <- hGetLine inh
    doCases inh 1 (read line :: Int)

doCases :: Handle -> Int -> Int -> IO ()
doCases inh caseN caseM = do
    if caseN > caseM then
        return ()
    else do
        doCase inh caseN
        doCases inh (caseN + 1) caseM

doCase :: Handle -> Int -> IO ()
doCase inh caseN = do
    line <- hGetLine inh
    let list = intercalate " " $ reverse . words $ line
    putStrLn $ "Case #" ++ (show caseN) ++ ": " ++ list
