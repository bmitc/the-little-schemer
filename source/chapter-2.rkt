#lang racket

(require "the-little-schemer.rkt")

(lat? '(Jack Sprat could eat no chicken fat))

(lat? '((Jack) Sprat could eat no chicken fat))

(lat? '(Jack (Sprat could) eat no chicken fat))

(lat? '(bacon and eggs))

(lat? '(bacon (and eggs)))

(or (null? '()) (atom? '(d e f g)))

(or (null? '(a b c)) (null? '(atom)))

(member? 'tea '(coffee tea or milk))

(member? 'poached '(fried eggs and scrambled eggs))

;**********************************************************
;The First Commandment (preliminary)
;
;Always ask null? as the first question in expressing any function.
;**********************************************************

(member? 'meat '(mashed potatoes and meat gravy))

(member? 'liver '(bagels and lox))