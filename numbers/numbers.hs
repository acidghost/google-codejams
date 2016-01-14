module Main where

import Commons
import System.IO (Handle, hGetLine)
import qualified Numeric as Numeric

main :: IO ()
main = commonMain doCase

doCase :: Handle -> Int -> IO ()
doCase inh caseN = do
    line <- hGetLine inh
    putStrLn $ "Case #" ++ (show caseN) ++ ": " ++
        (resolve (read line :: Double))

resolve :: (Show a, RealFloat a, Ord a, Eq a, Fractional a) => a -> String
resolve n = take 3 $ drop 7 $ dropWhile (/= '.') calcStr
    where calcStr = Numeric.showFFloat Nothing computed ""
          computed = foldl (\acc p -> (acc ** p) / 1000) (calc (head factors)) (tail factors)
          factors = factorize [] n

factorize :: (Ord a, Eq a, Fractional a) => [a] -> a -> [a]
factorize acc n
    | n < 20 || n == 10 = n : acc
    | otherwise = (10 : (factorize acc (n / 10.0))) ++ acc

factorize' :: (Ord a, Eq a, Fractional a) => [a] -> a -> [a]
factorize' acc n
    | n < 50 = n : acc
    | otherwise = (50 : (factorize' acc (n - 50))) ++ acc

calc n = ((3 + sqrt 5) ** n)

big = 1000000000000000000000000000000.0 -- 30
bigN = 2000000000.0
