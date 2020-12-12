;;**********************************************************
;; Chapter 2: Do It, Do It Again, and
;;            Again, and Again...
;;**********************************************************

#lang racket

(require "the-little-schemer.rkt"
         rackunit)

(check-true (lat? '(Jack Sprat could eat no chicken fat)))

(check-false (lat? '((Jack) Sprat could eat no chicken fat)))

(check-false (lat? '(Jack (Sprat could) eat no chicken fat)))

(check-true (lat? '()))

(check-true (lat? '(bacon and eggs)))

(check-false (lat? '(bacon (and eggs))))

(check-true (or (null? '()) (atom? '(d e f g))))

(check-true (or (null? '(a b c)) (null? '())))

(check-false (or (null? '(a b c)) (null? '(atom))))

(check-true (member? 'tea '(coffee tea or milk)))

(check-false (member? 'poached '(fried eggs and scrambled eggs)))

;;**********************************************************
;; The First Commandment (preliminary)
;;
;; Always ask null? as the first question in expressing
;; any function.
;;**********************************************************

(check-true (member? 'meat '(mashed potatoes and meat gravy)))

(check-true (member? 'meat '(meat gravy)))

(check-true (member? 'meat '(and meat gravy)))

(check-true (member? 'meat '(potatoes and meat gravy)))

(check-true (member? 'meat '(mashed potatoes and meat gravy)))

(check-false (member? 'liver '(bagels and lox)))