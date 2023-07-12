#!/usr/bin/racket
#lang jamaica sweet-exp racket

require fluent

;; JOURNEY

define chocolatarie (list doormat shop-left shop-right passage kitchen shop-right-2 kitchen aisle quarters)

define shop-left (list doorway mat bench-left cupboard-left)
define shop-right (list window mat bench-right cupboard-right)
define shop-right-2 (list window mat bench-right-2 cupboard-right-2)
define kitchen (list cabinet-right board-right cabinet-left board-left)  

define doormat (list intruder)

;; STORY

define intruder ()

;; functions

define (set-last lst elem)
  lst ~> (list-set (lst ~> length) elem)


;; vianne goes ahead with her plans, despite the count's threats
;; furious, she puts her energy into fixing the shop
;; calming down, she starts to think more rationally and starts planning
print
X:0
M:4/4
L:1/4
Q:165
K:C


% doormat
% shop-left
%  doorway
%  mat
%  bench
%  cupboard
% shop-right#1
%  doorway
%  mat
%  bench
% kitchen#1
% 
% rhythm


%
% or: bottom-up
%
define get-off-the-doormat '(1/2 1 1/2 1 1)

define another-war-a-fight-of-free-will '(2 1 1/2 1/2 1/2 1 1/2 1 1/2 1 4 4 4)

