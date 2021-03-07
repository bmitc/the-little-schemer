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
#;(define member?
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
;; (Rewritten using insert-g in Chapter 8.)
#;(define insertR
    (lambda (new old lat)
      (cond
        [(null? lat) '()]
        [(eq? old (car lat)) (cons old
                                   (cons new (cdr lat)))]
        [else (cons (car lat)
                    (insertR new old (cdr lat)))])))

;; Inserts new before the first occurrence, if any, of old in lat, a list of atoms
;; (Rewritten using insert-g in Chapter 8.)
#;(define insertL
    (lambda (new old lat)
      (cond
        [(null? lat) '()]
        [(eq? old (car lat)) (cons new lat)] ; since (cons old (cdr lat)) = lat when old = (car lat)
        [else (cons (car lat)
                    (insertL new old (cdr lat)))])))

;; Replaces the first occurrence of old, if any, with new, in lat, a list of atoms
;; (Rewritten using insert-g in Chapter 8.)
#;(define subst
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
#;(define multirember
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
;; Chapter 6
;;**********************************************************

;; Determines if the arithmetic expression aexp contains only numbers besides +, ×, and ↑
#;(define numbered?
    (lambda (aexp)
      (cond
        [(atom? aexp) (number? aexp)]
        [(or (eq? (car (cdr aexp)) (quote +))
             (eq? (car (cdr aexp)) (quote ×))
             (eq? (car (cdr aexp)) (quote ↑))) (and (numbered? (car aexp)) (numbered? (car (cdr (cdr aexp)))))]
        [else #f])))
;; Note: the book assumes aexp is already an arithmetic expression such that we don't need to test that it is
;; as this implementation does, looking for +, ×, and ↑.

;; Determines if the arithmetic expression aexp contains only numbers besides +, ×, and ↑
(define numbered?
  (lambda (aexp)
    (cond
      [(atom? aexp) (number? aexp)]
      [else (and (numbered? (car aexp))
                 (numbered? (car (cdr (cdr aexp)))))])))

;; The book has two implementations of value for two different representations.
;; The value for the first representation is what is implemented here.

;; Evaluates the value of a numbered arithmetic expression
#;(define value
    (lambda (nexp)
      (cond
        [(atom? nexp) nexp] ; Really should ask number? and not just atom?
        [(eq? (car (cdr nexp)) (quote +)) (+ (value (car nexp)) (value (car (cdr (cdr nexp)))))]
        [(eq? (car (cdr nexp)) (quote ×)) (× (value (car nexp)) (value (car (cdr (cdr nexp)))))]
        [(eq? (car (cdr nexp)) (quote ↑)) (↑ (value (car nexp)) (value (car (cdr (cdr nexp)))))])))
;; Note: I'm not a fan of the book's implementation, which assumes ↑.

;; Gets the first sub-expression from an arithmetic expression
(define 1st-sub-exp
  (lambda (aexp)
    (car (cdr aexp))))

;; Gets the second sub-expression from an arithmetic expression
(define 2nd-sub-exp
  (lambda (aexp)
    (car (cdr (cdr aexp)))))

;; Gets the operator from an arithmetic expression
(define operator
  (lambda (aexp)
    (car aexp)))

;; Evaluates the value of a numbered arithmetic expression
;; (Rewritten using atom-to-function in  Chapter 8.)
#;(define value
    (lambda (nexp)
      (cond
        [(atom? nexp) nexp]
        [(eq? (operator nexp) (quote +)) (+ (value (1st-sub-exp nexp)) (value (2nd-sub-exp nexp)))]
        [(eq? (operator nexp) (quote ×)) (× (value (1st-sub-exp nexp)) (value (2nd-sub-exp nexp)))]
        [(eq? (operator nexp) (quote ↑)) (↑ (value (1st-sub-exp nexp)) (value (2nd-sub-exp nexp)))])))
;; Note: I'm not a fan of the book's implementation, which assumes ↑.


;;**********************************************************
;; Chapter 7
;;**********************************************************

;; Predicate for determining if a value is an element of the list of atoms or not
;; Redefined using equal? instead of eq?
(define member?
  (lambda (a lat)
    (cond
      [(null? lat) #f]
      [else (or (equal? (car lat) a)
                (member? a (cdr lat)))])))

;; Determines whether a list of atoms is a set or not
(define set?
  (lambda (lat)
    (cond
      [(null? lat) #t]
      [(member? (car lat) (cdr lat)) #f]
      [else (set? (cdr lat))])))

;; Makes a set out of a list of atoms
#;(define makeset
    (lambda (lat)
      (cond
        [(null? lat) '()]
        [(member? (car lat) (cdr lat)) (makeset (cdr lat))]
        [else (cons (car lat) (makeset (cdr lat)))])))

;; Removes all occurrences of a in lat, a list of atoms
;; Redefined using equal? instead of eq?
(define multirember
  (lambda (a lat)
    (cond
      [(null? lat) '()]
      [(equal? a (car lat)) (multirember a (cdr lat))]
      [else (cons (car lat)
                  (multirember a (cdr lat)))])))

;; Makes a set out of a list of atoms
(define makeset
  (lambda (lat)
    (cond
      [(null? lat) '()]
      [else (cons (car lat)
                  (makeset (multirember (car lat) (makeset (cdr lat)))))])))

;; Determines if set1 is a subset of set2 or not
(define subset?
  (lambda (set1 set2)
    (cond
      [(null? set1) #t]
      [else (and (member? (car set1) set2)
                 (subset? (cdr set1) set2))])))

;; Determines if the two sets are equal or not
(define eqset?
  (lambda (set1 set2)
    (and (subset? set1 set2)
         (subset? set2 set1))))

;; Determines if the two set intersect or not
(define intersect?
  (lambda (set1 set2)
    (cond
      [(null? set1) #t]
      [else (or (member? (car set1) set2)
                (intersect? (cdr set1) set2))])))

;; Returns the intersection of the two sets
(define intersect
  (lambda (set1 set2)
    (cond
      [(null? set1) '()]
      [(member? (car set1) set2) (cons (car set1)
                                       (intersect (cdr set1) set2))]
      [else (intersect (cdr set1) set2)])))

;; Returns the union of the two sets
(define union
  (lambda (set1 set2)
    (cond
      [(null? set1) set2]
      [(member? (car set1) set2) (union (cdr set1) set2)]
      [else (cons (car set1)
                  (union (cdr set1) set2))])))

;; Intersects all the sets in the list of sets
(define intersectall
  (lambda (l-set)
    (cond
      [(null? (cdr l-set)) (car l-set)]
      [else (intersect (car l-set) (intersectall (cdr l-set)))])))

;; Determines whether an S-expression is a list of only two S-expressions
(define a-pair?
  (lambda (x)
    (cond
      [(atom? x) #f]
      [(null? x) #f]
      [(null? (cdr x)) #f]
      [else (and (s-exp? (car x))
                 (s-exp? (car (cdr x)))
                 (null? (cdr (cdr x))))])))

;; Returns the first S-expression of a list or pair
(define first
  (lambda (p)
    (car p)))

;; Returns the second S-expression of a list or pair
(define second
  (lambda (p)
    (car (cdr p))))

;; Returns the third S-expression of a list
(define third
  (lambda (p)
    (car (cdr (cdr p)))))

;; Builds a pair out of the two S-expressions
(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 '()))))

;; Determines whether a relation is a function or not
(define fun?
  (lambda (rel)
    (set? (firsts rel))))

;; Reverses a pair
(define revpair
  (lambda (pair)
    (build (second pair)
           (first pair))))

;; Reverses a relation
(define revrel
  (lambda (rel)
    (cond
      [(null? rel) '()]
      [else (cons (revpair (car rel))
                  (revrel (cdr rel)))])))

;; Takes a list and returns a list of the second elements of each sublist
(define seconds
  (lambda (l)
    (cond
      [(null? l) '()]
      [else (cons (second (car l))
                  (seconds (cdr l)))])))

;; Determines whether a function is full or not
(define fullfun?
  (lambda (fun)
    (set? (seconds fun))))

;; Determines whether a function is one-to-one or not
(define one-to-one?
  (lambda (fun)
    (fun? (revrel fun))))


;;**********************************************************
;; Chapter 8
;;**********************************************************

;; Removes the first occurence of the atom a where (test? a) is true in the list of atoms
;; (Rewritten below as instructed by the book)
#;(define rember-f
    (lambda (test? a l)
      (cond
        [(null? l) '()]
        [(test? a (car l)) (cdr l)]
        [else (cons (car l)
                    (rember-f test? a (cdr l)))])))

;; Returns a function that tests equality against the atom a
(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? x a))))

;; A function to test if the argument is eq? to 'salad
(define eq?-salad (eq?-c 'salad))

;; Removes the first occurence of the atom a where (test? a) is true in the list of atoms
(define rember-f
  (lambda (test?)
    (lambda (a l)
      (cond
        [(null? l) '()]
        [(test? a (car l)) (cdr l)]
        [else (cons (car l)
                    ((rember-f test?) a (cdr l)))]))))

;; Removes the first occurence of the atom a, using eq?, in the list of atoms
(define rember-eq? (rember-f eq?))

;; Inserts new before the first occurrence, if any, of old in lat, a list of atoms
(define insertL-f
  (lambda (test?)
    (lambda (new old lat)
      (cond
        [(null? lat) '()]
        [(test? old (car lat)) (cons new lat)] ; since (cons old (cdr lat)) = lat when old = (car lat)
        [else (cons (car lat)
                    ((insertL-f test?) new old (cdr lat)))]))))

;; Inserts new after the first occurrence, if any, of old in lat, a list of atoms
(define insertR-f
  (lambda (test?)
    (lambda (new old lat)
      (cond
        [(null? lat) '()]
        [(test? old (car lat)) (cons old
                                     (cons new (cdr lat)))]
        [else (cons (car lat)
                    ((insertR-f test?) new old (cdr lat)))]))))

;; Conses new onto the cons of old and l
(define seqL
  (lambda (new old l)
    (cons new (cons old l))))

;; Conses old onto the cons of new and l
(define seqR
  (lambda (new old l)
    (cons old (cons new l))))

(define insert-g
  (lambda (seq)
    (lambda  (new old l)
      (cond
        [(null? l) '()]
        [(eq? old (car l)) (seq new old (cdr l))]
        [else (cons (car l)
                    ((insert-g seq) new old (cdr l)))]))))

;; Inserts new before the first occurrence, if any, of old in lat, a list of atoms
(define insertL (insert-g seqL))

;; Inserts new after the first occurrence, if any, of old in lat, a list of atoms
(define insertR (insert-g seqR))

(define seqS
  (lambda (new old l)
    (cons new l)))

;; Replaces the first occurrence of old, if any, with new, in lat, a list of atoms
(define subst (insert-g seqS))

(define seqrem
  (lambda (new old l)
    l))

(define yyy
  (lambda (a l)
    ((insert-g seqrem) #f a l)))

;; Takes '+, '×, and '↑ and returns +, ×, and ↑, respectively
(define atom-to-function
  (lambda (x)
    (cond
      [(eq? x (quote +)) +]
      [(eq? x (quote ×)) ×]
      [else ↑])))

;; Evaluates the value of a numbered arithmetic expression
(define value
  (lambda (nexp)
    (cond
      [(atom? nexp) nexp]
      [else ((atom-to-function (operator nexp))
             (value (1st-sub-exp nexp))
             (value (2nd-sub-exp nexp)))])))

;; Removes all occurrences of a, using test?, in lat, a list of atoms
(define multirember-f
  (lambda (test?)
    (lambda (a lat)
      (cond
        [(null? lat) '()]
        [(test? a (car lat)) ((multirember-f test?) a (cdr lat))]
        [else (cons (car lat)
                    ((multirember-f test?) a (cdr lat)))]))))

;; Removes all occurrences of a, using eq?, in lat, a list of atoms
(define multirember-eq? (multirember-f eq?))

;; A function to test if the argument is eq? to 'tuna
(define eq?-tuna (eq?-c (quote tuna)))

;; Removes all occurences that pass the test test? in lat, a list of atoms
(define multiremberT
  (lambda (test? lat)
    (cond [(null? lat) '()]
          [(test? (car lat)) (multiremberT test? (cdr lat))]
          [else (cons (car lat)
                      (multiremberT test? (cdr lat)))])))

;; Looks at every atom of lat, a list of atoms, to see whether
;; the atom is equal, using eq?, to a. Those atoms that are not
;; equal are collected in one list ls1. The atoms that are equal
;; are collected in a second list ls2. Finally, it determines the
;; value of (f ls1 ls2).
(define multirember&co
  (lambda (a lat col)
    (cond [(null? lat) (col '() '())]
          [(eq? (car lat) a) (multirember&co a
                                             (cdr lat)
                                             (lambda (newlat seen)
                                               (col newlat (cons (car lat) seen))))]
          [else (multirember&co a
                                (cdr lat)
                                (lambda (newlat seen)
                                  (col (cons (car lat) newlat) seen)))])))

(define a-friend
  (lambda (x y)
    (null? y)))

(define new-friend
  (lambda (newlat seen)
    (a-friend newlat
              (cons (car 'tuna) seen))))

(define latest-friend
  (lambda (newlat seen)
    (a-friend (cons 'and newlat)
              seen)))

(define last-friend
  (lambda (x y)
    (length x)))

;; Inserts new to the left of oldL and to the right of oldR in lat, a list of atoms,
;; for every occurrence of oldL and oldR
(define multiinsertLR
  (lambda (new oldL oldR lat)
    (cond [(null? lat) '()]
          [(eq? (car lat) oldL) (cons new
                                      (cons oldL
                                            (multiinsertLR new oldL oldR (cdr lat))))]
          [(eq? (car lat) oldR) (cons oldR
                                      (cons new
                                            (multiinsertLR new oldL oldR (cdr lat))))]
          [else (cons (car lat)
                      (multiinsertLR new oldL oldR (cdr lat)))])))

(define multiinsertLR&co
  (lambda (new oldL oldR lat col)
    (cond [(null? lat) (col '() 0 0)]
          [(eq? (car lat) oldL)
           (multiinsertLR&co new oldL oldR (cdr lat)
                             (lambda (newlat L R)
                               (col (cons new
                                          (cons oldL newlat))
                                    (add1 L) R)))]
          [(eq? (car lat) oldR)
           (multiinsertLR&co new oldL oldR (cdr lat)
                             (lambda (newlat L R)
                               (col (cons oldR
                                          (cons new newlat))
                                    L (add1 R))))]
          [else
           (multiinsertLR&co new oldL oldR (cdr lat)
                             (lambda (newlat L R)
                               (col (cons (car lat) newlat) L R)))])))

;; Determines whether the number is even or not
(define even?
  (lambda (n)
    (= (× (÷ n 2) 2) n)))

;; Removes all odd numbers from a list of nested lists
(define evens-only*
  (lambda (l)
    (cond [(null? l) '()]
          [(atom? (car l))
           (cond [(even? (car l)) (cons (car l)
                                        (evens-only* (cdr l)))]
                 [else (evens-only* (cdr l))])]
          [else (cons (evens-only* (car l))
                      (evens-only* (cdr l)))])))

(define evens-only*&co
  (lambda (l col)
    (cond [(null? l) (col '() 1 0)]
          [(atom? (car l))
           (cond [(even? (car l))
                  (evens-only*&co (cdr l)
                                  (lambda (newl p s)
                                    (col (cons (car l) newl)
                                         (× (car l) p) s)))]
                 [else (evens-only*&co (cdr l)
                                       (lambda (newl p s)
                                         (col newl
                                              p (+ (car l) s))))])]
          [else (evens-only*&co (car l)
                                (lambda (al ap as)
                                  (evens-only*&co (cdr l)
                                                  (lambda (dl dp ds)
                                                    (col (cons al dl)
                                                         (× ap dp)
                                                         (+ as ds))))))])))

(define the-last-friend
  (lambda (newl product sum)
    (cons sum
          (cons product newl))))


;;**********************************************************
;; Chapter 9
;;**********************************************************

(define looking
  (lambda (a lat)
    (keep-looking a (pick 1 lat) lat)))

(define keep-looking
  (lambda (a sorn lat)
    (cond [(number? sorn) (keep-looking a (pick sorn lat) lat)]
          [else (eq? sorn a)])))
;; Note: a sorn is a symbol or a number

(define eternity
  (lambda (x)
    (eternity x)))

;; Takes a pair whose first component is a pair and builds a pair by
;; shifting the second part of the first component into the second
;; component
(define shift
  (lambda (pair)
    (build (first (first pair))
           (build (second (first pair))
                  (second pair)))))

(define align
  (lambda (pora)
    (cond [(atom? pora) pora]
          [(a-pair? (first pora)) (align (shift pora))]
          [else (build (first pora)
                       (align (second pora)))])))

(define length*
  (lambda (pora)
    (cond [(atom? pora) 1]
          [else (+ (length* (first pora))
                   (length* (second pora)))])))

(define weight*
  (lambda (pora)
    (cond [(atom? pora) 1]
          [else (+ (× (weight* (first pora)) 2)
                   (weight* (second pora)))])))

(define shuffle
  (lambda (pora)
    (cond [(atom? pora) pora]
          [(a-pair? (first pora)) (shuffle (revpair pora))]
          [else (build (first pora)
                       (shuffle (second pora)))])))

(define C
  (lambda (n)
    (cond [(one? n) 1]
          [else (cond [(even? n) (C (÷ n 2))]
                      [else (C (add1 (× 3 n)))])])))

(define A
  (lambda (n m)
    (cond [(zero? n) (add1 m)]
          [(zero? m) (A (sub1 n) 1)]
          [else (A (sub1 n)
                   (A n (sub1 m)))])))

(define Y
  (lambda (le)
    ((lambda (f) (f f))
     (lambda (f)
       (le (lambda (x) ((f f) x)))))))


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