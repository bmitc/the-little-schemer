;;**********************************************************
;; Chapter 6: Shadows
;;**********************************************************

#lang racket

(require "the-little-schemer.rkt"
         rackunit)

(check-equal? (quote a) 'a)

(check-equal? (quote +) '+)

(check-not-equal? (quote +) +)

(check-equal? (quote ×) '×)

(check-not-equal? (quote +) ×)

(check-true (eq? (quote a) 'a))

(check-true (eq? 'a 'a))

(check-true (numbered? 1))

(check-true (numbered? '(3 + (4 ↑ 5))))

(check-false (numbered? '(2 × sausage)))

(check-equal? (value 13) 13)

;; value is rewritten for another representation
#;(check-equal? (value '(1 + 3)) 4)

;; value is rewritten for another representation
#;(check-equal? (value '(1 + (3 ↑ 4))) 82)

;;**********************************************************
;; The Seventh Commandment
;;
;; Recur on the subparts that are of the same nature:
;; * On the sublists of a list.
;; * On the subexpressions of an arithmetic expression.
;;**********************************************************

(check-false (atom? '(+ 1 3)))

(check-true (eq? (car '(+ 1 3)) (quote +)))

(check-equal? (cdr '(+ 1 3)) '(1 3))

;; Added test not in the book
(check-equal? (value '(+ 1 3)) 4)

;; Added test not in the book
(check-equal? (value '(+ 1 3)) 4)

;; Added test not in the book
(check-equal? (value '(+ 1 (↑ 3 4))) 82)

;;**********************************************************
;; The Eighth Commandment
;;
;; Use help functions to abstract from representations.
;;**********************************************************

;; The definitions and tests for the alternative number representation are not implemented.