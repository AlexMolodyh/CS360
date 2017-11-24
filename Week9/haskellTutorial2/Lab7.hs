module Lab7
(
    length',
    convertIntToStringLeft,
    convertIntToStringRight
)where

--7.2 (lab 7 question 2)
length' :: [a] -> Int
length' xs = foldl (\acc x -> acc + 1) 0 xs


--7.3 (lab 7 question 2) part 1
convertIntToStringLeft :: [Int] -> [Char]
convertIntToStringLeft [] = []
convertIntToStringLeft xs = foldl (\acc x -> acc ++ (show x)) [] xs

--7.3 (lab 7 question 2) part 2
convertIntToStringRight :: [Int] -> [Char]
convertIntToStringRight [] = []
convertIntToStringRight xs = foldr (\x acc -> acc ++ (show x) ) [] xs