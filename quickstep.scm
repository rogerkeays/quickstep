#!/usr/bin/csi -s

(require-extension posix)          ; setenv
(require-extension embedded-test)  ; tests
(require-extension trace)

(setenv "TESTS" "1")
(setenv "TESTS_VERBOSE" "1")

; beat offsets
(define down 0)
(define left 1/4)
(define up 1/2)
(define right 3/4)

; beat offset consonants
(define offsets
  `((,down  . "m")
    (,left  . "n")
    (,up    . "c")
    (,right . "k")))

; beat duration vowels
(define durations 
  `((4 . "o")
    (2 . "u")
    (1 . "a")
    (1/2 . "i")
    (1/4 . "e")))


;====================
(test-group consonant->offset
  (test (consonant->offset "m") down)
  (test (consonant->offset "n") left)
  (test (consonant->offset "c") up))

(define (consonant->offset consonant)
  (car (car (filter (lambda (x) (string=? consonant (cdr x))) offsets))))


;====================
(test-group offset->consonant
  (test (offset->consonant down) "m")
  (test (offset->consonant left) "n")
  (test (offset->consonant up) "c"))

(define (offset->consonant offset)
  (cdr (car (filter (lambda (x) (= offset (car x))) offsets))))


;====================
(test-group vowel->duration
  (test (vowel->duration "o") 4)
  (test (vowel->duration "a") 1)
  (test (vowel->duration "i") 1/2)
  #;(test (vowel->duration "ai") 3/2))

(define (vowel->duration vowel)
  (car (find (lambda (x) (string=? vowel (cdr x))) durations)))


;====================
(test-group duration->vowel
  (test (duration->vowel 4) "o")
  (test (duration->vowel 1) "a")
  (test (duration->vowel 1/2) "i")
  #;(test (duration->vowel 3/2) "ai"))

(define (duration->vowel duration)
  (cdr (find (lambda (x) (= duration (car x))) durations)))


;====================
(test-group get-offset
  (test (get-offset "ma") down)
  (test (get-offset "mi") down)
  (test (get-offset "ci") up)
  (test (get-offset "ce") up))

(define (get-offset syllable)
  (consonant->offset (substring syllable 0 1)))


;====================
(test-group get-duration
  (test (get-duration "ma") 1)
  (test (get-duration "mi") 1/2)
  (test (get-duration "ci") 1/2)
  (test (get-duration "mo") 4))

(define (get-duration syllable)
  (vowel->duration (substring syllable 1 (string-length syllable))))


;====================
(test-group make-syllable
  (test (make-syllable down 4) "mo")
  (test (make-syllable up 2) "cu")
  (test (make-syllable down 1) "ma")
  (test (make-syllable up 1/2) "ci")
  (test (make-syllable left 1/4) "ne"))

(define (make-syllable offset duration)
  (string-append (offset->consonant offset) (duration->vowel duration)))


;====================
(test-group decrement-duration
  (test (decrement-duration 4) 2)
  (test (decrement-duration 2) 1)
  (test (decrement-duration 1) 1/2)
  (test (decrement-duration 1/2) 1/4)
  (test (decrement-duration 1/4) #f))

(define (decrement-duration duration)
  (find (lambda (x) (< x duration)) (map car durations)))


;====================
(test-group enumerate-beats
  (test (enumerate-beats 1/4 down) '("me"))
  (test (enumerate-beats 1/4 up) '("ce"))
  (test (enumerate-beats 1/2 down) '("mi" "mene"))
  (test (enumerate-beats 1 down) '("ma" "mici" "miceke" "menike" "meneci" "meneceke")))

(define (enumerate-beats duration offset)
  (append (list (make-syllable offset duration))
    (let ([next (decrement-duration duration)])
      (if (not next) '()
        (list (string-append (car (enumerate-beats next offset))
                             (car (enumerate-beats (- duration next) (+ offset (- duration next))))))))))

(trace enumerate-beats)
(run-tests)

