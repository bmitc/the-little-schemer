# The Little Schemer

_The Little Schemer_ uses a Scheme-like language, and this codebase contains Racket implementations and annotations for the code and exercises found in the book. The idea was to both learn the material in the book and Racket.

## Context

I read through parts of this book a few years ago but was just reading through it and didn't do any coding. I started to go through it again some time ago by writing Racket code, but that tailed off after a few chapters. This third time around, I'm going through the book more thoroughly, improving the implementations I had already started, but now I've added proper implementations of the book's primitive functions using Racket contracts and have annotated the examples using tests via RackUnit. This is proving to be more streamlined and helpful.

## What I learned

* By implementing certain functions, such as `cons` as they are in the book's Scheme, this required re-writing the built-in functions in Racket. For example, `cons` in Racket can accept any value for its two arguments, but the book's Scheme only accepts a list for the second argument. To implement and enforce this, I used Racket's contract system. So I learned about using `define/contract` and how to create contracts and use contract combinators.
  * [Simple Contracts on Functions](https://docs.racket-lang.org/guide/contract-func.html)
  * [Contracts](https://docs.racket-lang.org/reference/contracts.html)
* Using RackUnit's various check functions
  * [RackUnit API](https://docs.racket-lang.org/rackunit/api.html)
* The use of submodules like `module+` to contain tests in the same file as your implementation code.
  * [Running Tests in Dr. Racket](https://beautifulracket.com/explainer/unit-testing.html#running-unit-tests-in-drracket)
* The use of [`rename-in`](https://docs.racket-lang.org/reference/require.html#%28form._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._rename-in%29%29) to rename imported functions. This was useful in renaming things like `cons` to `racket-cons` so that my newly defined `cons` using `define/contract` would be the one used but could be defined using the original Racket `cons`, i.e. `racket-cons`.

## What was reiterated

* The beauty of Scheme and Racket
* Recursion
* Being clear about assumptions and what questions are being asked
