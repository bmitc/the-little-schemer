;;**********************************************************
;; Chapter 9: ...and Again, and Again, and Again, ...
;;**********************************************************

#lang racket

(require "the-little-schemer.rkt"
         rackunit)

(check-true (looking 'caviar '(6 2 4 caviar 5 7 3)))

(check-false (looking 'caviar '(6 2 grits caviar 5 7 3)))

(check-true (looking 'caviar '(6 2 4 caviar 5 7 3)))

(check-equal? (pick 6 '(6 2 4 caviar 5 7 2))
              7)

(check-equal? (pick 7 '(6 2 4 caviar 5 7 3))
              3)

(check-true (keep-looking 'caviar 4 '(6 2 4 caviar 5 7 3)))

(check-equal? (shift '((a b) c))
              '(a (b c)))

(check-equal? (shift '((a b) (c d)))
              '(a (b (c d))))

(check-equal? (weight* '((a b) c))
              7)

(check-equal? (weight* '(a (b c)))
              5)

(check-equal? (shuffle '(a (b c)))
              '(a (b c)))

(check-equal? (shuffle '(a b))
              '(a b))

(check-equal? (A 1 0) 2)

(check-equal? (A 1 1) 3)

(check-equal? (A 2 2) 7)