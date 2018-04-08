#lang racket

(+ 2 2)
(* 3 3)
(- 4 2)
(/ 6 2)

(string-append "hello" "world")
(string-append "hello " "world")
(string-append "hello" " " "world")
(equal? "hello " "hello")
(print "hello")
(string? "hello")
(make-string 5)
(number->string 42)
(string->number "42")
(string->number "hello world") ;; #f, not an error

;; Combining booleans
(and #true #false)
(or #f #t)
(not #f)

;; Numbers to booleans
(> 10 9)
(and (> 10 9) (< 7 3))
(or (> 10 9) (< 7 3))
(>= 10 10)
(<= -1 0)
(string=? "design" "tinker")

(and (or (= (string-length "hello world")
	    (string->number "11"))
	 (string=? "hello world" "good morning"))
     (>= (+ (string-length "hello world") 60) 80))

;; Note:
(equal? "hello" "dave") ;; only takes 2 args
(string=? "hello" "dave" "hal") ;; can take any number of args, but does equal?
                                ;; for each one.

;; Common image functions
(require 2htdp/image)
(circle 10 "solid" "red")
(rectangle 30 20 "outline" "blue")
;; Racket treats images just like normal values:
(overlay (circle 10 "solid" "red")
	 (rectangle 30 30 "solid" "blue"))

(overlay (rectangle 30 30 "solid" "blue")
	 (circle 10 "solid" "red"))

(image-width (square 10 "solid" "red"))
(image-width
 (overlay (rectangle 20 20 "solid" "blue")
	  (circle 5 "solid" "red")))

(place-image (circle 5 "solid" "green")
	     50 80
	     (empty-scene 100 100))

(define (y x) (* x x))
(y 1)
(y 2)

(define (picture-of-circle height)
  (place-image (circle 5 "solid" "red")
	       50 height
	       (empty-scene 100 60)))

;; Animation stuff
(require 2htdp/universe)

;; (animate picture-of-circle)

(define (sign x)
  (cond
   [(> x 0) 1]
   [(= x 0) 0]
   [(< x 0) -1]))

(sign 10)
(sign 0)
(sign -10)

(define (picture-of-circle.v2 height)
  (cond
   [(<= height 60)
    (place-image (circle 5 "solid" "red")
		 50 height
		 (empty-scene 100 60))]
   [(> height 60)
    (place-image (circle 5 "solid" "red")
		 50 (- 60 (/ (image-height (circle 5 "solid" "red")) 2))
		 (empty-scene 100 60))]))

;;(animate picture-of-circle.v2)

(define (picture-of-circle.v2.500 height)
  (cond
   [(<= height 200)
    (place-image (circle 5 "solid" "red")
		 200 height
		 (empty-scene 400 200))]
   [(> height 200)
    (place-image (circle 5 "solid" "red")
		 200 (- 200 (/ (image-height (circle 5 "solid" "red")) 2))
		 (empty-scene 400 200))]))

;;(animate picture-of-circle.v2.500)

(define MAX_HEIGHT 60)

(define (picture-of-circle.v4 height)
  (cond
   [(<= height (- MAX-HEIGHT (/ (image-height CIRCLE) 2)))
    (place-image CIRCLE
		 50 height
		 (empty-scene MAX-WIDTH MAX-HEIGHT))]
   [(> height (- MAX-HEIGHT (/ (image-height CIRCLE) 2)))
    (place-image ROCKET
		 50 (- MAX-HEIGHT (/ (image-height CIRCLE) 2))
		 (empty-scene MAX-WIDTH MAX-HEIGHT))]))
(define MAX-WIDTH 100)
(define MAX-HEIGHT 60)
(define CIRCLE (circle 5 "solid" "red"))

;;(animate picture-of-circle.v4)

(define ROCKET-CENTER-TO-TOP
  (- MAX_HEIGHT (/ (image-height CIRCLE) 2)))

(define (picture-of-circle.v5 height)
  (cond
   [(<= height ROCKET-CENTER-TO-TOP)
    (place-image CIRCLE
		 50 height
		 MKSCENE)]
   [(> height ROCKET-CENTER-TO-TOP)
    (place-image CIRCLE
		 50 ROCKET-CENTER-TO-TOP
		 MKSCENE)]))

;;(animate picture-of-circle.v5)

;; Replace "magic number" 50 with a constant
;; representing the horizontal (X) placement
;; of the circle
(define (picture-of-circle.v6 height)
  (cond
   [(<= height ROCKET-CENTER-TO-TOP)
    (place-image CIRCLE
		 CIRCLE-X height
		 MKSCENE)]
   [(> height ROCKET-CENTER-TO-TOP)
    (place-image CIRCLE
		 CIRCLE-X ROCKET-CENTER-TO-TOP
		 MKSCENE)]))

(define CIRCLE-X (/ MAX-WIDTH 2))
;;(animate picture-of-circle.v6)

;; Replace CIRCLE with a generic OBJECT
(define (picture-of-circle.v7 height)
  (cond
   [(<= height OBJECT-CENTER-TO-TOP)
    (place-image OBJECT
		 OBJECT-X height
		 MKSCENE)]
   [(> height OBJECT-CENTER-TO-TOP)
    (place-image OBJECT
		 OBJECT-X OBJECT-CENTER-TO-TOP
		 MKSCENE)]))
(define OBJECT
  (overlay (circle 10 "solid" "green")
	   (rectangle 40 4 "solid" "green")))
(define OBJECT-CENTER-TO-TOP
  (- MAX-HEIGHT (/ (image-height OBJECT) 2)))
(define OBJECT-X (/ MAX-WIDTH 2))

;;(animate picture-of-circle.v7)

;; Set the background blue
(define MKSCENE (empty-scene MAX-WIDTH MAX-HEIGHT "blue"))

;;(animate picture-of-circle.v7)

;; Refactor so that the input to our function is actually
;; the correct value inputted to it (time) and calculate
;; the distance based on that
(define V 1)
(define (distance t)
  (* V t))

(define (picture-of-object.v8 t)
  (cond
   [(<= (distance t) OBJECT-CENTER-TO-TOP)
    (place-image OBJECT
		 OBJECT-X (distance t)
		 MKSCENE)]
   [(> (distance t) OBJECT-CENTER-TO-TOP)
    (place-image OBJECT
		 OJBECT-X OBJECT-CENTER-TO-TOP
		 MKSCENE)]))

(animate picture-of-object.v8)
