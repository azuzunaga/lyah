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
  - [Higher Order Functions](#higher-order-functions)
    - [`map` and `filter`](#map-and-filter)
      - [`map`](#map)
      - [`filter`](#filter)
    - [Lambdas](#lambdas)
    - [Folds](#folds)
      - [`foldl`](#foldl)
      - [`foldr`](#foldr)
      - [`foldl1` and `foldr1`](#foldl1-and-foldr1)
      - [`scanr` and `scanl`](#scanr-and-scanl)
    - [Function Application With `$`](#function-application-with-)
    - [Function Composition](#function-composition)
  - [Modules](#modules)
    - [Loading Modules](#loading-modules)
    - [Useful Functions From the Standard Library:](#useful-functions-from-the-standard-library)
  - [Types and Typeclasses](#types-and-typeclasses-1)
    - [Algebraic Data Types](#algebraic-data-types)
    - [Record Syntax](#record-syntax)
    - [Type Parameters](#type-parameters)
    - [Derived Instances](#derived-instances)
      - [`Eq`](#eq)
      - [`Show` and `Read`](#show-and-read)
      - [`Ord`](#ord)
      - [`Enum` and `Bounded`](#enum-and-bounded)
    - [Type Synonyms](#type-synonyms)
      - [The `Either a b` type](#the-either-a-b-type)
    - [Recursive Data Structures](#recursive-data-structures)
    - [Typeclasses 102](#typeclasses-102)

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
- `Ord`: For types that have an ordering. Covers functions such as `>`, `<`, `<=`, `>=`, `compare`. `compare` takes two `Ord` members of the same type and returns `GT`, `LT, or`EQ`.
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

## Higher Order Functions

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

In functional programming map and filter take the place of nested loops. You take a function that produces a result, map it over a list, and filter the list on what you are looking for. Because of Haskell's laziness even if you map and filter over a list multiple times, it will pass over the list only once.

### Lambdas

Lambdas are anonymous functions that are used when we need to pass a one-off function to a higher order function. To make a lambda, start with a `\` (it kinda looks like a λ) followed by the parameters separated by spaces, and then a `->` followed by the function body. Unless the lambda is wrapped in parentheses it extends all the way to the right.

Many times lambdas are used unnecessarily, because people forget that Haskell curries functions by default, so `map (\x -> x + 3) [2, 3, 4]` is really the same as `map (+3) [2, 3, 4]`.

Like normal functions, lambdas can take many parameters and you can also pattern match, but only one pattern. You have to be careful when pattern matching in lambdas, because if the pattern match fails in a lambda you get an error.

The two functions below are identical, and using lambdas is a neat way to illustrate currying:

```hs
addThree :: (Num a) => a -> a -> a -> a
addThree z y z = x + y + z
```

And:

```hs
addThree :: (Num a) => a -> a -> a -> a
addThree \x -> \y -> \z -> x + y + z
```

But lambda notation is sometimes clearer:

```hs
flip :: (a -> b -> c) -> b -> a -> c
flip f = \x y -> f y x
```

In the example above, using a lambda makes it obvious that the flip function produces a new function.

### Folds

Folds are a very similar concept to reduce functions, which take a list, an initial argument or accumulator, and a binary function (takes two arguments) that "reduces" the values of the list and the accumulator to a single value.

#### `foldl`

`foldl` also called the left fold, folds up the list from the left side. The binary function is applied between the accumulator and the head of the list. The result becomes the new accumulator and the binary function is called with that new accumulator and the next element in the list.

The sum function can be implemented with a left fold:

```hs
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x = acc + x) 0 xs
```

Taking into account the fact that functions are curried, the sum function can also be written like this:

```hs
sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0
```

`(\acc x = acc + x)` can be rewritten as (+). The `xs` parameter can be omitted because calling `foldl (+) 0` will return a function that takes a list. Pro-tip: generally, if you have a function that looks like `foo a = bar a b` it can be rewritten as `foo = bar b`. Because of currying.

We can also implement `elem` with a left fold:

```hs
elem' :: (Eq a) => a -> [a] -> Bool
elem' y = foldl (\acc x -> if x == y then True else acc) False
```

Remember that the type of the accumulator is always the same as the return value.

#### `foldr`

Similar to a left fold, except the list is consumed from the right. The binary function argument order is also flipped, so the first parameter is the current value and the second is the accumulator (`\x acc -> ...` instead of `\acc x -> ...`).

One thing to note is that the type of the accumulator value can be anything, even a new list. Below `map` is implemented with a right fold:

```hs
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs
```

Remember that since functions are curried by default the `map` function can also be written like this:

```hs
map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x acc -> f x : acc) []
```

`map` can also be implemented with a left fold, and most other functions can be implemented with either a right or left fold, with varying amounts of tweaking. But, where left folds can't work with infinite lists, right folds can.

Folds, like maps and filters, are a workhorse of functional programming. Use folds whenever you want to traverse a list to return something.

#### `foldl1` and `foldr1`

Similar to `foldl` and `foldr` except an accumulator value does not need to be provided. Instead, it is the first element of the list from the right or left side respectively. However, both of these functions will fail if given an empty list.

Implementing a few standard library functions with folds:

```hs
sum' :: (Num a) => [a] -> a
sum' = foldr1 (+)

maximum' :: (Ord a) => [a] -> a
maximum' = foldl1 (\acc x -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) []

product' :: (Num a) => [a] -> a
product' = foldl1 (*)

filter' :: (a -> Bool) -> [a] -> [a]
filter' f = foldl (\acc x -> if f(x) then x : acc else acc) []

head' :: [a] -> a
head' = foldr1 (\x _ -> x)

last' :: [a] -> a
last' = foldl1 (\_ x -> x)
```

Think of left and right folds as nested function applications over the values of a list, so folding right over the values of a list `[3,6,3,7,2]` is `f 3 (f 6 (f 3 (f 7 (f 2 acc))))` and folding left would be `f (f (f (f (f acc 3) 6) 3) 7) 2`.

#### `scanr` and `scanl`

Similar to `foldr` and `foldl`, except these functions output a list with all the intermediate accumulator values. `scanr` and `scanl1` are similar to `foldr1` and `foldl1`. For `scanr` the head of the list will be the final value of the fold function, and for `scanl` it will be the last element.

```hs
ghci> scanl (+) 0 [5,2,7,4]
[0,5,7,14,18]

ghci> scanr (+) 0 [5,2,7,4]
[18,13,11,4,0]

ghci> scanl1 (\acc x -> if x > acc then x else acc) [4,6,3,5,2,7,8,1]
[4,6,6,6,6,7,8,8]

ghci> scanl (flip (:)) [] [3,2,1]
[[], [3], [2, 3], [1, 2, 3]]
```

Scans are useful for monitoring the progression of a function that can be implemented as a fold. One use case is to monitor the results of a fold until a certain threshold or condition is met, and then counting the number of items in the resulting scan list.

### Function Application With `$`

Take a look at the definition of the function `$`:

```hs
($) :: (a -> b) -> a -> b
f $ x = f x
```

The `$` operator is just like function application with a space, except it has the lowest precedence. Function application with a space is left associative, so `f a b c` is the same as `((f a) b) c`, and function application with the `$` operator is right associative, so `f $ a $ b $ c` is the same as `f (a (b c))`.

This is helpful because it can be used to replace parentheses, so `sum (map sqrt [1..130])` becomes `sum $ map sqrt [1..130]`. When a `$` the expression on the right is applied as the parameter to the expression on the left. What if you have a function that takes many parameters, like trying to get the square root of 5 + 3 + 7? With parentheses it would be written as `sqrt (5 + 3 + 7)` and with function application it would be written as `sqrt $ 5 + 3 + 7`.

But since `$` is a function, it can be treated like any other function:

```hs
ghci> map ($ 5) [(4+), (9*), (^3), sqrt]
[9.0,45.0,125.0,2.23606797749979]
```

### Function Composition

Function composition in math is defined as <img src="https://render.githubusercontent.com/render/math?math=(f.g)(x) = f(g(x))">. This means that composing two functions `f` and `g` produces a new function that, when called with a parameter `x` is the same as calling `g` with the parameter `x` and then calling `f` with that result.

This works the same in Haskell, with the function `.` defined as:

```hs
(.) :: (b -> c) -> (a -> b) -> a -> c
f . g = \x -> f (g x)
```

The type declaration says that function `f` takes as a parameter a value of the same type as `g`'s return value. The composed function takes a parameter of the same type that `g` takes and returns a value that matches the return type of function `f`.

The expression `negate . (/ 7)` returns a function that takes a number, divides it by 7, and then negates it.

One of the uses of function composition is making functions to pass to other functions. Lambdas can also be used for that, but many times function composition is cleaner. For example, take a list of numbers that we want to turn all into negative numbers.

With lambdas:

```hs
ghci> map (\x -> negate (abs x)) [5,-3,-6,7,-3,2,-19,24]
[-5,-3,-6,-7,-3,-2,-19,-24]
```

Notice how the lambda looks like the definition of function composition. Using function composition:

```hs
ghci> map (negate . abs) [5,-3,-6,7,-3,2,-19,24]
[-5,-3,-6,-7,-3,-2,-19,-24]
```

Function composition is right associative, so `f . g . z x` is the same as `f (g (z x))`. So:

```hs
map (\xs -> negate (sum (tail xs))) [[1..5],[3..6],[1..7]]
```

Can be turned into:

```hs
map (negate . sum . tail) [[1..5],[3..6],[1..7]]
```

What if a function takes more than one parameter? In that case the functions have to be partially applied so that each function only takes one parameter. So that `sum (replicate 5(max 3 8))` can be rewritten as `(sum . replicate 5 . max 3) 8` or `sum . replicate 5 . max 3 $ 8`.

Rewriting a function with a lot of parentheses with function composition can be done by putting the last parameter of innermost function after a `$`, and then composing all other functions without their last parameter. `replicate 100 (product (map (*3) (zipWith max [1,2,3,4,5] [4,5,6,7,8])))` can be rewritten as `replicate 100 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8]`.

Another use of function composition is writing functions in _point free_ style. So `sum' xs = foldl 0 xs` becomes `sum' = foldl 0`. `xs` is on both sides of the function. Because of currying the `xs` can be omitted.

But how about writing `fn x = ceiling (negate (tan (cos (max 50 x))))` in point free style? The `x` is inside of the parentheses and taking the cosine of a function doesn't make sense. Function composition to the rescue: `fn = ceiling . negate. tan . cos . max 50`.

A point free style is often neater and more readable, but it can be taken too far with long composition chains. Check out three different ways of writing a function that finds the sum of all odd squares that are smaller than 10,000:

```hs
oddSquareSum :: Integer
oddSquareSum = sum (takeWhile (<10000) (filter odd map (^2) [1..]))
```

Using function composition:

```hs
oddSquareSum :: Integer
oddSquareSum = sum . takeWhile (<10000) . filter . odd . map (^2) $ [1..]
```

And finally, with more readable and maintainable code:

```hs
oddSquareSum :: Integer
oddSquareSum =
    let oddSquares = filter odd $ map (^2) [1..]
        belowLimit = takeWhile (<10000) oddSquares
    in  sum belowLimit
```

## Modules

### Loading Modules

A module is a collection of related functions, types, and typeclasses. To import a module, you have to place `import <module name>` at the top of the file. To import multiple modules you just put each import statement in a new line.

When you import a module, all of the functions of that module become available in the global namespace. You can also do this in ghci by entering `m: + <module name>`. If you want to import more than one module in ghci you separate the modules names with a space.

- To import only a few functions from a module: `import <module name> (function1 function2)`.
- To import everything but a few functions from a module: `import <module name> hiding (function1)`
- Deal with name clashes by namespacing imports: `import qualified <module name>`.
- Create an alias for the namespaced module: `import qualified <module name> as <mn>`

### Useful Functions From the Standard Library:

- [`Data.List`](http://learnyouahaskell.com/modules#data-list)
- [`Data.Char`](http://learnyouahaskell.com/modules#data-char)
- [`Data.Map`](http://learnyouahaskell.com/modules#data-map)
- [`Data.Set`](http://learnyouahaskell.com/modules#data-set)

## Types and Typeclasses

### Algebraic Data Types

To make your own data type you use the data keyword. Check out how the `Bool` type is defined:

```hs
data Bool = False | True
```

`data` means that we are defining a new data type. `Bool` is the name of the type, and the stuff after the equals sign are the posible values, where `|` means or. So this can be read as _the `Bool` type can have a value of `True` or `False`_.

What if we want to create a custom type?

```hs
data Shape = Circle Float Float Float | Rectangle Float Float Float Float
```

A circle is defined as a coordinate point that represents the center of the circle and a radius, and a rectangle is defined as two coordinate points which represent two opposite corners of a rectangle. And what are `Circle` and `Rectangle`? They are a type of function called value constructors, which accept parameters and return a value of a data type:

```hs
ghci> :t Rectangle
Rectangle :: Float -> Float -> Float -> Float -> Shape
```

You can use value constructors to pattern match:

```hs
surface :: Shape -> Float
surface (Circle _ _ r) -> pi * r^2
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)
```

To get ghci to print our data types we have to make them part of the `Show` typeclass:

```hs
data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)
```

We can use data types inside our data types to make them more understandable:

```hs
data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

surface :: Shape -> Float
surface (Circle _ r) = pi * r^2
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)
```

We used the same name for the value constructor and the data type when defining `Point`. This is not necessary but it is a common thing to do if there is only one value constructor. Notice also how the `surface` function had to be modified, but only the patterns.

Exporting types is easy, just write them alongside the functions that are being exported and add some parentheses with the constructors you want to export (comma separated). If you want to export all the value constructors for a type just write `..` inside the parentheses.

You can also not export any constructors and export auxiliary functions that make the data types. This makes the data type more abstract and keeps functions from pattern matching against the constructors.

Algebraic Data Types are called that because they are created by algebraic operations, sum and product. Sum is defined as alternation (`A|B`, meaning `A` or `B` but not both), and product is defined as combination (`A B`, meaning `A` and `B` together).

### Record Syntax

Record syntax is used when creating data types to make them more descriptive, readable in ghci, and as a bonus it creates attribute reader functions for each field. To use record syntax, declare a data type, open curly braces and inside list all the fields. After each field, a double colon followed by a type designates the type of that field:

```hs
data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     , height :: Float
                     , phoneNumber :: String
                     } deriving (Show)
```

```hs
ghci> Person { firstName="Jim", lastName="Bob", age=20, height=72, phoneNumber="20363184818" }
Person { firstName="Jim", lastName="Bob", age=20, height=72, phoneNumber="20363184818" }
```

Use record syntax when a constructor has several fields and it is not clear which one is which; without record syntax fields have to be specified in order.

### Type Parameters

Type constructors can take types as parameters and produce a new type (similar to value constructors that take some values as parameters and produce a new value).

For example, the `Maybe` type constructor:

```hs
data Maybe a = Nothing | Just a
```

The `a` is the type parameter, and `Maybe` is the type constructor. No value can have a type of just `Maybe` since that is just the type constructor. If we pass a type of `Num` as the type parameter to `Maybe` we get a type of `Maybe Num`. So the value `Just 7` has a type of `Maybe Num`.

Check out the type of `Nothing`:

```hs
ghci> :t Nothing
Nothing :: Maybe a
```

`Nothing` has a polymorphic type, which means that it can be of any type. So if you have a function that expects a `Char` you can pass it `Nothing` because a `Nothing` doesn't contain a value anyway. This is similar to empty lists (type `[a]`) since it can act like a list of anything.

Although type parameters are useful, only use them when it makes sense, usually when the type in the data type's value constructors isn't important for the type to work. Going back to lists, a list of things is a list of things, and it doesn't matter what the type is. If we need to sum the elements of the list we can specify the type in the summing function.

It is a convention in Haskell to **never add typeclass constraints in data declarations.** It doesn't really have that many benefits and we end up writing more class constraints even when unneeded. Don't out type constraints into data declarations even if it seems to make sense, because they'll have to be added to the function type declarations either way.

### Derived Instances

Typeclasses define an interface for behavior (e.g. the `Int` type is part of the `Eq` typeclass because `Eq` defines behavior for things that can be equated), which is why they are often confused with classes in OO languages. However, whereas in OO languages a class is used to define behavior and also to initialize objects that contain data (state), typeclasses only define an interface. In Haskell, we first create data and then think of the behavior it has. If it can be equated, we make it part of the `Eq` typeclass.

Haskell can automatically make our types part of these typeclasses by using the `deriving` keyword: `Eq`, `Ord`, `Enun`, `Bounded`, `Show`, and `Read`.

#### `Eq`

When deriving the `Eq` instance for a type and comparing using `==` or `/=`, Haskell first checks if the value constructors match, then it compares each pair of fields. However, the types of all the fields have to be a part of the `Eq` typeclass.

#### `Show` and `Read`

`Show` and `Read` are for things that can be converted to and from strings. Similarly to the `Eq` typeclass, if a type constructor has fields they have to be part of `Show` and `Read`.

`Show` is used to print types to the terminal, and `Read` converts strings into types. When using the `read` function we have to use a specific type annotation so that Haskell knows which type we want. However, it isn't necessary to specify a type if we use the result of the `read` function in a way that Haskell can infer the type.

#### `Ord`

The `Ord` typeclass is used for types that can be ordered. If two values of the same type but made with different constructors are compared, the value that was made with a constructor that's defined first is considered smaller. Using the `Bool` type to illustrate:

```hs
data Bool = False | True deriving (Ord)
```

```hs
ghci> True `compare` False
GT
ghci> True > False
True
ghci> True < False
False
```

If comparing two values of the same type and the same constructor the values inside them are compared.

#### `Enum` and `Bounded`

We can use algebraic data types to create types that derive from the `Enum` and `Bounded` typeclasses:

```hs
data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
```

Since all the constructors don't take any parameters (nullary) `Day` can derive from the `Enum` typeclass. This typeclass is for things that have predecesors and succesors. `Day` can also derive from `Bounded`, which is for things that have a max and a min.

With the `Enum` typeclass we can use functions like `succ` or `pred`, and create lists using ranges. With the `Bounded` typeclass we can get the highest and lowest day:

```hs
ghci> succ Friday
Saturday
ghci> pred Thursday
Wednesday
ghci> minBound :: Day
Monday
ghci> [Friday .. Sunday]
[Friday,Saturday,Sunday]
```

### Type Synonyms

Let's see how the types `[Char]` and `String` are equivalent:

```hs
type String = [Char]
```

The `type` keyword does not introduce a new type, it just creates an alias for an existing type. This is used for making code more readable and understandable. So for example, if we had a suit of cards, `Ace, King, Queen,...` we could alias it to `Suit` and pass that around in type declarations.

Type synonyms can also be parametrized. So if we had an association list, but wanted to create a type synonym that was general enough to support any value in the list, it would look like this:

```hs
type AssociationList k v = [(k,v)]
```

And a function that gets the value from an association list with the key would look like this:

```hs
getVal :: (Eq k) => k -> AssociationList k v -> Maybe v
```

`AssociationList` is a type constructor that takes two types and produces a concrete, fully applied type like `AssociationList Int String`.

Parameters and also be partially applied with type constructors. Take for instance a type for a map from integers to something:

```hs
type IntMap v = Data.Map Int v
```

Or:

```hs
type IntMap = Data.Map Int
```

#### The `Either a b` type

This type takes two parameters and is defined:

```hs
type Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)
```

It has two value constructors: If the `Left` is used, then its contents are of type `a` and if the `Right` is used, the contents are of type `b`. This type can be used to encapsulate a value of one type or another, and then when a function we are using gets a value of type `Either a b`, we can pattern match on `Left` or `Right`.

```hs
ghci> Right 20
Right 20
ghci> Left "w00t"
Left "w00t"
ghci> :t Left True
Left True :: Either Bool b
ghci> :t Right 'a'
Right 'a' :: Either a Char
```

Before, we used `Maybe a` to represent the results of a computation that might fail. If the operation was successfult we got a `Just a` and if it failed we got a `Nothing`. But sometimes we need more information than just `Nothing`. We need to know how a computation failed. When that is the case, we can use the type `Either a b` for the result, where `a` is some sort of type that tells us about the failure and `b` is the type of a successful computation. So, errors use the `Left` type constructor and results use the `Right` type constructor.

See the lockers example in http://learnyouahaskell.com/making-our-own-types-and-typeclasses#type-synonyms for code that uses the `Either a b` type.

### Recursive Data Structures

Like a recursive function, you can use a type definition in its own body to represent a nested structure. For example, implementing a binary search tree (a binary search tree has nodes and branches, all the values to the left of a node are smaller than it, all values to the right are bigger than it. A node can have up to two branches):

```hs
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)
```

What the above type declaration says is, a `Tree` can either be an `EmptyTree` or have a `Node` and two `Tree` branches. Either of these branches could either be an `EmptyTree` or a `Node` and two `Tree` branches. All of these new branches could either...

Let's create a function that inserts a new value into a tree in its correct spot. Remember that since Haskell keep state immutable, a new tree will be created after insertion.

First we'll define an utility function to insert only nodes, and then use that in our insertion function:

```hs
singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
    | x == a = Node x left right
    | x > a  = Node a left (treeInsert x right)
    | x < a  = Node a (treeInsert x left) right
```

First we define an edge condition, an empty tree, which is were we want to insert our value. Then we compare the value to insert to values in the tree. If it is the same as the node, we return a tree that is the same, if it is bigger than the node we recursively call the `insertTree` function on the right branch of the tree, if it is smaller than the node, we recursively call the `insertTree` function on the left branch of the tree.

Now let's write a function to check if an element is in a tree:

```hs
treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem _ EmptyTree = False
treeElem x (Node a left right)
  | x == a = True
  | x > a  = treeElem x right
  | x < a  = treeElem x left
```

First we check for our edge condition, an empty tree. If so, we know our element isn't in it, so we return false. Then we compare the value against the node of the tree. If it matches, return true, if it is bigger or smaller than the node, call `treeElem` on the respective branch of the tree.

Check out how to create a tree from a list:

```hs
ghci> let nums = [8,6,4,1,7,3,5]
ghci> let numsTree = foldr treeInsert EmptyTree nums
ghci> numsTree
Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) (Node 4 EmptyTree EmptyTree)) (Node 7 (Node 6 EmptyTree EmptyTree) (Node 8 EmptyTree EmptyTree))
```

### Typeclasses 102

Recaping: Typeclasses are like interfaces. A typeclass defines some behavior and the types that can behave in that way are automatically made instances of that typeclass. This behavior is implemented by functions or type declarations. So, when we say a type is a member of a typeclass we mean that we can use the functions of the typeclass with the type.

The `Eq` typeclass is defined like this in the standard prelude:

```hs
class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool
    x == y = not (x /= y)
    x /= y = not (x == y)
```

Breaking this down: `class Eq a where` means we are creating a new typeclass named `Eq`. `a` is the type variable and it means `a` is the type that will be a member of `Eq`. Then we define some functions for the typeclass. The function bodies themselves are not mandatory, just the type declarations.

Since we implemented `==` and `!=` in terms of each other, when we derive or create a type instance of the `Eq` typeclass we only have to override one of them. That is called the minimal complete definition for the typeclass.

If we had defined `Eq` like this:

```hs
class Eq a where
    (==) :: a -> a -> Bool
    (!=) :: a -> a -> Bool
```

We would've had to implement both functions when deriving instances, since Haskell doesn't know how they are related.

So if we had street lights that we wanted to be instances of the `Eq` typeclass we could do it this way:

```hs
data TrafficLight = Red | Yellow | Green

instance Eq TrafficLight where
    Red == Red = True
    Yellow == Yellow = True
    Green == Green = True
    _ == _ = False
```

We can use this approach to derive from `Show`. Usually, deriving from `Show` will just print out the constructors, but if we want a custom string we need to do it by hand:

```hs
instance Show TrafficLight where
    show Red = "Red Light"
    show Yellow = "Yellow Light"
    show Green = "Green Light"
```

You can also make typeclasses that are subclasses of other typeclasses. Check out the first part of the class declaration for `Num`:

```hs
class (Eq a) => Num a where
    ...
```

Class constraints can be put in a lot of different places. The above is like saying `class Num a where`, only that we also say that the type `a` has to be an instance of `Eq`.
