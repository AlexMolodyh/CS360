--3.1
makeList f = [[x | x <- [1..s]] | s <- [1..f] ]
--ghci> makeList 5
--answer: [[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]

--3.2
sanitize st = concat [if c `elem` [' '] then ['%','2','0'] else (c:[]) | c <- st]
--ghci> sanitize "http://wou.edu/my homepage/I love spaces.html"
--answer: "http://wou.edu/my%20homepage/I%20love%20spaces.html"

--3.4
---3.4.1
:t (++)
--(++) :: [a] -> [a] -> [a]
--answer: ++ can take a list of any datatype and output a list of that same datatype
--Datatype can be Int, Float, Doble, Bool, Char, (), []

---3.4.2
:t take
--take :: Int -> [a] -> [a]
--answer: Can take a Int and a list of any datatype and output a list of that same datatype
--Int can only be an Int
--Datatype can be Int, Float, Doble, Bool, Char, (), []

---3.4.3
:t head
--head :: [a] -> a
--answer: Takes in a list of a datatype and outputs a single element of that same datatype
--Datatype can be Int, Float, Doble, Bool, Char, (), []


---3.4.4
:t div
--div :: Integral a => a -> a -> a
--answer: Datatype must be part of the Integral typeclass which is Integer and Int

---3.4.5
:t succ
--succ :: Enum a => a -> a
--answer: Datatype can be Bool, Ordering, Char, Double, Float, (), Integer, Int