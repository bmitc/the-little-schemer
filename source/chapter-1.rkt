#lang racket

(require "the-little-schemer.rkt")

'atom

'turkey

'1942

'u

'*abc$

'(atom)

'(atom turkey or)

'((atom turkey) or)

'xyz

'(x y z)

'((x y) z)

'(how are you doing so far)

'(((how) are) ((you) (doing so)) far)

'()

'(() () () ())

(car '(a b c))

(car '((a b c) x y z))

;**********************************************************
;The Law of Car
;
;The primitive car is defined only for non-empty lists.
;**********************************************************

(car '(((hotdogs)) (and) (pickle) relish))

(car (car '(((hotdogs)) (and))))

(cdr '(a b c))

(cdr '((a b c) x y z))

(cdr '(hamburger))

(cdr '((x) t r))

;**********************************************************
;The Law of Cdr
;
;The primitive cdr is defined only for non-empty lists.
;The cdr of any non-empty list is always another list.
;**********************************************************

;;stuff

;**********************************************************
;The Law of Cons
;
;The primitive cons takes two arguments. The second argument
;to cons must be a list. The result is a list.
;**********************************************************

;;stuff

;**********************************************************
;The Law of Null
;
;The primitive null? is defined only for lists.
;**********************************************************

(atom? 'Harry)

(atom? '(Harry had a heap of apples))

(atom? (car '(Harry had a heap of apples)))

(atom? (cdr '(Harry had a heap of apples)))

(atom? (cdr '(Harry)))

(atom? (car (cdr '(swing low sweet cherry oat))))

(atom? (car (cdr '(swing (low sweet) cherry oat))))

(eq? 'Harry 'Harry)

(eq? 'margarine 'butter)

;**********************************************************
;The Law of Eq?
;
;The primitive eq? takes two arguments. Each must be
;a non-numeric atom.
;**********************************************************

(eq? (car '(Mary had a little lamb chop)) 'Mary)

(eq? (car '(beans beans we need jelly beans)) (car (cdr '(beans beans we need jelly beans))))