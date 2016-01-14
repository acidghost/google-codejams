module Main where

import Commons
import System.IO (Handle, hGetLine)
import qualified Data.Map as Map

type Customer = Map.Map Int Bool

main :: IO ()
main = commonMain doCase

doCase :: Handle -> Int -> IO ()
doCase inh caseN = do
    nLine <- hGetLine inh
    mLine <- hGetLine inh
    let flavours = [1..read nLine :: Int]
    let mCust = read mLine :: Int
    customers <- parseCustLines inh 0 mCust []
    putStrLn $ "Case #" ++ (show caseN) ++ ": " ++ "nil"
    putStrLn $ "F " ++ (show $ length flavours)
    putStrLn $ "C " ++ (show $ length customers)

parseCustLines :: Handle -> Int -> Int -> [Customer] -> IO [Customer]
parseCustLines inh iCust mCust cMap =
    if iCust == mCust then return cMap
    else do
        line <- hGetLine inh
        next <- parseCustLines inh (iCust+1) mCust cMap
        return $ (parseCust line) : next

parseCust :: String -> Customer
parseCust s = parseCust' (map read $ words s) Map.empty

parseCust' :: [Int] -> Customer -> Customer
parseCust' [] acc = acc
parseCust' (x:[]) _ = error "Odd list of numbers!"
parseCust' (x:xs@(y:ys)) acc = Map.insert x (y == 1) (parseCust' ys acc)
