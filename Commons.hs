module Commons (
    commonMain
) where

import System.Environment (getProgName, getArgs)
import System.IO

commonMain :: (Handle -> Int -> IO ()) -> IO ()
commonMain doCase = do
    args <- getArgs
    if length args == 1 then
        doFile (head args) doCase
    else do
        progName <- getProgName
        putStrLn $ "Usage: " ++ progName ++ " input.txt"

doFile :: String -> (Handle -> Int -> IO ()) -> IO ()
doFile fileName doCase = do
    inh <- openFile fileName ReadMode
    line <- hGetLine inh
    doCases doCase inh 1 (read line :: Int)

doCases :: (Handle -> Int -> IO ()) -> Handle -> Int -> Int -> IO ()
doCases doCase inh caseN caseM = do
    if caseN > caseM then
        return ()
    else do
        doCase inh caseN
        doCases doCase inh (caseN + 1) caseM
