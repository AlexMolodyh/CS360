doubleUs x y = doubleMe x + doubleMe y

doubleMe x = x + x

doubleSmallNumber x = if x > 100 then x else x*2

boomBang xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

length' xs = sum [1 | _ <- xs]

removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

evenInList xxs = [ [ x | x <- xs, even x ] | xs <- xxs]

evenThird xs = [x | x <-  ]