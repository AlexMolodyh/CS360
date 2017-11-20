--1.1 (Lab 1 Question 1)
--Installed The Haskell Platform

--1.2 (Lab 1 Question 2)
--The arithmetic operators are functions so we cannot use arithmetic functions(operators)
--as prfix functions without explicitly sarrounding them with parenthesis like so 5 * (-3).

--1.3 (Lab 1 Question 3)
labOnep3 = sqrt 818281336460929553769504384519009121840452831049
--answer: 9.045890428592033e23

--1.4 (Lab 1 Question 4)
labOnep4 = pred 'A'
--answer: '@'

--1.5 (Lab 1 Question 5)
labOnep5 = even (3 * 1 + 1)
--answer: True

-------------------------------Lab 2-------------------------------------------

--2.2 (Lab 2 Question 2)
labTwop2 = [x | x <- [1..100], x `mod` 2 == 1]
--answer: 2725392139750729502980713245400918633290796330545803413734328823443106201171875

--2.3 (Lab 2 Question 3)
labTwop3 = maximum (drop 1 ( init [99,23,4,2,67,82,49,-40]))
--answer: 82

--2.4 (Lab 2 Question 4)
labTwop4 = 1:3:(-5):20:8:[]
--answer: [1,3,-5,20,8]

--2.5 (Lab 2 Question 5)
---2.5.1
labTwop51 = [x | x <- [1..27], even x]
--answer: [2,4,6,8,10,12,14,16,18,20,22,24,26]

---2.5.2 (Lab 2 Question 5.2)
labTwop52 = [x | x <- [1..300], x < 200, x `mod` 7 == 0, x `mod` 3 == 0]
--answer: [21,42,63,84,105,126,147,168,189]

---2.5.3 (Lab 2 Question 5.3)
labTwop53 = [x | x <- [100..200], odd x, x `mod` 9 == 0]
--answer: 5

---2.5.5 (Lab 2 Question 5.5)
labTwop55 = length [x | x <- [2, -3, -2, -8, 5, 3, -38], x < 0]
--answer: 4

--2.6 Uncmment to test code in terminal || (Lab 2 Question 6)
                                    --- \/
--let hex = ['0'..'9'] ++ ['A'..'F']
--zip [0..15] hex
--answer: [(0,'0'),(1,'1'),(2,'2'),(3,'3'),(4,'4'),(5,'5'),(6,'6'),(7,'7'),(8,'8'),(9,'9'),(10,'A'),(11,'B'),(12,'C'),(13,'D'),(14,'E'),(15,'F')]


----------------------------------Lab 3----------------------------------------


--3.1 (Lab 3 Question 1)
makeList f = [[x | x <- [1..s]] | s <- [1..f] ]
--ghci> makeList 5
--answer: [[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]

--3.2 (Lab 3 Question 2)
sanitize st = concat [if c `elem` [' '] then ['%','2','0'] else (c:[]) | c <- st]
--ghci> sanitize "http://wou.edu/my homepage/I love spaces.html"
--answer: "http://wou.edu/my%20homepage/I%20love%20spaces.html"

--3.4
---3.4.1 (Lab 3 Question 4.1)
-- :t (++)
--(++) :: [a] -> [a] -> [a]
--answer: ++ can take a list of any datatype and output a list of that same datatype
--Datatype can be Int, Float, Doble, Bool, Char, (), []

---3.4.2 (Lab 3 Question 4.2)
-- :t take
--take :: Int -> [a] -> [a]
--answer: Can take a Int and a list of any datatype and output a list of that same datatype
--Int can only be an Int
--Datatype can be Int, Float, Doble, Bool, Char, (), []

---3.4.3 (Lab 3 Question 4.3)
-- :t head
--head :: [a] -> a
--answer: Takes in a list of a datatype and outputs a single element of that same datatype
--Datatype can be Int, Float, Doble, Bool, Char, (), []


---3.4.4 (Lab 3 Question 4.4)
-- :t div
--div :: Integral a => a -> a -> a
--answer: Datatype must be part of the Integral typeclass which is Integer and Int

---3.4.5 (Lab 3 Question 4.5)
-- :t succ
--succ :: Enum a => a -> a
--answer: Datatype can be Bool, Ordering, Char, Double, Float, (), Integer, Int


------------------------------------Lab 4-------------------------------------------------


---4.1

--4.1.a (Lab 4 Question 1.a)
getSuit :: Int -> String
getSuit 0 = "Heart"
getSuit 1 = "Diamond"
getSuit 2 = "Spade"
getSuit 3 = "Club"
getSuit x = error "No such suit!!"


--4.1.b (Lab 4 Question 1.b)
dotProduct :: (Double,Double,Double) -> (Double,Double,Double) -> Double
dotProduct (x, y, z) (x1, y1, z1) = sum ((x * x1):(y * y1):(z * z1):[])

--4.1.c (Lab 4 Question 1.c)
reverseFirstThree :: [a] -> [a]
reverseFirstThree [] = []
reverseFirstThree (a:[]) = [a]
reverseFirstThree (a:b:[]) = b:a:[]
reverseFirstThree xs = (reverse (take 3 xs)) ++ (drop 3 xs)

---4.2

--4.2.a (Lab 4 Question 2.a)
feelsLike :: Double -> String
feelsLike dg
    | dg < (-40) = "Frostbite Central!"
    | dg < (-20) = "Don't go outside!"
    | dg < 0 = "Better put on three layers of close!"
    | dg < 50 = "Put on a jacket!"
    | dg >= 100 = "Jump in a river!"
    | dg >= 150 = "Oven-like!"
    | dg > 80 = "Time for a beer!"
    | dg > 70 = "A day for shorts!"
    | otherwise = "It's an alright day"

--4.2.b (Lab 4 Question 2.b)
feelsLike2 :: Double -> String
feelsLike2 dg
    | degrees < (-40) = "Frostbite Central!"
    | degrees < (-20) = "Don't go outside!"
    | degrees < 0 = "Better put on three layers of close!"
    | degrees < 50 = "Put on a jacket!"
    | degrees >= 100 = "Jump in a river!"
    | degrees >= 150 = "Oven-like!"
    | degrees > 80 = "Time for a beer!"
    | degrees > 70 = "A day for shorts!"
    | otherwise = "It's an alright day"
    where degrees = (dg - 32) / 1.8

--4.4 (Lab 4 Question 4)
cylinderToVolume :: [(Double,Double)] -> [Double]
cylinderToVolume [] = []
cylinderToVolume cl = [pi * r ^ 2 * h | (a, b) <- cl, let r = a; h = b]