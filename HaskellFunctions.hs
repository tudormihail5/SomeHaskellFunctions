module HaskellFunctions (priceRange , allergyFree ,
                         isValidSpec , checkSpec ,
                         parentDir , openSubDir ,
                         cross , sieveFrom , sequenceFrom)
where

import Types
import Q3Example

{- Exercise 1 -}

priceRange :: Price -> Price -> [Cupcake] -> [Cupcake]
priceRange (P a) (P b) [] = []
priceRange (P a) (P b) ((CC (P x) y) : cupcakes) | a <= x && x <= b = (CC (P x) y) : priceRange (P a) (P b) cupcakes
                                                 | otherwise = priceRange (P a) (P b) cupcakes

allergyFree :: [Ingredient] -> [Cupcake] -> [Cupcake]
allergyFree x [] = []
allergyFree x ((CC (P y) z) : cupcakes) | (nothingEq x z) == True = (CC (P y) z) : allergyFree x cupcakes
                                        | otherwise = allergyFree x cupcakes

nothingEq :: (Eq a) => [a] -> [a] -> Bool
nothingEq [] z = True
nothingEq (x : y) z | (comp x z) == True = False
                    | otherwise = nothingEq y z

comp :: (Eq a) => a -> [a] -> Bool
comp x [] = False
comp x (y : z) | x == y = True
               | otherwise = comp x z

{- Exercise 2 -}

isValidSpec :: Spec -> Tin -> Bool
isValidSpec (And x1 y1) z = (isValidSpec x1 z) && (isValidSpec y1 z) 
isValidSpec (Or x2 y2) z = (isValidSpec x2 z) && (isValidSpec y2 z)
isValidSpec (Not x3) z = isValidSpec x3 z
isValidSpec (HasCup x y) z | x >=0 && x < length z = True
                           | otherwise = False

checkSpec :: Spec -> Tin -> Bool
checkSpec (And x1 y1) z = (checkSpec x1 z) && (checkSpec y1 z) 
checkSpec (Or x2 y2) z = (checkSpec x2 z) || (checkSpec y2 z)
checkSpec (Not x3) z = not (checkSpec x3 z)
checkSpec (HasCup x y) z = hasElem y (z !! x)

hasElem :: (Eq a) => a -> [a] -> Bool
hasElem x [] = False
hasElem x (y : z) | x == y = True
                  | otherwise = hasElem x z

{- Exercise 3 -}

parentDir :: Breadcrumb -> Maybe Breadcrumb
parentDir (c, []) = Nothing
parentDir (a, b) = Just (Dir {dirName = (enteredDirName (head b)), dirContents = (entriesBefore (head b)) ++ [DirEntry a] ++ (entriesAfter (head b))}, tail b)

openSubDir :: String -> Breadcrumb -> Maybe Breadcrumb
openSubDir s (a, b) | elem s (strings (dirContents a)) == False = Nothing
                    | otherwise = Just (dir s (dirContents a), 
                    ED {entriesBefore = (before s (dirContents a)), enteredDirName = (dirName a), entriesAfter = (after s 0 (dirContents a))} : b)
                    
strings :: [DirectoryEntry] -> [String]
strings [] = []
strings (x : xs) = (name x) : strings xs

name :: DirectoryEntry -> String
name (DirEntry x) = dirName x
name (FileEntry y) = fileName y

before :: String -> [DirectoryEntry] -> [DirectoryEntry]
before s [] = []
before s (x : xs) | s /= (name x) = x : (before s xs)
                  | otherwise = []
                  
after :: String -> Int -> [DirectoryEntry] -> [DirectoryEntry]
after s i [] = []
after s i (x : xs) | s /= (name x) && i == 0 = after s i xs 
                   | s == (name x) && i == 0 = after s (i + 1) xs
                   | otherwise = x : after s i xs

dir :: String -> [DirectoryEntry] -> Directory
dir s [] = undefined
dir s (x : xs) | s == (name x) = let (DirEntry y) = x in y
               | otherwise = dir s xs

{- Exercise 4 -}

cross :: Int -> [Bool] -> [Bool]
cross a xs | a < 2 = undefined
           | otherwise = help 0 a xs

help :: Int -> Int -> [Bool] -> [Bool]
help m a [] = []
help n a (x : xs) | n `mod` a == a - 1 = False : (help (n + 1) a xs)
                  | otherwise = x : (help (n + 1) a xs)

sieveFrom :: Int -> [Bool] -> [Bool]
sieveFrom i xs = help'' 0 i xs

help'' :: Int -> Int -> [Bool] -> [Bool]
help'' j n [] = []
help'' i n (x : xs) | i < n = help'' (i + 1) n xs
                    | i >= n && x == True = True : help'' (i + 1) n (cross i xs)
                    | otherwise = x : help'' (i + 1) n xs

sieve :: [Bool]
sieve = sieveFrom 2 (repeat True)

sequenceFrom :: Int -> [Bool] -> [Int]
sequenceFrom x xs = help' 0 x xs

help' :: Int -> Int -> [Bool] -> [Int]
help' j a [] = []
help' i a (x : xs) | x == True = (i + a) : (help' (i + 1) a xs)
                   | otherwise = help' (i + 1) a xs
                    
primes :: [Int]
primes = sequenceFrom 2 sieve
