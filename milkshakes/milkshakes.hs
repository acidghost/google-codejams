module Main where

import Commons
import System.IO (Handle, hGetLine)
import Data.List (intercalate)
import qualified Data.Map as Map

type Customer = Map.Map Int Bool
type Pref = (Int, Bool)

main :: IO ()
main = commonMain doCase

doCase :: Handle -> Int -> IO ()
doCase inh caseN = do
    nLine <- hGetLine inh
    mLine <- hGetLine inh
    let flavours = [1..read nLine :: Int]
    let mCust = read mLine :: Int
    customers <- parseCustLines inh mCust
    putStrLn $ "Case #" ++ (show caseN) ++ ": " ++ (solveStr flavours customers)

parseCustLines :: Handle -> Int -> IO [Customer]
parseCustLines inh mCust = parseCustLines' inh 0 mCust []

parseCustLines' :: Handle -> Int -> Int -> [Customer] -> IO [Customer]
parseCustLines' inh iCust mCust cMap =
    if iCust == mCust then return cMap
    else do
        line <- hGetLine inh
        next <- parseCustLines' inh (iCust+1) mCust cMap
        return $ (parseCust line) : next

parseCust :: String -> Customer
parseCust s = parseCust' (map read $ tail $ words s) Map.empty

parseCust' :: [Int] -> Customer -> Customer
parseCust' [] acc = acc
parseCust' (x:[]) _ = error "Odd list of numbers!"
parseCust' (x:xs@(y:ys)) acc = Map.insert x (y == 1) (parseCust' ys acc)

prefToStr :: Pref -> String
prefToStr (_, m) = if m then "1" else "0"

solveStr :: [Int] -> [Customer] -> String
solveStr flavours customers =
    case solve flavours customers of Just p -> intercalate " " $ map prefToStr p
                                     Nothing -> "IMPOSSIBLE"

solve :: [Int] -> [Customer] -> Maybe [Pref]
solve flavours customers = solve' (initialSol flavours) [] customers

initialSol :: [Int] -> [Pref]
initialSol flavours = [(f, False) | f <- flavours]

solve' :: [Pref] -> [Int] -> [Customer] -> Maybe [Pref]
solve' s _ [] = Just s
solve' s fixed (c:cs) = case solveForCust s fixed c of Just p@(f,m) -> solve' (if m then replacePref p s else s) (f:fixed) cs
                                                       Nothing -> Nothing

solveForCust :: [Pref] -> [Int] -> Customer -> Maybe Pref
solveForCust s fixed c = solveForCust' False s s fixed c

solveForCust' :: Bool -> [Pref] -> [Pref] -> [Int] -> Customer -> Maybe Pref
solveForCust' b [] sc fixed c
    | b == False = solveForCust' True sc sc fixed c
    | otherwise = Nothing
solveForCust' b (s@(f, m):ss) sc fixed c
    | f `Map.member` c && c Map.! f == b && f `notElem` fixed = Just (f,b)
    | otherwise = solveForCust' b ss sc fixed c

replacePref :: Pref -> [Pref] -> [Pref]
replacePref _ [] = error "Pref not found!"
replacePref x@(p,m) (s@(ps,_):ss)
    | p == ps = (p,m):ss
    | otherwise = s : replacePref x ss

flavPrefs :: Int -> [Customer] -> [Pref]
flavPrefs f cs = flavPrefs' [] 0 f cs

flavPrefs' :: [Pref] -> Int -> Int -> [Customer] -> [Pref]
flavPrefs' prefs _ _ [] = prefs
flavPrefs' prefs i f (c:cs) = (i, pref) : flavPrefs' prefs (i+1) f cs
    where pref = case Map.lookup f c of Just p -> p
                                        Nothing -> False





tFlava = [1..5] :: [Int]
c1 = Map.fromList [(1, True), (2, False), (5, False)] :: Customer
c2 = Map.fromList [(1, False), (2, True)] :: Customer
c3 = Map.fromList [(1, True), (3, True)] :: Customer
cst = c1 : c2 : c3 : []
--c1 = Map.fromList [(1, True)] :: Customer
--c2 = Map.fromList [(1, False), (2, False)] :: Customer
--c3 = Map.fromList [(5, False)] :: Customer
--cst = c1 : c2 : c3 : []
