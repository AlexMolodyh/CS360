maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs


maximum'' :: (Ord a) => [a] -> a  
maximum'' [] = error "maximum of empty list"  
maximum'' [x] = x  
maximum'' (x:xs) = max x (maximum' xs)


reverse' :: [a] -> [a]  
reverse' [] = []  
reverse' (x:xs) = reverse' xs ++ [x]


repeat' :: a -> [a]  
repeat' x = x:repeat' x 


zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x, y):zip' xs ys


elem' :: (Eq a) => a -> [a] -> Bool  
elem' a [] = False  
elem' a (x:xs)  
    | a == x    = True  
    | otherwise = a `elem'` xs


quicksort :: (Ord a) => [a] -> [a]
quicksort [] = [] 
quicksort (x:xs) = 
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a > x]
    in smallerSorted ++ [x] ++ biggerSorted


multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)


zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys


flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
    where g x y = f y x


flip'' :: (a -> b -> c) -> b -> a -> c
flip'' f y x = f x y


map' :: (a -> b) -> [a] -> [b]  
map' _ [] = []  
map' f (x:xs) = f x : map f xs


filter' :: (a -> Bool) -> [a] -> [a]  
filter' _ [] = []  
filter' p (x:xs)   
    | p x       = x : filter' p xs  
    | otherwise = filter' p xs


quicksort' :: (Ord a) => [a] -> [a]    
quicksort' [] = []    
quicksort' (x:xs) =     
    let smallerSorted = quicksort' (filter (<=x) xs)  
        biggerSorted = quicksort' (filter (>x) xs)   
    in  smallerSorted ++ [x] ++ biggerSorted 