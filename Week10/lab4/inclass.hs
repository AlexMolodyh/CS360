import Data.Char

{-
    Use explicit recursion to solve a few simple problems.
-}

-- Find the maximum value in a list
maximum' :: (Ord a) => [a] -> a
maximum' []     = error "won't work on an empty list"
maximum' [x]    = x
maximum' (x:xs) = max x (maximum' xs)

-- Flip every upper case to lower case and every lower case to upper case
-- flipCase "ThIs lOoKS fuNNy" == "tHiS LoOks FUnnY"
flipCase :: String -> String
flipCase [] = []
flipCase (x:xs)
    | isLower x = toUpper x : flipCase xs 
    | isUpper x = [toLower x] ++ flipCase xs
    | otherwise = x : flipCase xs


-- Replace numbers with their written out version, i.e. '1' -> "one", '2' -> "two"
-- spellOutNumbers "There are 2 problems with the 7 items under consideration" == "There are two problems with the seven items under consideration"
--spellOutNumbers :: String -> String


-- Capitalize every individual word in a string.
-- capEachWord "This is a test of the cap system" == "This Is A Test Of The Cap System"
capEachWord :: String -> String 
capEachWord "" = ""
capEachWord s = unwords (capWords (words s))

-- capitalize the first letter of each word in list of words
capWords :: [String] -> [String]
capWords [] = [""]
capWords xs = map capWord xs

-- using explicit recursion
capWords' :: [String] -> [String]
capWords' [] = [""]
capWords' (w:ws) = capWord w : capWords' ws

-- try to write this one above using explicit recursion

-- capitalize the first letter of a word
capWord :: String -> String
capWord "" = ""
capWord xs = toUpper (head xs) : tail xs