module Lyah.HigherOrderFunctions where

-- Implement zipWith: this function takes a function and two lists as
-- parameters and joins the lists by applying the function between
-- elements.
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

-- Implement flip: this functions takes a function and returns another
-- function like the original function, except the first 2 arguments are
-- flipped.
flip' :: (a -> b -> c) -> b -> a -> c
flip' f x y = f y x
