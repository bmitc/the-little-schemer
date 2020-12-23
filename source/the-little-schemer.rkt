#lang racket

;; Used to redefine Racket functions in terms of the original functions
(require (rename-in racket
                    [cons racket-cons]
                    [null? racket-null?]
                    [eq? racket-eq?]
                    [+ racket+]
                    [- racket-]
                    [number? racket-number?]))

(provide (all-defined-out))


;;**********************************************************
;; Preface
;;**********************************************************

;; [Primitive]
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

;; [Primitive]
;; Predicate for determining if a value is an S-expression or not
(define (s-exp? x)
  (or (atom? x) (list? x)))

;; [Primitive]
;; Provide a cons as defined in the book such that it requires a list as
;; the second argument. This is enforced using Racket's contract system.
;; Racket's cons works on any values, as mentioned in the footnote on page 8.
(define/contract (cons s l)
  (-> any/c list? list?)
  (racket-cons s l))

;; [Primitive]
;; Provide a cons as defined in the book such that it requires a list as
;; the argument. See the footnote on page 10.
(define/contract (null? l)
  (-> list? boolean?)
  (racket-null? l))

;; [Primitive]
;; Provide an eq? as defined in the book such that it requires a non-numeric
;; atom for each argument. See the footnotes on page 12.
(define/contract (eq? a b)
  (-> (and/c atom? (not/c racket-number?)) (and/c atom? (not/c racket-number?)) boolean?)
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
;; (Rewritten below in the Chapter 5 section using equal? as instructed by the book)
#;(define rember
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
                                 (cons new
                                       (multiinsertR new old (cdr lat))))]
      [else (cons (car lat)
                  (multiinsertR new old (cdr lat)))])))

;; Inserts new before all occurrences of old in lat, a list of atoms
(define multiinsertL
  (lambda (new old lat)
    (cond
      [(null? lat) '()]
      [(eq? old (car lat)) (cons new
                                 (cons (car lat)
                                       (multiinsertL new old (cdr lat))))] ; since (cons old (cdr lat)) = lat when old = (car lat)
      [else (cons (car lat)
                  (multiinsertL new old (cdr lat)))])))

;; Replaces all occurrences of old with new in lat, a list of atoms
(define multisubst
  (lambda (new old lat)
    (cond
      [(null? lat) '()]
      [(eq? old (car lat)) (cons new (multisubst new old (cdr lat)))]
      [else (cons (car lat)
                  (multisubst new old (cdr lat)))])))


;;**********************************************************
;; Chapter 4
;;**********************************************************

;; Adds 1 to the number n
(define add1
  (lambda (n)
    (racket+ n 1)))

;; Subtracts 1 from the number n
(define sub1
  (lambda (n)
    (racket- n 1)))

;; Add two non-negative integer numbers
(define +
  (lambda (n m)
    (cond
      [(zero? m) n]
      [else (+ (add1 n) (sub1 m))])))
; I think this is more clear by adding 1 to n rather than the result

;; Subtract two non-negative integer numbers
(define -
  (lambda (n m)
    (cond
      [(zero? m) n]
      [else (- (sub1 n) (sub1 m))])))
; I think this is more clear by subtracting 1 from n rather than the result

;; [Primitive]
;; Predicate for determining if a list is a list of non-negative numbers or not
(define (tup? x)
  (andmap exact-nonnegative-integer? x))

;; Adds all the numbers in a tuple together
(define addtup
  (lambda (tup)
    (cond
      [(null? tup) 0]
      [else (+ (car tup) (addtup (cdr tup)))])))

;; Multiples two non-negative integer numbers
(define ×
  (lambda (n m)
    (cond
      [(zero? m) 0]
      [else (+ n (× n (sub1 m)))])))

;; Adds the elements of two tuples together
(define tup+
  (lambda (tup1 tup2)
    (cond
      [(null? tup1) tup2]
      [(null? tup2) tup1]
      [else (cons (+ (car tup1) (car tup2))
                  (tup+ (cdr tup1) (cdr tup2)))])))

;; Determines if n > m
(define >
  (lambda (n m)
    (cond
      [(zero? n) #f]
      [(zero? m) #t]
      [else (> (sub1 n) (sub1 m))])))

;; Determines if n < m
(define <
  (lambda (n m)
    (cond
      [(zero? m) #f]
      [(zero? n) #t]
      [else (< (sub1 n) (sub1 m))])))

;; Determines if two numbers are equal or not
(define =
  (lambda (n m)
    (cond
      [(< n m) #f]
      [(> n m) #f]
      [else #t])))

;; Computes n to the power of m
(define ↑
  (lambda (n m)
    (cond
      [(zero? m) 1]
      [else (× n (↑ n (sub1 m)))])))

;; Computes how many times m divides n
(define ÷
  (lambda (n m)
    (cond
      [(< n m) 0]
      [else (add1 (÷ (- n m) m))])))

;; Returns the length of lat, a list of atoms
(define length
  (lambda (lat)
    (cond
      [(null? lat) 0]
      [else (add1 (length (cdr lat)))])))

;; Picks the nth element of lat, a list of atoms
(define pick
  (lambda (n lat)
    (cond
      [(zero? (sub1 n)) (car lat)]
      [else (pick (sub1 n) (cdr lat))])))

;; Removes the nth element from lat, a list of atoms
(define rempick
  (lambda (n lat)
    (cond
      [(one? n) (cdr lat)]
      [else (cons (car lat)
                  (rempick (sub1 n) (cdr lat)))])))

;; [Primitive]
;; Predicate for determining if a value is a numeric atom, i.e. a non-negative integer, or not
(define (number? x)
  (exact-nonnegative-integer? x))

;; Removes all numbers from lat, a list of atoms
(define no-nums
  (lambda (lat)
    (cond
      [(null? lat) '()]
      [(number? (car lat)) (no-nums (cdr lat))]
      [else (cons (car lat)
                  (no-nums (cdr lat)))])))

;; Returns a tuple made out of all the numbers in lat, a list of atoms
(define all-nums
  (lambda (lat)
    (cond
      [(null? lat) '()]
      [(number? (car lat)) (cons (car lat) (all-nums (cdr lat)))]
      [else (all-nums (cdr lat))])))

;; Predicate that determines if a1 and a2 are the same number or same atom
(define eqan?
  (lambda (a1 a2)
    (cond
      [(and (number? a1) (number? a2)) (= a1 a2)]
      [(or (number? a1) (number? a2)) #f]
      [else (eq? a1 a2)])))

;; Counts the number of times the atom a occurs in lat, a list of atoms
(define occur
  (lambda (a lat)
    (cond
      [(null? lat) 0]
      [(eq? a (car lat)) (add1 (occur a (cdr lat)))]
      [else (occur a (cdr lat))])))

;; Predicate that determines if n is 1 or not
(define one?
  (lambda (n)
    (= n 1)))


;;**********************************************************
;; Chapter 5
;;**********************************************************

;; Removes the atom a everywhere it occurs the list l
(define rember*
  (lambda (a l)
    (cond
      [(null? l) '()]
      [(atom? (car l))
       (cond
         [(eq? a (car l)) (rember* a (cdr l))]
         [else (cons (car l) (rember* a (cdr l)))])]
      [else (cons (rember* a (car l)) (rember* a (cdr l)))])))

;; Inserts new to the right of where old appears everywhere in the list l
(define insertR*
  (lambda (new old l)
    (cond
      [(null? l) '()]
      [(atom? (car l))
       (cond
         [(eq? old (car l)) (cons old
                                  (cons new
                                        (insertR* new old (cdr l))))]
         [else (cons (car l) (insertR* new old (cdr l)))])]
      [else (cons (insertR* new old (car l))
                  (insertR* new old (cdr l)))])))

;; Counts how many times the atom a occurs in the list l
(define occur*
  (lambda (a l)
    (cond
      [(null? l) 0]
      [(atom? (car l))
       (cond
         [(eq? a (car l)) (add1 (occur* a (cdr l)))]
         [else (occur* a (cdr l))])]
      [else (+ (occur* a (car l))
               (occur* a (cdr l)))])))

;; Replaces old with new everywhere old appears in the list l
(define subst*
  (lambda (new old l)
    (cond
      [(null? l) '()]
      [(atom? (car l))
       (cond
         [(eq? old (car l)) (cons new
                                  (subst* new old (cdr l)))]
         [else (cons (car l)
                     (subst* new old (cdr l)))])]
      [else (cons (subst* new old (car l))
                  (subst* new old (cdr l)))])))

;; Inserts new to the left of where old appears everywhere in the list l
(define insertL*
  (lambda (new old l)
    (cond
      [(null? l) '()]
      [(atom? (car l))
       (cond
         [(eq? old (car l)) (cons new
                                  (cons old
                                        (insertL* new old (cdr l))))]
         [else (cons (car l) (insertL* new old (cdr l)))])]
      [else (cons (insertL* new old (car l))
                  (insertL* new old (cdr l)))])))

;; Determines if the atom is found in the list l
(define member*
  (lambda (a l)
    (cond
      [(null? l) #f]
      [(atom? (car l)) (or (eq? a (car l))
                           (member* a (cdr l)))]
      [else (or (member* a (car l))
                (member* a (cdr l)))])))

;; Returns the leftmost atom in a non-empty list
(define leftmost
  (lambda (l)
    (cond
      [(atom? (car l)) (car l)]
      [else (leftmost (car l))])))

;; Determines if the two lists are equal or not
;; (Rewritten below using equal? as instructed by the book)
#;(define eqlist?
  (lambda (l1 l2)
    (cond
      [(and (null? l1) (null? l2)) #t]
      [(or (null? l1) (null? l2)) #f]
      [(and (atom? (car l1)) (atom? (car l2))) (and (eqan? (car l1) (car l2))
                                                    (eqlist? (cdr l1) (cdr l2)))]
      [(or (atom? (car l1)) (atom? (car l2))) #f]
      [else (and (eqlist? (car l1) (car l2))
                 (eqlist? (cdr l1) (cdr l2)))])))

;; Determines if the two S-expressions are equal or not
(define equal?
  (lambda (s1 s2)
    (cond
      [(and (atom? s1) (atom? s2)) (eqan? s1 s2)]
      [(or (atom? s1) (atom? s2)) #f]
      [else (eqlist? s1 s2)])))

;; Determines if the two lists are equal or not
(define eqlist?
  (lambda (l1 l2)
    (cond
      [(and (null? l1) (null? l2)) #t]
      [(or (null? l1) (null? l2)) #f]
      [else (and (equal? (car l1) (car l2))
                 (equal? (cdr l1) (cdr l2)))])))

;; Removes the first occurence of the atom, if possible, in the list of atoms
(define rember
  (lambda (s l)
    (cond
      [(null? l) '()]
      [(equal? s (car l)) (cdr l)]
      [else (cons (car l)
                  (rember s (cdr l)))])))


;;**********************************************************
;; Tests
;;**********************************************************

(module+ test
  (require rackunit)

  ;;********************************************************
  ;; Primitives
  ;;********************************************************

  (check-false (atom? (quote ())))

  (check-false (atom? '()))

  (check-true (s-exp? '()))

  (check-true (s-exp? 'symbol))

  (check-equal? (cons 'a '()) '(a))

  (check-equal? (cons 'a '(b)) '(a b))

  (check-exn exn:fail? (thunk(cons 'a 'b)))

  (check-pred null? '())

  (check-pred null? (quote ()))

  (check-pred null? empty)

  (check-exn exn:fail? (thunk (null? 'a)))
  )