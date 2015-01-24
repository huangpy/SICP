;;; Exercise 3.65.  Use the series
;;;
;;;                 1     1     1
;;;     ln 2 = 1 - --- + --- - --- + ...
;;;                 2     3     4
;;;
;;; to compute three sequences of approximations to the natural logarithm of 2,
;;; in the same way we did above for π. How rapidly do these sequences
;;; converge?

(load "./sec-3.5.scm")
(load "./ex-3.55.scm")




(define (ln2-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln2-summands (+ n 1)))))

(define ln2-stream
  (partial-sums (ln2-summands 1)))




(define (test name s)
  (print name ":")
  (do ((i 0 (+ i 1)))
    ((= i 10))
    (let ([v (stream-ref s i)])
      (format #t "~18s --- ~18s --- ~18s\n" v (exp v) (abs (- (log 2) v)))))
  (print "...")
  (print))

(print "log 2 = " (log 2))
(print)
(test "original" ln2-stream)
(test "with Euler transform" (euler-transform ln2-stream))
(test "with tabuleau" (accelerated-sequence euler-transform ln2-stream))

; log 2 = 0.6931471805599453
;
; original:
; 1.0                --- 2.718281828459045  --- 0.3068528194400547
; 0.5                --- 1.6487212707001282 --- 0.1931471805599453
; 0.8333333333333333 --- 2.3009758908928246 --- 0.14018615277338797
; 0.5833333333333333 --- 1.7920018256557553 --- 0.10981384722661203
; 0.7833333333333333 --- 2.1887559724839996 --- 0.09018615277338804
; 0.6166666666666667 --- 1.8527419309528894 --- 0.07648051389327859
; 0.7595238095238095 --- 2.137258236121622  --- 0.0663766289638642
; 0.6345238095238095 --- 1.8861237734007472 --- 0.058623371036135796
; 0.7456349206349207 --- 2.1077792827826927 --- 0.052487740074975364
; 0.6456349206349206 --- 1.9071975640227783 --- 0.047512259925024725
; ...
;
; with Euler transform:
; 0.7                --- 2.0137527074704766 --- 0.006852819440054669
; 0.6904761904761905 --- 1.994665147672975  --- 0.0026709900837548206
; 0.6944444444444444 --- 2.0025962113905393 --- 0.0012972638844991335
; 0.6924242424242424 --- 1.9985546462422197 --- 7.229381357028997e-4
; 0.6935897435897436 --- 2.0008853219505287 --- 4.425630297982819e-4
; 0.6928571428571428 --- 1.9994200087081317 --- 2.900377028024481e-4
; 0.6933473389355742 --- 2.0004003568173063 --- 2.001583756289227e-4
; 0.6930033416875522 --- 1.999712342943843  --- 1.4383887239310944e-4
; 0.6932539682539682 --- 2.0002135867920634 --- 1.067876940229473e-4
; 0.6930657506744463 --- 1.9998371468596483 --- 8.142988549897368e-5
; ...
;
; with tabuleau:
; 1.0                --- 2.718281828459045  --- 0.3068528194400547
; 0.7                --- 2.0137527074704766 --- 0.006852819440054669
; 0.6932773109243697 --- 2.0002602776634952 --- 1.3013036442444115e-4
; 0.6931488693329254 --- 2.000003377548812  --- 1.6887729801240425e-6
; 0.6931471960735491 --- 2.000000031027208  --- 1.551360384599576e-8
; 0.6931471806635636 --- 2.0000000002072365 --- 1.0361833613359295e-10
; 0.6931471805604038 --- 2.000000000000917  --- 4.585221091701897e-13
; 0.6931471805599444 --- 1.9999999999999982 --- 8.881784197001252e-16
; 0.6931471805599426 --- 1.9999999999999947 --- 2.6645352591003757e-15
; 0.6931471805599453 --- 2.0                --- 0.0
; ...