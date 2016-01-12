module Main where

import Commons
import System.IO (Handle, hGetLine)
import Data.List.Split (splitOn)

main :: IO ()
main = commonMain doCase

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
