# Follow along repo for http://learnyouahaskell.com/

## Table of Contents

- [Follow along repo for http://learnyouahaskell.com/](#follow-along-repo-for-httplearnyouahaskellcom)
  - [Table of Contents](#table-of-contents)
  - [Notes](#notes)
    - [Starting Out](#starting-out)
      - [Intro to Functions](#intro-to-functions)
      - [Intro to Lists](#intro-to-lists)
      - [Ranges](#ranges)

## Notes

### Starting Out

#### Intro to Functions

- Functions that can take arguments on either side, like `+`, are called infix functions. A function can be made infix by surrounding it in back-ticks: ``5 `times` 6``
- `if` statements are expressions, meaning they have to return a value; the `else` is mandatory.
- Function names can include `'`, which is usually used to denote a slightly modified function or variable or a strict (non-lazy) function.
- Functions can't start with uppercase letters.
- Functions that don't take arguments are know as definitions. The function name and value can be used interchangeably.

#### Intro to Lists

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

#### Ranges

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
ghci> [5, 7, 15]
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
