module Lyah.SyntaxInFunctions where

lucky :: (Integral a) => a -> String
lucky 7 = "lucky number 7 wins again"
lucky _ = "better luck next time"

-- Calculate the length of a list using pattern matching and recursion
length'' :: (Num b) => [a] -> b
length'' []     = 0
length'' (_:xs) = 1 + length'' xs

-- Implement the sum function
sum' :: (Num a) => [a] -> a
sum' []     = 0
sum' (x:xs) = x + sum' xs
