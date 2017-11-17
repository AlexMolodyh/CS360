doubleUs x y = doubleMe x + doubleMe y



doubleMe x = x + x



doubleSmallNumber x = if x > 100 then x else x*2



boomBang xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]



--length' xs = sum [1 | _ <- xs]



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



--addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
--addVectors a b = (fst a + fst b, snd a + snd b)



addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)



first :: (a, b, c) -> a
first (x, _, _) = x



second :: (a, b, c) -> b
second (_, y, _) = y



third :: (a, b, c) -> c
third (_, _, z) = z



head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x



tell :: (Show a) => [a] -> String  
tell [] = "The list is empty"  
tell (x:[]) = "The list has one element: " ++ show x  
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y  
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y



length' :: (Num b) => [a] -> b  
length' [] = 0  
length' (_:xs) = 1 + length' xs



outSingle :: (Num a) => [a] -> a  
outSingle [] = 0  
outSingle (x:xs) = if length xs > 0 then outSingle xs else x



initials :: String -> String -> String  
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."  
    where (f:_) = firstname  
          (l:_) = lastname



calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis xs = [bmi w h | (w, h) <- xs]  
    where bmi weight height = weight / height ^ 2



cylinder :: (RealFloat a) => a -> a -> a  
cylinder r h = 
    let sideArea = 2 * pi * r * h  
        topArea = pi * r ^2  
    in  sideArea + 2 * topArea



calcBmis2 :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis2 xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2] 


calcBmis3 :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis3 xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]



head'' :: [a] -> a  
head'' xs = case xs of [] -> error "No head for empty lists!"  
                       (x:_) -> x


describeList :: [a] -> String  
describeList xs = "The list is " ++ case xs of [] -> "empty."  
                                               [x] -> "a singleton list."   
                                               xs -> "a longer list."


describeList' :: [a] -> String  
describeList' xs = "The list is " ++ what xs  
    where what [] = "empty."  
          what [x] = "a singleton list."  
          what xs = "a longer list."