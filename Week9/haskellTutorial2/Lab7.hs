--Author: Alexander Molodyh
--Date: 11/24/2017
--Class: CS360
--Assignment HaskellTutorial 2 Lab 7


module Lab7
(
    length',
    convertIntToStringLeft,
    convertIntToStringRight
)where

import Data.Char

--7.2 (lab 7 question 2)
length' :: [a] -> Int
length' xs = foldl (\acc x -> acc + 1) 0 xs


--In this section I didn't know if you wanted an actual int to digit value conversion 
--or a string representation of the digit so I made both.

--7.3 (lab 7 question 3) part 1
convertIntToStringLeft :: [Int] -> [Char]
convertIntToStringLeft [] = []
convertIntToStringLeft xs = foldl (\acc x -> acc ++ (show x)) [] xs

--7.3 (lab 7 question 3) part 1 with intToDigit
convertIntToStringLeft' :: [Int] -> [Char]
convertIntToStringLeft' [] = []
convertIntToStringLeft' xs = foldl (\acc x -> acc ++ [intToDigit x]) [] xs


--7.3 (lab 7 question 3) part 2
convertIntToStringRight :: [Int] -> [Char]
convertIntToStringRight [] = []
convertIntToStringRight xs = foldr (\x acc -> acc ++ (show x) ) [] xs

--7.3 (lab 7 question 3) part 2 with intToDigit
convertIntToStringRight' :: [Int] -> [Char]
convertIntToStringRight' [] = []
convertIntToStringRight' xs = foldr (\x acc -> acc ++ [intToDigit x] ) [] xs


--7.4 (lab 7 question 4)
fapp1 = length $ filter (<20) [1..100]

fapp2 = take 10 $ cycle $ filter (>5) $ map (*2) [1..10]

fapp3 = sum $ map length $ zipWith (flip (++)) ["love you", "love me"] ["i ", "you "]

fapp4 = sum $ map (sin . sqrt . abs) [1..100]  -- write this one without the lambda function