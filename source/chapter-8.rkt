;;**********************************************************
;; Chapter 8: Lambda the Ultimate
;;**********************************************************

#lang racket

(require "the-little-schemer.rkt"
         rackunit)

;; rember-f is rewritten
#;(check-equal? (rember-f = 5 '(6 2 5 3))
                '(6 2 3))

;; rember-f is rewritten
#;(check-equal? (rember-f eq? 'jelly '(jelly beans are good))
                '(beans are good))

(check-true (eq?-salad 'salad))

(check-false (eq?-salad 'tuna))

(check-false ((eq?-c 'salad) 'tuna))

;; Added test not in the book
(check-equal? ((rember-f =) 5 '(6 2 5 3))
              '(6 2 3))

;; Added test not in the book
(check-equal? ((rember-f eq?) 'jelly '(jelly beans are good))
              '(beans are good))

(check-equal? (rember-eq? 'tuna '(tuna salad is good))
              '(salad is good))

(check-equal? ((rember-f eq?) 'tuna '(shrimp salad and tuna salad))
              '(shrimp salad and salad))

(check-equal? ((rember-f eq?) 'eq? '(equal? eq? eqan? eqlist? eqpair?))
              '(equal? eqan? eqlist? eqpair?))

;;**********************************************************
;; The Ninth Commandment
;;
;; Abstract common patterns with a new function.
;;**********************************************************

(check-equal? (atom-to-function (operator '(+ 5 3)))
              +)

;; Added test not in the book
(check-equal? (value '(× 2 3)) 6)

(check-equal? ((multirember-f eq?) 'tuna '(shrimp salad tuna salad and tuna))
              '(shrimp salad salad and))

(check-equal? (multiremberT eq?-tuna '(shrimp salad tuna salad and tuna))
              '(shrimp salad salad and))

(check-true (multirember&co 'tuna '() a-friend))

(check-false (multirember&co 'tuna '(tuna) a-friend))

(check-false (multirember&co 'tuna '(and tuna) a-friend))

(check-equal? (multirember&co 'tuna '(strawberries tuna and swordfish) last-friend)
              3)

;;**********************************************************
;; The Tenth Commandment
;;
;; Build functions to collect more than one value at a time.
;;**********************************************************

(check-equal? (evens-only* '((9 1 2 8) 3 10 ((9 9) 7 6) 2))
              '((2 8) 10 (() 6) 2))

(check-equal? (evens-only*&co '((9 1 2 8) 3 10 ((9 9) 7 6) 2) the-last-friend)
              '(38 1920 (2 8) 10 (() 6) 2))