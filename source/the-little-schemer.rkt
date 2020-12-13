#lang racket

;; Used to redefine Racket functions in terms of the original functions
(require (rename-in racket
                    [cons racket-cons]
                    [null? racket-null?]
                    [eq? racket-eq?]))

(provide (all-defined-out))


;;**********************************************************
;; Preface
;;**********************************************************

;; Predicate for determining if a value is an atom or not.
;; The definition of this is found in the preface.
(define (atom? x)
  (and (not (pair? x)) (not (racket-null? x))))
;; Note that we need to use the racket-null? and not our newly contracted null?
;; becuase x may be an atom, which racket-null? supports and null? (as defined
;; in the book and thus our contracted version) does not.


;;**********************************************************
;; Chapter 1
;;**********************************************************

;; Predicate for determining if a value is an S-expression or not
(define (s-exp? x)
  (or (atom? x) (list? x)))

;; Provide a cons as defined in the book such that it requires a list as
;; the second argument. This is enforced using Racket's contract system.
;; Racket's cons works on any values, as mentioned in the footnote on page 8.
(define/contract (cons s l)
  (-> any/c list? list?)
  (racket-cons s l))

;; Provide a cons as defined in the book such that it requires a list as
;; the argument. See the footnote on page 10.
(define/contract (null? l)
  (-> list? boolean?)
  (racket-null? l))

;; Provide an eq? as defined in the book such that it requires a non-numeric
;; atom for each argument. See the footnotes on page 12.
(define/contract (eq? a b)
  (-> (and/c atom? (not/c number?)) (and/c atom? (not/c number?)) boolean?)
  (racket-eq? a b))


;;**********************************************************
;; Chapter 2
;;**********************************************************

;; Predicate for determining if a value is a list of atoms or not
(define lat?
  (lambda (l)
    (cond
      [(null? l) #t]
      [(atom? (car l)) (lat? (cdr l))]
      [else #f])))

;; Predicate for determining if a value is an element of the list of atoms or not
(define member?
  (lambda (a lat)
    (cond
      [(null? lat) #f]
      [else (or (eq? (car lat) a)
                (member? a (cdr lat)))])))


;;**********************************************************
;; Chapter 3
;;**********************************************************

;; Removes the first occurence of the atom, if possible, in the list of atoms
(define rember
  (lambda (a lat)
    (cond
      [(null? lat) '()]
      [(eq? a (car lat)) (cdr lat)]
      [else (cons (car lat)
                  (rember a (cdr lat)))])))

;; Takes a list and returns a list of the first elements of each sublist
(define firsts
  (lambda (l)
    (cond
      [(null? l) '()]
      [else (cons (car (car l))
                  (firsts (cdr l)))])))

;; Inserts new after the first occurrence, if any, of old in lat, a list of atoms
(define insertR
  (lambda (new old lat)
    (cond
      [(null? lat) '()]
      [(eq? old (car lat)) (cons old
                                 (cons new (cdr lat)))]
      [else (cons (car lat)
                  (insertR new old (cdr lat)))])))

;; Inserts new before the first occurrence, if any, of old in lat, a list of atoms
(define insertL
  (lambda (new old lat)
    (cond
      [(null? lat) '()]
      [(eq? old (car lat)) (cons new lat)] ; since (cons old (cdr lat)) = lat when old = (car lat)
      [else (cons (car lat)
                  (insertL new old (cdr lat)))])))

;; Replaces the first occurrence of old, if any, with new, in lat, a list of atoms
(define subst
  (lambda (new old lat)
    (cond
      [(null? lat) '()]
      [(eq? old (car lat)) (cons new (cdr lat))]
      [else (cons (car lat)
                  (subst new old (cdr lat)))])))

;; Replaces the first occurence of o1 or o2, if any, in lat, a list of atoms
(define subst2
  (lambda (new o1 o2 lat)
    (cond
      [(null? lat) '()]
      [(or (eq? o1 (car lat)) (eq? o2 (car lat))) (cons new (cdr lat))]
      [else (cons (car lat)
                  (subst2 new o1 o2 (cdr lat)))])))

;; Removes all occurrences of a in lat, a list of atoms
(define multirember
  (lambda (a lat)
    (cond
      [(null? lat) '()]
      [(eq? a (car lat)) (multirember a (cdr lat))]
      [else (cons (car lat)
                  (multirember a (cdr lat)))])))

;; Inserts new after all occurrences of old in lat, a list of atoms
(define multiinsertR
  (lambda (new old lat)
    (cond
      [(null? lat) '()]
      [(eq? old (car lat)) (cons old
                                 (cons new (multiinsertR (cdr lat))))]
      [else (cons (car lat)
                  (multiinsertR new old (cdr lat)))])))

;; Inserts new before all occurrences of old in lat, a list of atoms
(define multiinsertL
  (lambda (new old lat)
    (cond
      [(null? lat) '()]
      [(eq? old (car lat)) (cons new
                                 (cons (car lat) (multiinsertL (cdr lat))))] ; since (cons old (cdr lat)) = lat when old = (car lat)
      [else (cons (car lat)
                  (multiinsertL new old (cdr lat)))])))

;; Replaces all occurrences of old with new in lat, a list of atoms
(define multisubst
  (lambda (new old lat)
    (cond
      [(null? lat) '()]
      [(eq? old (car lat)) (cons new (multisubst (cdr lat)))]
      [else (cons (car lat)
                  (multisubst new old (cdr lat)))])))


;;**********************************************************
;; Tests
;;**********************************************************

(module+ test
  (require rackunit)

  (check-false (atom? (quote ())))

  (check-false (atom? '()))

  (check-equal? (cons 'a '()) '(a))

  (check-equal? (cons 'a '(b)) '(a b))

  (check-exn exn:fail? (thunk(cons 'a 'b)))

  (check-pred null? '())

  (check-pred null? (quote ()))

  (check-pred null? empty)

  (check-exn exn:fail? (thunk (null? 'a)))
  )