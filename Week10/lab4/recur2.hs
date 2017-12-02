import Debug.Trace      -- a way to do println kinds of debugging, but not as easy

-- A useless function, but one that shows a more complicated, and more powerful
-- use of recursion
shuttle :: [a] -> [a]
shuttle [] = []
shuttle xs = shuttleH xs []

-- helper function
shuttleH :: [a] -> [a] -> [a]
shuttleH []     ys  = ys
shuttleH (x:xs) ys  = shuttleH xs ([x] ++ [x] ++ ys )

-- debug version that traces it
shuttle' :: (Show a) => [a] -> [a]
shuttle' [] = []
shuttle' xs = shuttleH' xs []

shuttleH' :: (Show a) => [a] -> [a] -> [a]
shuttleH' []     ys  = ys
shuttleH' (x:xs) ys  = traceit (shuttleH' xs (ys ++ [x]))
        where
            traceit = trace ("x: " ++ show x ++ "   xs: " ++ (concat $ map show xs) ++ "   ys: " ++ (concat $ map show ys))

-- Now a real example that uses this form of recursion
{-
    Split a string on a specific character, producing a list of strings, i.e.
    split "0c:4d:e9:a5:09:7b" ':' == ["0c","4d","e9","a5","09","7b"]
-}
split :: String -> Char -> [String]
split [] _  = []
split xs c  = splitH xs c ""

-- helper function
splitH :: String -> Char -> String -> [String]
splitH []     _ ws  = [ws]
splitH (x:xs) c ws
    | x == c        = [ws] ++ splitH xs c []
    | otherwise     = splitH xs c (ws++[x])


{- 
    This pattern matches that of a fold.  So how to do that?

    The question to ask is how to process this one character at a time and what do we
    need to carry through as the accumulator?  We've already figured out the one
    character at a time thing, so we just need the accumulator.

    It needs the answer, which is being built up: ans::[String]
    also the working string, which is the token being built up: ws::String
    and we need the char to tokenize on: c::Char

    The fold also takes the first character in the list we're folding it into:
                                   |
                                   |
                                   V
-} 
-- fold function
sfn :: ([String],String,Char) -> Char -> ([String],String,Char)
sfn (ans,ws,c) x
    | x == c    = (ans ++ [ws],""     ,c)  -- we've split, so move ws over to answer
    | otherwise = (ans        ,ws++[x],c)  -- just a normal character, so put it in 
                                           -- the working string
-- test this out to make sure it's "shuttling" values correctly (spacing adjusted to show output)
{-
*Main> sfn (["0c","4d"],"e" ,':') '9'
           (["0c","4d"],"e9",':')

*Main> sfn (["0c","4d"]     ,"e9",':') ':'
           (["0c","4d","e9"],""  ,':')
-}

-- Split a string on a character
split' :: String -> Char -> [String]
split' [] _  = []
split' xs c  = fst3 $ foldl sfn ([],"",c) xs
    where
        fst3 (a,b,_) = a ++ [b]        -- we need the first of a 3-tuple plus pick up the left over string
        
-- note that a left fold is less efficient than a right fold, because of the (++),
-- which is slower than a (:) in a right fold.  Left folds seem to be more natural to think 
-- about though, at least for me.

-- fold function
sfn' :: ([String],String,[Char]) -> Char -> ([String],String,[Char])
sfn' (ans,ws,c) x
    | x `elem` c    = (ans ++ [ws] ++ [[x]],""     ,c)  -- we've split, so move ws over to answer
    | otherwise     = (ans                 ,ws++[x],c)  -- just a normal character, so put it in 
                                                        -- the working string

-- Split a string on a character
split'' :: String -> [Char] -> [String]
split'' [] _  = []
split'' xs c  = extract $ foldl sfn' ([],"",c) xs
    where                       
        extract (a,b,_) = a ++ [b]     -- we need the first of a 3-tuple with the last string 
                                       -- appended to the list.  We didn't need this in the first
                                       -- example because the accumulator was the answer we needed.  Here
                                       -- the answer is in the tuple but still has the last operation needed
                                       -- to shuttle over the last value
{-
*Main> split'' "div#hello.there>there*3" "#.>*"
["div","#","hello",".","there",">","there","*","3"]                                   
-}