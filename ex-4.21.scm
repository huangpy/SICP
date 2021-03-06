;;; Exercise 4.21.  Amazingly, Louis's intuition in exercise 4.20 is correct.
;;; It is indeed possible to specify recursive procedures without using letrec
;;; (or even define), although the method for accomplishing this is much more
;;; subtle than Louis imagined. The following expression computes 10 factorial
;;; by applying a recursive factorial procedure: [27]
;;;
;;;     ((lambda (n)
;;;        ((lambda (fact)
;;;           (fact fact n))
;;;         (lambda (ft k)
;;;           (if (= k 1)
;;;               1
;;;               (* k (ft ft (- k 1)))))))
;;;      10)




;;; a. Check (by evaluating the expression) that this really does compute
;;; factorials. Devise an analogous expression for computing Fibonacci numbers.

(print ((lambda (n)
          ((lambda (fact)
             (fact fact n))
           (lambda (ft k)
             (if (= k 1)
               1
               (* k (ft ft (- k 1)))))))
        10))
;==> 3628800

(define fibonacci
  (lambda (n)
    ((lambda (f)
       (f f n))
     (lambda (f k)
       (cond ((= k 1) 1)
             ((= k 2) 1)
             (else (+ (f f (- k 1)) (f f (- k 2)))))))))

(print (fibonacci 1))  ;==>  1
(print (fibonacci 2))  ;==>  1
(print (fibonacci 3))  ;==>  2
(print (fibonacci 4))  ;==>  3
(print (fibonacci 5))  ;==>  5
(print (fibonacci 6))  ;==>  8
(print (fibonacci 7))  ;==> 13




;;; b. Consider the following procedure, which includes mutually recursive
;;; internal definitions:
;;;
;;;     (define (f x)
;;;       (define (even? n)
;;;         (if (= n 0)
;;;             true
;;;             (odd? (- n 1))))
;;;       (define (odd? n)
;;;         (if (= n 0)
;;;             false
;;;             (even? (- n 1))))
;;;       (even? x))
;;;
;;; Fill in the missing expressions to complete an alternative definition of f,
;;; which uses neither internal definitions nor letrec:
;;;
;;;     (define (f x)
;;;       ((lambda (even? odd?)
;;;          (even? even? odd? x))
;;;        (lambda (ev? od? n)
;;;          (if (= n 0) true (od? <??> <??> <??>)))
;;;        (lambda (ev? od? n)
;;;          (if (= n 0) false (ev? <??> <??> <??>)))))

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) #t (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) #f (ev? ev? od? (- n 1))))))

(print (f  0)) ;==> #t
(print (f  1)) ;==> #f
(print (f  9)) ;==> #f
(print (f 10)) ;==> #t
