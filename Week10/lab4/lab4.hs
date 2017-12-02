{-
    CS 360 lab 4
    Emmet syntax HTML generator.
    Starting code
    YOUR NAME HERE
-}

module Main
(
main
) where

import System.IO (hFlush, stdout)
import Data.List
import Data.Char

{-
    First processing function.  This function takes the entire
    line of text from the user.

    This one obviously doesn't do what is required for the lab,
    but is just here to show you the basic I/O
-}
-- process :: String -> String
-- process text = if head text == 'p'
--     then "<p></p>"
--     else "Only works for 'p'"

process :: String -> String
process text = concat $ buildElements [] $ buildElemList (split text ".#+>$*(){}")


--Builds element string from element list
buildElements :: [String] -> [String] -> [String]
buildElements xs []                 = [""]
buildElements [] ys
    | "class" `isInfixOf` (head ys) = ("<div" ++ head ys ++ "</div>"):[]
    | "id" `isInfixOf` (head ys)    = ("<div" ++ head ys ++ "</div>"):[]
    | length ys < 2                 = ys
    | otherwise                     = buildElements ((head ys):[] ++ (head $ tail ys):[] ) (tail $ tail ys)
buildElements xs ys
    | "class" `isInfixOf` (head ys) = buildElements (insertAttr xs (head ys)) (tail ys)
    | "id" `isInfixOf` (head ys)    = buildElements (insertAttr xs (head ys)) (tail ys)
    | '>' == (head $ head ys)       = buildElements (nestChild xs $ tail ys) (tail $ tail ys)
    | '*' == (head $ head ys)       = buildElements (concatNStr xs (digitToInt $ head $ head $ tail ys)) (tail $ tail ys) ++ [""]
    | otherwise                     = xs


--Concatenate the given string list n amount of times
concatNStr :: [String] -> Int -> [String]
concatNStr [] n = [""]
concatNStr xs n
    | n < 1 = xs
    | otherwise = xs ++ concatNStr xs (n - 1)


--Nests a child element inside the parent element
nestChild :: [String] -> [String] -> [String]
nestChild xs ys = (init xs) ++ (head ys):[] ++ (head (tail ys)):[] ++ (last xs):[]



--Builds a list of elements and attributes 
buildElemList :: [String] -> [String]
buildElemList []                    = [""]
buildElemList [x]                   = [""]
buildElemList (x:xs)
    | (head x) `elem` ".#(){}^+>"   = buildAttr (head x) (head xs) ++ buildElemList (tail xs)
    | (head x) `elem` "*$"          = (x:[] ++ (head xs):[]) ++ buildElemList (tail xs)
    | otherwise                     = buildElem x ++ buildElemList xs


    --Builds a single attribute
buildAttr :: Char -> String -> [String]
buildAttr _ []      = [""]
buildAttr attr val
    | attr == '.'   = (createClass val):[]
    | attr == '#'   = (createId val):[]
    | otherwise     = buildSubElems attr val

    
--Builds a list of elements that go inside another element or are concatenated or are multiplied
buildSubElems :: Char -> String -> [String]
buildSubElems x val = (x:[]):[] ++ printTag val


--Builds a single elemement
buildElem :: String -> [String]
buildElem []    = [""]
buildElem val   = printTag val


--Prints a string that contains a tag element of the input given
printTag :: String -> [String]
printTag x = startTag x ++ endTag x

startTag :: String -> [String]
startTag x = ("<" ++ x ++ ">"):[]

endTag :: String -> [String]
endTag x = ("</" ++ x ++ ">"):[]


--Creats a class with the text value inside
createClass :: String -> String
createClass id = " class=\"" ++ id ++ "\""

--Creates an id with the text value inside
createId :: String -> String
createId id = " id=\"" ++ id ++ "\""

--Inserts the given attribute into the given element tag
insertAttr :: [String] -> String -> [String]
insertAttr e val = insertVal (head e) val ++ tail e

insertVal :: String -> String -> [String]
insertVal e val = ((init e) ++ val ++ ">"):[]




-- fold function
sfn :: ([String],String,[Char]) -> Char -> ([String],String,[Char])
sfn (ans,ws,c) x
    | x `elem` c    = (ans ++ [ws] ++ [[x]],""     ,c)  -- we've split, so move ws over to answer
    | otherwise     = (ans                 ,ws++[x],c)  -- just a normal character, so put it in 
                                                        -- the working string

-- Split a string on a character
split :: String -> [Char] -> [String]
split [] _  = []
split xs c  = extract $ foldl sfn ([],"",c) xs
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







{-
    The main entry point function.  Interactively expand Emmet syntax
    abbreviations and generate HTML skeleton code.  Prints HTML to standard
    output.

    Enter an empty line to quit.
-}
main :: IO ()
main = do
  putStrLn "Type Emmet abbreviations and we'll generate HTML for you"
  putStrLn "  -- to quit, hit return on an empty line"
  -- invoke a recursive main to continue to prompt the user until they wish to quit
  mainR

-- Main interactive function
mainR :: IO ()
mainR = do
  putStr "\nemmet: "
  hFlush stdout   -- line buffering prevents the prompt from printing without the newline, so this sends it
  oneLine <- getLine
  if null oneLine
    then do
      putStrLn "Exiting ..."
      return ()
    else do
      putStrLn $ process oneLine
      mainR