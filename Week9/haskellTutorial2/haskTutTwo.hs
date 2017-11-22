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


--5.3 (lab 5 question 3)
