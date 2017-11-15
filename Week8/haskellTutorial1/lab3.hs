--3.1
makeList f = [[x | x <- [1..s]] | s <- [1..f] ]
--ghci> makeList 5
--answer: [[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]

--3.2
sanitize st = concat [if c `elem` [' '] then ['%','2','0'] else (c:[]) | c <- st]
--ghci> sanitize "http://wou.edu/my homepage/I love spaces.html"
--answer: "http://wou.edu/my%20homepage/I%20love%20spaces.html"

--3.4
