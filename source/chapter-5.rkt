;;**********************************************************
;; Chapter 5: Oh My Gawd: It's Full of Stars
;;**********************************************************

#lang racket

(require "the-little-schemer.rkt"
         rackunit)

(check-equal? (rember* 'cup '((coffee) cup ((tea) cup) (and (hick)) cup))
              '((coffee) ((tea)) (and (hick))))

(check-equal? (rember* 'sauce '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))
              '(((tomato)) ((bean)) (and ((flying)))))

(check-false (lat? '(((tomato sauce))
                     ((bean) sauce)
                     (and ((flying)) sauce))))

(check-false (atom? (car '(((tomato sauce))
                           ((bean) sauce)
                           (and ((flying)) sauce)))))

(check-equal? (insertR* 'roast 'chuck '((how much (wood))
                                        could
                                        ((a (wood) chuck))
                                        (((chuck)))
                                        (if (a) ((wood chuck)))
                                        could chuck wood))
              '((how much (wood))
                could
                ((a (wood) chuck roast))
                (((chuck roast)))
                (if (a) ((wood chuck roast)))
                could chuck roast wood))

;;**********************************************************
;; The First Commandment (final version)
;;
;; When recurring on a list of atoms, lat, ask two questions
;; about it: (null? lat) and else.
;; When recurring on a number, n, ask two questions about
;; it: (zero? n) and else.
;; When recurring on a list of S-expressions, l, ask three
;; questions about it: (null? l, (atom? (car l)), and else.
;;**********************************************************

;;**********************************************************
;; The Fourth Commandment (final version)
;;
;; Always change at least one argument while recurring.
;; When recurring on a list of atoms, lat, use (cdr lat).
;; When recurring on a number, n, use (sub1 n). And when
;; recurring on a list of S-expressions, l, use (car l) and
;; (cdr l) if neither (null? l) nor (atom? (car l)) are true.
;;
;; It must be changed to be closer to termination. The
;; changing argument must be tested in the termination condition:
;;
;; when using cdr, test termination with null? and
;; when using sub1, test termination with zero?.
;;**********************************************************

(check-equal? (occur* 'banana '((banana)
                                (split ((((banana ice)))
                                        (cream (banana))
                                        sherbet))
                                (banana)
                                (bread)
                                (banana brandy)))
              5)

(check-equal? (subst* 'orange 'banana '((banana)
                                        (split ((((banana ice)))
                                                (cream (banana))
                                                sherbet))
                                        (banana)
                                        (bread)
                                        (banana brandy)))
              '((orange)
                (split ((((orange ice)))
                        (cream (orange))
                        sherbet))
                (orange)
                (bread)
                (orange brandy)))

(check-equal? (insertL* 'pecker 'chuck '((how much (wood))
                                         could
                                         ((a (wood) chuck))
                                         (((chuck)))
                                         (if (a) ((wood chuck)))
                                         could chuck wood))
              '((how much (wood))
                could
                ((a (wood) pecker chuck))
                (((pecker chuck)))
                (if (a) ((wood pecker chuck)))
                could pecker chuck wood))

(check-true (member* 'chips '((potato) (chips ((with) fish) (chips)))))

(check-equal? (leftmost '((potato (chips ((with) fish) (chips)))))
              'potato)

(check-equal? (leftmost '(((hot) (tuna (and))) cheese))
              'hot)

(check-false (and (atom? (car '((mozzarella mushroom) pizza)))
                  (eq? (car '((mozzarella mushroom) pizza)) 'pizza)))

(check-true (and (atom? (car '(pizza (mozzarella mushroom))))
                 (eq? (car '(pizza (mozzarella mushroom))) 'pizza)))

(check-true (eqlist? '(strawberry ice cream)
                     '(strawberry ice cream)))

(check-false (eqlist? '(strawberry ice cream)
                      '(strawberry cream ice)))

(check-false (eqlist? '(banana ((split)))
                      '((banana (split)))))

(check-false (eqlist? '(beef ((sausage)) (and (soda)))
                      '(beef ((salami)) (and (soda)))))

(check-true (eqlist? '(beef ((sausage)) (and (soda)))
                     '(beef ((sausage)) (and (soda)))))

;; Added test not in the book
(check-true (equal? '() '()))

;; Added test not in the book
(check-false (equal? 1 2))

;; Added test not in the book
(check-true (equal? 3 3))

;; Added test not in the book
(check-true (equal? '(a b (c d)) '(a b (c d))))

;; Added test not in the book
(check-true (equal? '(1 2 (3 c) ((words)) (more (((words)) a)))
                    '(1 2 (3 c) ((words)) (more (((words)) a)))))

;; Added test not in the book
(check-false (equal? '(1 2 (3 c) ((words)) (more (((words)) a)))
                     '(1 2 (3 c) ((words)) ((more) (((words)) a)))))

;;**********************************************************
;; The Sixth Commandment
;;
;; Simplify only after the function is correct.
;;**********************************************************