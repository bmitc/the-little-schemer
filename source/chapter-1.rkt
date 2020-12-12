;;**********************************************************
;; Chapter 1: Toys
;;**********************************************************

#lang racket

(require "the-little-schemer.rkt"
         rackunit)

(check-true (atom? 'atom))

(check-true (atom? 'turkey))

(check-true (atom? 1942))

(check-true (atom? 'u))

(check-true (atom?  '*abc$))

(check-true (list? '(atom)))

(check-true (list? '(atom turkey or)))

(check-exn exn:fail? (thunk (atom? '(atom turkey) 'or)))

(check-true (list? '((atom turkey) or)))

(check-true (s-exp? 'xyz))

(check-true (s-exp? '(x y z)))

(check-true (s-exp? '((x y) z)))

(check-true (list? '(how are you doing so far)))

(check-equal? (length '(how are you doing so far)) 6)

(check-true (list? '(((how) are) ((you) (doing so)) far)))

(check-equal? (length '(((how) are) ((you) (doing so)) far)) 3)

(check-true (list? '()))

(check-false (atom? '()))

(check-true (list? '(() () () ())))

(check-equal? (car '(a b c)) 'a)

(check-equal? (car '((a b c) x y z)) '(a b c))

(check-exn exn:fail? (thunk (car 'hotdog)))

(check-exn exn:fail? (thunk (car '())))

;;**********************************************************
;; The Law of Car
;;
;; The primitive car is defined only for non-empty lists.
;;**********************************************************

(check-equal? (car '(((hotdogs)) (and) (pickle) relish))
              '((hotdogs)))

(check-equal? (car (car '(((hotdogs)) (and))))
              '(hotdogs))

(check-equal? (cdr '(a b c))
              '(b c))

(check-equal? (cdr '((a b c) x y z))
              '(x y z))

(check-equal? (cdr '(hamburger))
              '())

(check-equal? (cdr '((x) t r))
              '(t r))

(check-exn exn:fail? (thunk (cdr 'hotdogs)))

(check-exn exn:fail? (thunk (cdr '())))

;;**********************************************************
;; The Law of Cdr
;;
;; The primitive cdr is defined only for non-empty lists.
;; The cdr of any non-empty list is always another list.
;;**********************************************************

(check-equal? (car (cdr '((b) (x y) ((c)))))
              '(x y))

(check-equal? (cdr (cdr '((b) (x y) ((c)))))
              '(((c))))

(check-exn exn:fail? (thunk (cdr (car '(a (b (c)) d)))))

(check-equal? (cons 'peanut '(butter and jelly))
              '(peanut butter and jelly))

(check-equal? (cons '(banana and) '(peanut butter and jelly))
              '((banana and) peanut butter and jelly))

(check-equal? (cons '((help) this) '(is very ((hard) to learn)))
              '(((help) this) is very ((hard) to learn)))

(check-equal? (cons '(a b (c)) '())
              '((a b (c))))

(check-equal? (cons 'a '())
              '(a))

(check-exn exn:fail? (thunk (cons '((a b c)) 'b)))
;; As alluded to in footnote 1 on page 8, in Racket's cons accepts
;; any value in both arguments and does not require the second one
;; to be a list. cons has been redefined in the-little-schemer module
;; such that it does require a list to follow the book's definition
;; of cons.

(check-exn exn:fail? (thunk (cons 'a 'b)))
;; Similar to the previous test.

;;**********************************************************
;; The Law of Cons
;;
;; The primitive cons takes two arguments. The second argument
;; to cons must be a list. The result is a list.
;**********************************************************

(check-equal? (cons 'a (car '((b) c d)))
              '(a b))

(check-equal? (cons 'a (cdr '((b) c d)))
              '(a c d))

(check-true (null? '()))

(check-true (null? (quote ())))

(check-false (null? '(a b c)))

(check-exn exn:fail? (thunk (null? 'spaghetti)))

;;**********************************************************
;; The Law of Null
;;
;; The primitive null? is defined only for lists.
;;**********************************************************

(check-true (atom? 'Harry))

(check-false (atom? '(Harry had a heap of apples)))

(check-true (atom? (car '(Harry had a heap of apples))))

(check-false (atom? (cdr '(Harry had a heap of apples))))

(check-false (atom? (cdr '(Harry))))

(check-true (atom? (car (cdr '(swing low sweet cherry oat)))))

(check-false (atom? (car (cdr '(swing (low sweet) cherry oat)))))

(check-true (eq? 'Harry 'Harry))

(check-false (eq? 'margarine 'butter))

(check-exn exn:fail? (thunk (eq? '() '(strawberry))))
;; eq? has been redefined to only take in non-numeric atoms

(check-exn exn:fail? (thunk (eq? 6 7)))

;;**********************************************************
;; The Law of Eq?
;;
;; The primitive eq? takes two arguments. Each must be
;; a non-numeric atom.
;**********************************************************

(check-true (eq? (car '(Mary had a little lamb chop)) 'Mary))

(check-exn exn:fail? (thunk (eq? (cdr '(soured milk)) 'milk)))

(check-true (eq? (car '(beans beans we need jelly beans))
                 (car (cdr '(beans beans we need jelly beans)))))