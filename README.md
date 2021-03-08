# The Little Schemer

_The Little Schemer_ uses a Scheme-like language, and this codebase contains Racket implementations and annotations, in the form of tests, for the code and exercises found in the book. The idea was to both learn the material in the book and to use Racket more.

## Context

I read through parts of this book a few years ago but was just reading through it and didn't do any coding. I started to go through it again some time ago by writing Racket code, but that tailed off after a few chapters. This third time around, I have gone through the book more thoroughly, improving the implementations I had already started, but now I have added proper implementations of the book's primitive functions using Racket contracts and have annotated the examples using tests via RackUnit. This proved to be more streamlined and helpful.

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

## How this might be useful for others

The code for the book is mainly located in [`the-little-schemer.rkt`](source/the-little-schemer.rkt), which contains both the implementations of the primitives for the Scheme language found in the book and the functions. The files named `chapter-<number>.rkt` contain annotations for all the questions in the book, implemented as tests. I could see this being useful in the following ways:

1. Simply use the implementations and tests as references when going through the book yourself and making your own implementations as I did.
2. Using the primitive and function implementations as they are, but then follow the book by implementing your own tests.
3. Use the primitive implementations to help guide your own function implementations and tests, so that you can use the Scheme language as it appears in the book.

I personally found writing the tests and my own primitives and functions a nice task, which taught me a few new things about Racket's contracts and testing.
