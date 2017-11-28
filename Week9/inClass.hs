shuttle :: [a] -> [a]
shuttle [] = []
shuttle xs = shuttleH xs []

shuttleH :: [a] -> [a] -> [a]
shuttleH [] ys = ys
shuttleH (x:xs) ys = shuttleH xs (ys ++ [x])

shuttle' :: (Show a) => [a] -> [a]
shuttle' [] = []
shuttle' xs = shuttleH' xs []

shuttleH' :: (show a) => [a] -> [a] -> [a]
shuttleH' [] = []
shuttleH' (x:xs) ys = traceit ()

split :: String -> char -> [String]
split [] _ = []
split xs c = splitH xs c ""

splitH :: String -> Char -> String -> [String]
splitH [] c ws = [ws]
splitH (x:xs) c ws 
    | x == c = [ws] ++ splitH xs c []
    | otherwise = splitH xs c (ws ++ [x])