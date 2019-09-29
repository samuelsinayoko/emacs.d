;;; latin-alt.el --- Quail package for inputting various European characters -*-coding: utf-8;-*-

;; Copyright (C) 1997-1998, 2001-2012  Free Software Foundation, Inc.
;; Copyright (C) 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007,
;;   2008, 2009, 2010, 2011
;;   National Institute of Advanced Industrial Science and Technology (AIST)
;;   Registration Number H14PRO021

;; Keywords: multilingual, input method, latin

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;; Author (of latin-post.el): TAKAHASHI Naoto <ntakahas@etl.go.jp>

;;; Commentary:

;; These input methods differ from those in latin-post.el
;; in that comma is not special (use / instead),
;; and // is not special either (so you can enter a slash
;; by typing //).

;; At least, that's what I could see by comparing the first few
;; of these with latin-post.el.

;;; Code:

(require 'quail)

(quail-define-package
 "latex-easy-kbd" "LaTeXe" "LXe" t
 "[ <-> { " 
 nil t nil nil nil nil nil nil nil nil t)
(quail-define-rules
("1" ?1)
("!" ?*)
("2" ?2)
("@" ?@)
("3" ?~)
("#" ?3)
("4" ?-)
("$" ?4)
("5" ?_)
("%" ?5)
("6" ?^)
("^" ?6)
("7" ?=)
("&" ?7)
("8" ?+)
("*" ?8)
("9" ?%)
("(" ?9)
("0" ?0)
(")" ?#)
("-" ?/)
("_" ?<)
("=" ?&)
("+" ?>)
("[" ?\()
("{" ?})
("]" ?')
("}" ?\))
(";" ?\\)
(":" ?:)
("'" ?$)
("\"" ?\;)
("\\" ?|)
("|" ?!)
("`" ?[)
("~" ?])
("," ?`)
("<" ?,)
("." ?{)
(">" ?.)
("/" ?\")
("?" ?\?)
)
;; (quail-define-rules
;;  ("{" ?[)
;;  ("}" ?])
;;  ("[" ?{)
;;  ("]" ?})
;;  ("1" ?!)
;;  ("!" ?1)
;;  ("2" ?@)
;;  ("@" ?2)
;;  ("3" ?#)
;;  ("#" ?3)
;;  ("4" ?$)
;;  ("$" ?4)
;;  ;; 5 -> % -> _ 
;;  ("5" ?_)
;;  ("%" ?5)
;;  ("_" ?%)
;;  ;; 
;;  ("6" ?^)
;;  ("^" ?6)
;;  ("7" ?&)
;;  ("&" ?7)
;;  ("8" ?*)
;;  ("*" ?8)
;;  ("9" ?\()
;;  ("(" ?9)
;;  ("0" ?\))
;;  (")" ?0)
;;  (";" ?\\)
;;  ("\\" ?\;)
;;  )


;;; latin-alt.el ends here
