---4.1

--4.1.a
getSuit :: Int -> String
getSuit 0 = "Heart"
getSuit 1 = "Diamond"
getSuit 2 = "Spade"
getSuit 3 = "Club"
getSuit x = error "No such suit!!"


--4.1.b
dotProduct :: (Double,Double,Double) -> (Double,Double,Double) -> Double
dotProduct (x, y, z) (x1, y1, z1) = sum ((x * x1):(y * y1):(z * z1):[])

--4.1.c
reverseFirstThree :: [a] -> [a]
reverseFirstThree [] = []
reverseFirstThree (a:[]) = [a]
reverseFirstThree (a:b:[]) = b:a:[]
reverseFirstThree xs = (reverse (take 3 xs)) ++ (drop 3 xs)

---4.2

--4.2.a
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

--4.2.b
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

--4.4
cylinderToVolume :: [(Double,Double)] -> [Double]
cylinderToVolume [] = []
cylinderToVolume cl = [pi * r ^ 2 * h | (a, b) <- cl, let r = a; h = b]