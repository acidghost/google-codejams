module Main where
import System.Environment (getProgName, getArgs)
import System.IO
import Data.List.Split (splitOn)


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
    let credits = read line :: Int
    line <- hGetLine inh
    let listSize = read line :: Int
    line <- hGetLine inh
    let list = map (\e -> read e :: Int) (splitOn " " line)
    case findItems (zip [1..] list) (zip [1..] list) credits of
        Just items -> putStrLn $ "Case #" ++ (show caseN) ++ ": " ++ 
                (show $ fst items) ++ " " ++ (show $ snd items)
        Nothing -> putStrLn "Nothing found..."

findItems :: [(Int, Int)] -> [(Int, Int)] -> Int -> Maybe (Int, Int)
findItems [] [] _ = Nothing
findItems x@((xa, xb):xs) ((ya, yb):ys) credits
    | xb + yb == credits = Just (xa, ya)
    | length ys == 0 = findItems xs (tail xs) credits
    | otherwise = findItems x ys credits
