#!/usr/local/bin/sbcl --script

(load "~/tools/quicklisp/setup.lisp")
(require 'split-sequence)
(defun split (x y) (split-sequence:split-sequence x y))
(defun coalesce (x y) (if x x y))

(defun parse-elements (line)
  (ignore-errors
    (split #\,
        (subseq line (+ 1 (search "{" line)) (search "}" line)))))

(assert (equal (parse-elements "hello world") '()))
(assert (equal (parse-elements "hello, world") '()))
(assert (equal (parse-elements "hello {world,moon}") '("world" "moon")))
(assert (equal (parse-elements "hello {world,moon} {pie,shake}") '("world" "moon")))

(defun combine-first (line replacements)
  (mapcar (lambda (replacement) 
    (handler-case
      (concatenate 'string (subseq line 0 (search "{" line)) replacement (subseq line (+ 1 (search "}" line))))
      (condition () line)))
    (coalesce replacements (list line))))

(assert (equal (combine-first "hello world" '()) '("hello world")))
(assert (equal (combine-first "hello world" '("moon")) '("hello world")))
(assert (equal (combine-first "hello {world}" '("moon")) '("hello moon")))
(assert (equal (combine-first "hello {world,moon}" '("world" "moon")) '("hello world" "hello moon")))
(assert (equal (combine-first "hello {world,moon} {pie,shake}" '("world" "moon")) '("hello world {pie,shake}" "hello moon {pie,shake}")))

(defun permute (line)
  (combine-first line (parse-elements line)))

(assert (equal (permute "hello world") '("hello world")))
(assert (equal (permute "hello {world}") '("hello world")))
(assert (equal (permute "hello {world,moon}") '("hello world" "hello moon")))
(assert (equal (permute "hello {world,moon} {pie,shake}") '("hello world pie" "hello moon pie" "hello moon pie" "hello moon shake")))

