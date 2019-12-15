# Follow along repo for http://learnyouahaskell.com/

Nix setup borrowed from https://github.com/mbbx6spp/effpee.

## Table of Contents

- [Follow along repo for http://learnyouahaskell.com/](#follow-along-repo-for-httplearnyouahaskellcom)
  - [Table of Contents](#table-of-contents)
  - [Starting Out](#starting-out)
    - [Intro to Functions](#intro-to-functions)
    - [Intro to Lists](#intro-to-lists)
    - [Ranges](#ranges)
    - [List Comprehensions](#list-comprehensions)
    - [Tuples](#tuples)
  - [Types and Typeclasses](#types-and-typeclasses)
    - [Types](#types)
    - [Type Variables](#type-variables)
    - [Typeclasses](#typeclasses)
  - [Syntax in Functions](#syntax-in-functions)
    - [Pattern Matching](#pattern-matching)
    - [Guards](#guards)
    - [Where](#where)
    - [Let](#let)
    - [Case Expressions](#case-expressions)
  - [Higher order functions](#higher-order-functions)
    - [map and filter](#map-and-filter)
      - [map](#map)
      - [filter](#filter)

## Starting Out

### Intro to Functions

- Functions that can take arguments on either side, like `+`, are called infix functions. A function can be made infix by surrounding it in back-ticks: `` 5 `times` 6 ``. Functions can not only be called as infix, but they can also be defined as infix.
- `if` statements are expressions, meaning they have to return a value; the `else` is mandatory.
- Function names can include `'`, which is usually used to denote a slightly modified function or variable or a strict (non-lazy) function.
- Functions can't start with uppercase letters.
- Functions that don't take arguments are know as definitions. The function name and value can be used interchangeably.

### Intro to Lists

- Lists are homogenous, i.e. can only store elements of the same type.
- Strings are lists of characters.
- Concatenate lists by using the `++` operator. This traverses the whole LHS list.
- Prepend elements by using the `:` operator: `5:[1, 2, 3]` => `[5, 1, 2, 3]`
  - `[1, 2, 3]` is syntactic sugar for `1:2:3:[]`.
- Get an element from a list using its index with `!!`.
- Lists can be compared if their elements can be compared. First the first elements are compared, if they are equal the next elements, etc. Comparison is short circuited if the elements are not equal.
- Some list operators:
  - `head`: returns the first element.
  - `tail`: returns every element but the first.
  - `last`: return the last element.
  - `init`: return every element but the last.
  - `length`
  - `null`: checks if the list is empty, returns a boolean.
  - `reverse`
  - `take`: takes a number and a list, extracts n elements from beginning of the list and returns them.
  - `drop`: takes a number and a list, drops n elements from the list and returns remainder.
  - `maximum`
  - `minimum`
  - `sum`
  - `product`
  - `elem`: checks if an element is inside of a list. Usually called as an infix function.
- Haskell will blow up if you try to get an element from an empty list, and since this can't be caught at compile time - be careful!

### Ranges

Create a range:

```hs
ghci> [1..20]
[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
ghci> ['a'..'z']
"abcdefghijklmnopqrstuvwxyz"
ghci> ['K'..'Z']
"KLMNOPQRSTUVWXYZ"
```

Separate the first two elements with a comma to get steps:

```hs
ghci> [5, 7..15]
[5, 7, 9, 11, 13, 15]
```

Use a decreasing step to create decreasing lists:

```hs
ghci> ['f', 'e'..'a']
"fedcba"
```

Leave out the last element to create an infinite list. Haskell won't evaluate the list until it figures out what you want to do with it.

The functions below generate infinite lists. Make sure you do something with them otherwise Haskell will never finish evaluating:

- `cycle` takes a list and repeats it to generate an infinite list.
- `repeat` takes an element and repeats it to generate an infinite list of only that element.
  - Note: `replicate 3 10` is the same thing as `take 3 (repeat 10)`.

### List Comprehensions

Analogous to set comprehensions in mathematics: a way to build a more specific set from general set.

List comprehensions have three parts: the output function, one or more input lists, and one or more predicates (optional).

All predicates have to be `true` for the element to

The list comprehension below returns the elements between 1 and 10 that when doubled are between 2 and 12:

```hs
[ x*2 | x <- [1..10], x*2 >= 2, x*2 <= 12 ]
-- [Output function | input set, predicate 1, predicate n]
```

List comprehensions can be assigned to functions:

```hs
onlyFizz xs = [ if x `mod` 3 == 0 then "FIZZ" else show x | x <- xs ]
```

```hs
ghci> onlyFizz [1..15]
["1","2","FIZZ","4","5","FIZZ","7","8","FIZZ","10","11","FIZZ","13","14","FIZZ"]
```

When comprehensions draw from multiple lists they produce all combinations of the lists and then join them by the output function. E.g. a comprehension with two lists of 5 elements will produce a list with 25 elements (when unfiltered).

```hs
ghci> [ x^y | x <- [2, 3, 4], y <- [5, 8, 4] ]
[32,256,16,243,6561,81,1024,65536,256]
```

What if I don't want to use the actual element?

```hs
length' xs = [ 1 | _ <- xs ]
```

The `_` is a convention that is used to avoid defining a variable that won't be used.

Since strings are lists, list comprehensions work on them too:

```hs
ghci> let noLast10 xs = [ x | x <- xs, x `elem` take 16 (' ':['a'..'z']) ]
ghci> noLast10 "the quick brown fox jumps over a lazy dog"
"he ick bon fo jm oe a la dog"
```

And working with nested lists:

```hs
ghci> let noOddsNested xxs = [ [ x | x <- xs, even x] | xs <- xxs ]
ghci> noOddsNested [[1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6]]
[[2,2,4],[2,4,6,8],[2,4,2,6,2,6]]
```

### Tuples

- Tuples are used to store data when you know how many values you want to combine.
- Multiple types can be stored in a tuple.
- Tuples are wrapped in parentheses.
- Tuples can only be compared if they are the same size and if their components can be compared.
- Some useful functions for pairs:
  - `fst`: takes a pair and returns the first component.
  - `snd`: takes a pair and return the second component.

Another useful function is `zip`. It takes to lists and pairs up the elements to produce a new list of tuples. When zipping two lists of different lengths the longer list gets cutoff to the length of the shorter list.

See [this](https://github.com/azuzunaga/lyah/blob/master/src/Lyah/StartingOut.hs#L15-L29) example on solving a problem with list comprehensions and tuples. It is a common pattern in functional programming to start with a set of solutions and narrow it down until you get to where you want to be.

## Types and Typeclasses

### Types

Types are written in capital case. Using `:t` on the repl tells you the type of the expression you are evaluating:

```hs
ghci> let addThree x y z = x + y + z
ghci> :t addThree
addThree :: Num a => a -> a -> a -> a
```

First is the expression, then the `::` means "type of". Function parameters are separated by `->` and the return type is the last item.

Some common types:

- `Int`: Bounded integer. Max and min vary by processor type, but on a 32-bit machine it is +/- 2147483647 or 2^31 - 1.
- `Integer`: Unbounded integer. Used for really big numbers. `Int` is more efficient.
- `Float`: Floating point with single precision.
- `Double`: Floating point with double precision.
- `Bool`: Boolean. `True` or `False`.
- `Char`: Represents a character and is denoted by single quotes. A string is a list of chars (`[Char]`).

### Type Variables

When we take a look at the type of the `head` function we get the following:

```hs
ghci> :h head
head :: [a] -> a
```

`a` is a type variable - meaning it can be of any type. Functions that have type variables are called polymorphic functions. If a function type has more than one type variables it is usually `a`, `b`, `c`, etc., but that doesn't mean that `a` and `b` are different types.

### Typeclasses

Typeclasses define behavior. If a type is a part of a typeclass, it means it supports and implements the behavior the typeclass describes.

If we look again a previous example:

```hs
ghci> let addThree x y z = x + y + z
ghci> :t addThree
addThree :: Num a => a -> a -> a -> a
```

The part between the `::` and the `=>` is called the class constraint. In this case, it means that the three arguments passed to `addThree` must all be of the `Num` typeclass. There can be multiple typeclasses, in which case they are separated by a comma:

```hs
ghci> :t fromIntegral
fromIntegral :: (Integral a, Num b) => a -> b
```
Note: the `fromIntegral` function converts an `Integral` number into a more generic `Num` number.

Some basic typeclasses:

- `Eq`: Used for types that support equality testing. Its members implement the `==` and `/=` functions.
- `Ord`: For types that have an ordering. Covers functions such as `>`, `<`, `<=`, `>=`, `compare`. `compare` takes two `Ord` members of the same type and returns `GT`, `LT, or `EQ`.
- `Show`: For types that can be presented as a string. The most used function is `show`.
- `Read`: The reverse of `Show` - strings that can be presented as other types. The `read` function takes a string and returns a type that is a member of `Read`.
  - `read "4"` will return an error because `read` doesn't know what the type should be. So we can specify a return type: `read "4" :: Int`, `read "4" :: Float`, etc.
- `Enum`: Sequentially ordered types. Can be used for list ranges.
- `Bounded`: Members have an upper and lower bound, i.e. `Int`.
- `Num`: Numeric typeclass. Its members can act like numbers.
- `Integral`: Only includes whole numbers.
- `Float`: Includes only floating point numbers.

## Syntax in Functions

### Pattern Matching

Pattern matching is specifying constraints to which data should conform, and checking to see if it does and deconstructing the data according to the constraints. When defining functions you can define separate function bodies for different patterns:

```hs
lucky :: (Integral a) => a -> String
lucky 7 = "Lucky number 7 wins again"
lucky _ = "Try again next time"
```

When calling `lucky` the patterns will be called from top to bottom, evaluating the pattern that matches.

Here is how you can use pattern matching to define a function that finds a number's factorial recursively:

```hs
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial x = x * factorial (x - 1)
```

Pattern matching can fail when a catch-all pattern is not included.

Pattern matching works with list comprehensions, tuples, and lists. Since list `[1, 2, 3]` is syntactic sugar for `1:2:3:[]`, you can get the elements of the list by passing in variables separated by colons, so `x:xs` would bind the first element to `x` and the rest of the list to `xs`. If you want to bind exactly to a number of variables, instead of binding with `x:y:[]` you can bind the elements of the list with `[x, y]`.

```hs
head' :: [a] -> a
head' [] = error "Empty lists don't have a head"
head' (x:_) = x
```

Note that when binding multiple variables they have to be surrounded by parentheses.

Use _as patterns_ to bind separate variables _and_ the whole. _as patterns_ are created by putting a variable name and an `@` in front of a pattern:

```hs
firstLetter :: String -> String
firstLetter "" = "There are no letters here"
firstLetter word@(x:_) = "The first letter of " ++ word ++ " is " ++ [x]
```

### Guards

Guards are a way of testing values, a bit like if statement but more readable.

```hs
singleFizzBuzz :: (Integral a, Show a) => a -> String
singleFizzBuzz x
    | x `mod` 15 == 0 = "fizzbuzz"
    | x `mod` 5 == 0 = "fizz"
    | x `mod` 3 == 0 = "buzz"
    | otherwise = show x
```

`otherwise` is a catchall if all previous guards evaluate to false. If there is no `otherwise`, evaluation goes to the next pattern. Guards can also be used with many parameters:

```hs
max' :: Ord a => a -> a
max' x y
    | x > y = x
    | otherwise = y
```

Remember that there is no equals after the function name and parameters.


### Where

`where` bindings can be added to the end of functions to define functions / variables that are only in scope for the parent function, but including all the guards. You can define functions with their own parameter list in a `where` block. And `where` blocks can also be nested - a `where` block can have their own `where` blocks.

```hs
fizzBuzz :: (Integral a, Show a) => [a] -> [String]
fizzBuzz xs = [ fizzOrBuzz x | x <- xs ]
    where
  fizzOrBuzz x
      | x `mod` 15 == 0 = "fizzbuzz"
      | x `mod` 5 == 0 = "fizz"
      | x `mod` 3 == 0 = "buzz"
      | otherwise = show x
```

The function above can also be written like this:

```hs
fizzBuzz :: (Integral a, Show a) => [a] -> [String]
fizzBuzz xs = [ fizzOrBuzz x | x <- xs ]
    where fizzOrBuzz x
              | x `mod` 15 == 0 = "fizzbuzz"
              | x `mod` 5 == 0 = "fizz"
              | x `mod` 3 == 0 = "buzz"
              | otherwise = show x
```

The important thing to know is that the guard has to be indented further to the right than the function body.

### Let

Similar to `where` bindings, but let you bind to variables anywhere, are expressions, but don't span across guards. You can use pattern matching in let bindings (like any other Haskell construct that lets you bind variables to values).

The function below calculates a cylinder's surface area based on the radius and the height.

```hs
cylinder :: (RealFloat a) => a -> a
cylinder r h =
    let sidearea = 2 * pi * r * h
        toparea = pi * r^2
    in  sidearea + 2 * toparea
```

The syntax is `let <bindind> in <expression>`. The variables defined in the `let` part are accessible to the expression after `in`. The main difference between `where` and `let` bindings is that `let` bindings are expressions, meaning they can go anywhere:

```hs
ghci> [let double x = x + x; square x = x^2 in (double 10, square 3, double 5)]
[(20, 9, 10)]
```

When used inline, different let bindings can be separated with a semicolon (the last one is optional).

`let` bindings can also be used in list comprehensions:

```hs
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis x = [ bmi | (w, h) -> xs, let bmi = w / h^2, bmi >= 25.0 ]
```

The variables defined in the `let` binding are available to the output function (the part before the `|`) and to all the predicates and sections after the binding.

The downside of `let` bindings is that they can't span guards. Some people also prefer `where` bindings because they go after the function body, and that way the type declaration and function body are close together.

### Case Expressions

Like the name implies, `case` blocks are expressions in Haskell. They let you evaluate expressions based on the possible case values of the variable, but also let you do pattern matching. This is exactly the same thing as pattern matching in function definitions. What is the difference? Pattern matching in function definitions is syntactic sugar for case statements.

So this:

```hs
head' :: [a] -> a
head' [] = error "Empty lists don't have a head."
head' (x:_) = x
```

Is the same as this:

```hs
head' :: [a] -> a
head' xs = case xs of [] -> error "Empty lists don't have a head."
                   (x:_) -> x
```

The form is:

```hs
case expression of pattern -> result
                of pattern -> result
                of pattern -> result
                ...
```

## Higher order functions

All functions in Haskell are curried, meaning they only take one argument and return a function until the correct number of arguments is given. Those intermediate functions are called partially applied functions.

```hs
ghci> sum' x y = x + y
ghci> addTwo = sum' 2
ghci> addTwo 5
ghci> 7
```

Putting a space between arguments is called function application, so `max 2 4` is the same as `(max 2) 4`.

Infix functions can also be partially applied by surrounding the function and only providing an argument on one side:

```hs
ghci> divideByTen = (/10)
ghci> divideByTen 200
ghci> 20
ghci> (/10) 200
ghci> 20
```

Take a look at the flip function:

```hs
flip' :: (a -> b -> c) -> b -> a -> c
flip' f x y = f y x
```

The type signature for `flip'` can also be written as `(a -> b -> c) -> (b -> a -> c)`, but since all functions are curried in Haskell this is unnecessary.

### `map` and `filter`

#### `map`

Map takes a function and a list, and returns a list with the function applied to each individual element.

```hs
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs
```

#### `filter`

Filter takes a predicate function and a list, and returns a list with only the elements that return true in the predicate function.

```hs
filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter p (x:xs)
    | p x       = x : filter p xs
    | otherwise = filter p xs
```

In functional programming map and filter take the place of nested loops. You take a function that produced a result, map it over a list, and filter the list on what you are looking for. Because of Haskell's laziness, even if you map and filter over a list multiple times, it will pass over the list only once.
