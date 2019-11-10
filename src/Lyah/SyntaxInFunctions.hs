module Lyah.SyntaxInFunctions where

lucky :: (Integral a) => a -> String
lucky 7 = "lucky number 7 wins again"
lucky _ = "better luck next time"
