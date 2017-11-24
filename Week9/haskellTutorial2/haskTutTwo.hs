--5.1 (lab 5 question 1)
gcdMine :: (Integral a) => a -> a -> a
gcdMine a b
    | b == 0 = a
    | otherwise = (gcdMine b ( a `mod` b))


--5.2 (lab 5 question 2)
fibonacci :: Int -> Int
fibonacci x
    | x == 0 = 0
    | x == 1 = 1
    | otherwise = (fibonacci (x - 1)) + (fibonacci (x - 2))


--5.3 (lab 5 question 3) using if
count :: (Eq a, Num b) => a -> [a] -> b
count a [] = 0
count a (x:xs) = if a == x then 1 + (count a xs) else 0 + (count a xs)

--5.3 (lab 5 question 3) using guards
count' :: (Eq a, Num b) => a -> [a] -> b
count' a [] = 0
count' a (x:xs)
    | a == x = 1 + (count a xs)
    | a /= x = 0 + (count a xs)

--5.5 (lab 5 question 5)
sanitize :: [Char] -> [Char]
sanitize [] = []
sanitize (x:xs)
    | x `elem` [' '] = '%':'2':'0':[] ++ sanitize xs
    | otherwise = x:[] ++ sanitize xs


--6.1.a (lab 6 question 1 a)
multByTen :: Num a => [a] -> [a]
multByTen [] = []
multByTen xs = zipWith (\x y -> x * y) xs (cycle [10])


--6.1.b (lab 6 question 1 b)
infinyPowTwo :: (Enum a, Num a) => [a]
infinyPowTwo = map powOfTwo [1..]

powOfTwo :: (Enum a, Num a) => a -> a
powOfTwo = (^2)


--6.1.c (lab 6 question 1 c)
increElmnt :: (Enum a, Num a) => [a] -> [a]
increElmnt [] = []
increElmnt xs = map (\x -> succ x ) xs

--part 2 of question 1 c
increElmnt' :: [Char] -> [Char]
increElmnt' [] = []
increElmnt' xs = map (\x -> succ x ) xs