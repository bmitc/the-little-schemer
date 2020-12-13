;;**********************************************************
;; Chapter 3: Cons the Magnificent
;;**********************************************************

#lang racket

(require "the-little-schemer.rkt"
         rackunit)

(check-equal? (rember 'mint '(lamb chops and mint jelly))
              '(lamb chops and jelly))

(check-equal? (rember 'mint '(lamb chops and mint flavored mint jelly))
              '(lamb chops and flavored mint jelly))

(check-equal? (rember 'toast '(bacon lettuce and tomato))
              '(bacon lettuce and tomato))

(check-equal? (rember 'cup '(coffee cup tea cup and hick cup))
              '(coffee tea cup and hick cup))

(check-equal? (rember 'bacon '(bacon lettuce and tomato))
              '(lettuce and tomato))

;;**********************************************************
;; The Second Commandment
;;
;; Use cons to build lists.
;;**********************************************************

(check-equal? (rember 'sauce '(soy sauce and tomato sauce))
              '(soy and tomato sauce))

(check-equal? (firsts '((apple peach pumpkin)
                        (plum pear cherry)
                        (grape raisin pea)
                        (bean carrot eggplant)))
              '(apple plum grape bean))

(check-equal? (firsts '((a b) (c d) (e f)))
              '(a c e))

(check-equal? (firsts '())
              '())

(check-equal? (firsts '((five plums)
                        (four)
                        (eleven green oranges)))
              '(five four eleven))

(check-equal? (firsts '(((five plums) four)
                        (eleven green oranges)
                        ((no) more)))
              '((five plums) eleven (no)))

;;**********************************************************
;; The Third Commandment
;;
;; When building a list, describe the first typical element,
;; and then cons it onto the natural recursion.
;;**********************************************************

(check-equal? (insertR 'topping 'fudge '(ice cream with fudge for dessert))
              '(ice cream with fudge topping for dessert))

(check-equal? (insertR 'jalapeno 'and '(tacos tamales and salsa))
              '(tacos tamales and jalapeno salsa))

(check-equal? (insertR 'e 'd '(a b c d f g d h))
              '(a b c d e f g d h))

(check-equal? (subst 'topping 'fudge '(ice cream with fudge for dessert))
              '(ice cream with topping for dessert))

(check-equal? (subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))
              '(vanilla ice cream with chocolate topping))

(check-equal? (multirember 'cup '(coffee cup tea cup and hick cup))
              '(coffee tea and hick))

;;**********************************************************
;; The Fourth Commandment (preliminary)
;;
;; Always change at least one argument while recurring. It
;; must be changed to be closer to termination. The changing
;; argument must be tested in the termination condition:
;; when using cdr, test termination with null?.
;;**********************************************************

