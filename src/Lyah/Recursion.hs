module Lyah.Recursion where

-- Find the maximum of a list recursively
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "Empty lists don't have a max value"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs

-- A little bit sleeker
maximum'' :: (Ord a) => [a] -> a
maximum'' []     = error "Empty lists don't have a max value"
maximum'' (x:xs) = max x (maximum'' xs)

-- Replicate an element n number of times
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
    | n < 1 = []
    | otherwise = x:replicate' (n-1) x

-- Take n number of elements from a list
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n < 1 = []
take' _ [] = []
take' n (x:xs) = x:take' (n-1) xs

-- Reverse a list
reverse' :: [a] -> [a]
reverse' []     = []
reverse' (x:xs) = reverse' xs ++ [x]

-- Repeat an element in an infite list
-- Because Haskell has lazy evaluation this will not crash!
repeat' :: a -> [a]
repeat' x = x:repeat' x

-- Zip takes two lists and puts their elements together, truncating the
-- longer list
zip' :: [a] -> [b] -> [(a, b)]
zip' [] _          = []
zip' _ []          = []
zip' (x:xs) (y:ys) = (x, y):zip' xs ys

-- Check to see if an element is in a list
elem' :: (Eq a) => a -> [a] -> Bool
elem' _ []     = False
elem' x (y:ys) = x == y || elem' x ys

-- Another way of doing it
elem'' :: (Eq a) => a -> [a] -> Bool
elem'' _ [] = False
elem'' x (y:ys)
    | x == y = True
    | otherwise = elem'' x ys

-- Quicksort: The idea is that you pick an element from the list, usually
-- the first, and place all the elements smaller than it before it, and
-- all the elements bigger than it after.
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smaller = quicksort [ a | a <- xs, a <= x ]
        bigger = quicksort [ a | a <- xs, a > x ]
    in smaller ++ [x] ++ bigger
