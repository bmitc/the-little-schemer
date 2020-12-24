;;**********************************************************
;; Chapter 7: Friends and Relations
;;**********************************************************

#lang racket

(require "the-little-schemer.rkt"
         rackunit)

(check-false (set? '(apple peaches apple plum)))

(check-true (set? '(apples peaches pears plums)))

(check-true (set? '()))

(check-false (set? '(apple 3 pear 4 9 apple 3 4)))

(check-equal? (makeset '(apple peach pear peach plum apple lemon peach))
              '(apple peach pear plum lemon))

(check-equal? (makeset '(apple 3 pear 4 9 apple 3 4))
              '(apple 3 pear 4 9))

(check-false (subset? '(4 pounds of horseradish)
                      '(four pounds chicken and 5 pounds horseradish)))

(check-true (eqset? '(6 large chickens with wings)
                    '(6 chickens with large wings)))

(check-true (intersect? '(stewed tomatoes and macaroni)
                        '(macaroni and cheese)))

(check-equal? (intersect '(stewed tomatoes and macaroni)
                         '(macaroni and cheese))
              '(and macaroni))

(check-equal? (union '(stewed tomatoes and macaroni casserole)
                     '(macaroni and cheese))
              '(stewed tomatoes casserole macaroni and cheese))

(check-equal? (intersectall '((a b c) (c a d e) (e f g h a b)))
              '(a))

(check-equal? (intersectall '((6 pears and)
                              (3 peaches and 6 peppers)
                              (8 pears and 6 plums)
                              (and 6 prines with some apples)))
              '(6 and))

(check-true (a-pair? '(pear pear)))

(check-true (a-pair? '(3 7)))

(check-true (a-pair? '((2) (pair))))

(check-true (a-pair? '(full (house))))

;; Added test not in the book
(check-false (a-pair? '()))

;; Added test not in the book
(check-false (a-pair? 'a))

;; Added test not in the book
(check-false (a-pair? '(1 2 3)))

(check-false (fun? '((4 3) (4 2) (7 6) (6 2) (3 4))))

(check-true (fun? '((8 3) (4 2) (7 6) (6 2) (3 4))))

(check-false (fun? '((d 4) (b 0) (b 9) (e 5) (g 4))))

(check-equal? (revrel '((8 a) (pumpkin pie) (got sick)))
              '((a 8) (pie pumpkin) (sick got)))

(check-false (fullfun? '((8 3) (4 2) (7 6) (6 2) (3 4))))

(check-true (fullfun? '((8 3) (4 8) (7 6) (6 2) (3 4))))

(check-false (fullfun? '((grape raisin)
                         (plum prune)
                         (stewed prune))))

(check-true (fullfun? '((grape raisin)
                        (plum prune)
                        (stewed grape))))

(check-true (one-to-one? '((chocolate chip) (doughy cookie))))