doubleUs x y = doubleMe x + doubleMe y

doubleMe x = x + x

doubleSmallNumber x = if x > 100 then x else x*2

boomBang xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

length' xs = sum [1 | _ <- xs]

removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

evenInList xxs = [ [ x | x <- xs, even x ] | xs <- xxs]

strlength :: [Char] -> Int
strlength st = length [s | s <- st]

makeList f = [[x | x <- [1..s]] | s <- [1..f] ]

sanitize st = concat [if c `elem` [' '] then ['%','2','0'] else (c:[]) | c <- st]

lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN"
lucky 3 = "THIRD TIME'S THE CHARM!!"
lucky x = "Sorry, you're out of luck, pal!"

func1 :: String -> Int
func1 "Hello" = 1
func1 xs = length [x | x <- xs]

--recursive factorial
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

--bilds weird matrix
bList x = [ [ [ t | t <- [1..s]] | s <- [1..x]] | x <- [1..20]]

multMatrix b c = [b * c | b <- [1..b], c <- [1..c]]
