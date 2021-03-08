;;**********************************************************
;; Chapter 10: What Is the Value of All of This?
;;**********************************************************

#lang racket

(require "the-little-schemer.rkt"
         rackunit)

(define entry-example-1
  (new-entry '(appetizer entree beverage)
             '(pate boeuf vin)))

(define entry-example-2
  (new-entry '(appetizer entree beverage)
             '(beer beer beer)))

(define entry-example-3
  (new-entry '(beverage dessert)
             '((food is) (number one with us))))

(check-equal? (lookup-in-entry 'entree
                               (new-entry '(appetizer entree beverage)
                                          '(food tastes good))
                               (lambda (name) name))
              'tastes)

(check-equal? (lookup-in-table 'entree
                               (list (new-entry '(entree dessert)
                                                '(spaghetti spumoni))
                                     (new-entry '(appetizer entree beverage)
                                                '(food tastes good)))
                               (lambda (name) name))
              'spaghetti)

(check-equal? (cons 'a
                    (cons 'b
                          (cons 'c
                                '())))
              '(a b c))

(check-equal? (cons 'car
                    (cons (cons 'quote
                                (cons
                                 (cons 'a
                                       (cons 'b
                                             (cons 'c
                                                   '())))
                                 '()))
                          '()))
              '(car (quote (a b c))))

(check-equal? (car (quote (a b c)))
              'a)

(check-equal? (value '(car (quote (a b c))))
              'a)

(check-equal? (value '(quote (car (quote (a b c)))))
              '(car (quote (a b c))))

(check-equal? (value '(add1 6))
              7)

(check-equal? (value 6)
              6)

(check-equal? (value '(quote nothing))
              'nothing)

(check-equal? (value '((lambda (nothing)
                         (cons nothing (quote ())))
                       (quote (from nothing comes something))))
              '((from nothing comes something)))

(check-equal? (value '((lambda (nothing)
                         (cond [nothing (quote something)]
                               [else (quote nothing)]))
                       #t))
              'something)

(check-equal? (value #f)
              #f)

(check-equal? (value 'car)
              '(primitive car))

(check-equal? (meaning '(lambda (x) (cons x y))
                       '(((y z) ((8) 9))))
              '(non-primitive ((((y z) ((8) 9))) (x) (cons x y))))