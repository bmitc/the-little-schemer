;;**********************************************************
;; Chapter 3: Cons the Magnificent
;;**********************************************************

#lang racket

(require "the-little-schemer.rkt"
         rackunit)

(check-true (atom? 14))

(check-equal? (add1 67) 68)

(check-equal? (sub1 5) 4)

(check-true (zero? 0))

(check-false (zero? 1492))

(check-equal? (+ 46 12) 58)

(check-equal? (- 14 3) 11)

(check-equal? (- 17 9) 8)

(check-true (tup? '(2 11 3 79 47 6)))

(check-true (tup? '(8 55 5 555)))

(check-false (tup? '(1 2 8 apple 4 3)))

(check-false (tup? '(3 (7 4) 13 9)))

(check-true (tup? '()))

(check-equal? (addtup '(3 5 2 8)) 18)

(check-equal? (addtup '(15 6 7 12 3)) 43)

;;**********************************************************
;; The First Commandment (first revision)
;;
;; When recurring on a list of atoms, lat, ask two questions
;; about it: (null? lat) and else.
;; When recurring on a number, n, ask two questions about
;; it: (zero? n) and else.
;;**********************************************************

(check-equal? (× 5 3) 15)

(check-equal? (× 13 4) 52)

;;**********************************************************
;; The Fourth Commandment (first revision)
;;
;; Always change at least one argument while recurring. It
;; must be changed to be closer to termination. The changing
;; argument must be tested in the termination condition:
;; when using cdr, test termination with null? and
;; when using sub1, test termination with zero?.
;;**********************************************************

(check-equal? (× 12 3) 36)

;;**********************************************************
;; The Fifth Commandment
;;
;; When building a value with +, always use 0 for the value of the
;; terminating line, for adding 0 does not change the value of an
;; addition.
;; When building a value with ×, always use 1 for the value of the
;; terminating line, for multiplying by 1 does not change the value
;; of a multiplication.
;; When building a value with cons, always consider () for the value
;; of the terminating line. 
;;**********************************************************

(check-equal? (tup+ '(3 6 9 11 4) '(8 5 2 0 7))
              '(11 11 11 11 11))

(check-equal? (tup+ '(2 3) '(4 6))
              '(6 9))

(check-equal? (tup+ '(3 7) '(4 6))
              '(7 13))

(check-equal? (tup+ '(3 7) '(4 6 8 1))
              '(7 13 8 1))

(check-equal? (tup+ '(4 6 8 1) '(3 7))
              '(7 13 8 1))

(check-false (> 12 133))

(check-true (> 120 11))

(check-true (< 4 6))

(check-false (< 8 3))

(check-false (< 6 6))

(check-equal? (↑ 1 1) 1)

(check-equal? (↑ 2 3) 8)

(check-equal? (↑ 5 3) 125)

(check-equal? (÷ 15 4) 3)

(check-equal? (length '(hotdogs with mustard sauerkraut and pickles))
              6)

(check-equal? (length '(ham and cheese on rye))
              5)

(check-equal? (pick 4 '(lasagna spaghetti ravioli macaroni meatball))
              'macaroni)

(check-equal? (rempick 3 '(hotdogs with hot mustard))
              '(hotdogs with mustard))

(check-false (number? 'a))

(check-true (number? 76))

(check-equal? (no-nums '(5 pears 6 prunes 9 dates))
              '(pears prunes dates))

(check-equal? (all-nums '(5 pears 6 prunes 9 dates))
              '(5 6 9))