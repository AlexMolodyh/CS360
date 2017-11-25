--Author: Alexander Molodyh
--Date: 11/24/2017
--Class: CS360
--Assignment HaskellTutorial 2 Lab 5, 6, 7.1


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

-------------------------lab 6----------------------------

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


--6.1.d (lab 6 question 1 d)
subTen :: Num a => [a] -> [a]
subTen [] = []
subTen [x] = (flip (-) 10 x):[]
subTen (x:xs) = subTen (x:[]) ++ subTen xs


--6.1.e (lab 6 question 1 e)
removeSpace :: [Char] -> [Char]
removeSpace [] = []
removeSpace xs = filter (/=' ') xs


--6.2
--6.2.a (lab 6 question 2 a)
plus :: Num a => a -> a -> a
plus b c = (\x y -> x + y) b c


--6.2.b (lab 6 question 2 b)
multFour :: Num a => a -> a
multFour z = (\x -> x * 4) z


--6.2.c (lab 6 question 2 c)
secondElem :: Ord a => [a] -> a
secondElem [] = error "Wont work on an empty list!!!"
secondElem (x:[]) = x
secondElem xs = (\x -> head (tail x)) xs


--6.4 (lab 6 question 4)
calcRightTriang :: Floating a => [(a, a)] -> [(a, a, a)]
calcRightTriang [] = [(0, 0, 0)]
calcRightTriang xs = map (\x -> rightTriang x ) xs

rightTriang :: Floating c => (c, c) -> (c, c, c)
rightTriang (z, w) = (\(x, y) -> (x, y, sqrt (x*x + y*y)) ) (z, w)


------------------------------lab 7------------------------------------

--7.1 foldl
--foldl (*) 6 [5, 3, 8]
--step 1 accumulator 6 * 5 = 30 <- new accumulator
--step 2 accumulator 30 * 3 = 90 <- new accumulator
--step 3 accumulator 90 * 8 = 720 <- new accumulator

--7.1 foldr
--foldr (*) 6 [5, 3, 8]
--step 1 accumulator 6 * 8 = 48 <- new accumulator
--step 2 accumulator 48 * 3 = 144 <- new accumulator
--step 3 accumulator 144 * 5 = 720 <- new accumulator

--foldl starts from the head of a list and folds it up towards the tail
--and its binary function is (\acc x -> acc * x)

--foldr starts from the tail of a list and folds it up towards the head
--and its binary function is (\x acc -> x * acc)