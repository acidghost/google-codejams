module Main where

import Commons
import System.IO (Handle, hGetLine)
import Data.List (sort)
import Data.List.Split (splitOn)

main :: IO ()
main = commonMain doCase

doCase :: Handle -> Int -> IO ()
doCase inh caseN = do
    lineN <- hGetLine inh
    lineV1 <- hGetLine inh
    lineV2 <- hGetLine inh
    let v1 = sort $ map (read) (splitOn " " lineV1)
        v2 = reverse $ sort $ map (read) (splitOn " " lineV2)
        p = foldl (\a (vi, vj) -> a + vi * vj) 0 (zip v1 v2)
    putStrLn $ "Case #" ++ (show caseN) ++ ": " ++ (show p)
