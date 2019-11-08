module Lyah.StartingOut where

doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                      then x
                      else x*2

doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

length' xs = sum [ 1 | _ <- xs ]

-- Which right triangle that has integers for all sides and all sides
-- equal to or smaller than 10 has a perimeter of 24?

triangles = [ (a, b, c) | c <- [1..10], b <- [1..10], a <- [1..10] ]

rightTriangles = [ (a, b, c) | c <- [1..10],
                               b <- [1..c],
                               a <- [1..b],
                               a^2 + b^2 == c^2 ]

solution = [ (a, b, c) | c <- [1..10],
                         b <- [1..c],
                         a <- [1..b],
                         a^2 + b^2 == c^2,
                         a + b + c == 24 ]
