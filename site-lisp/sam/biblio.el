;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.
(require 'bibtex)
(require 'bibtools)
(load-library "bibtools")

(bibtex-reduce-string "\'{e}")

(defun filter (condp lst)
  (delq nil
	(mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(defun string/ends-with (s ending)
  "return non-nil if string S ends with ENDING."
  (let ((elength (length ending)))
    (string= (substring s (- 0 elength)) ending)))

(defun validp (word)
  (not (or (string-equal word "and")
	   (string/ends-with word ".")
	   (= 1 (length word)))))


(validp "Anurag")
(validp "F")

(defun sam/bibtex-islabelchar (c)
  "Return t if C is a BibTeX label character, one of the
set [A-Za-z0-9:-], and otherwise, nil."
  (or
   (= c ?:)
   (= c ?-)
   (= c ?_)
   (bibtex-isalpha c)
   (bibtex-isdigit c)))
(sam/bibtex-reduce-string "Ribner__Comment_on_\"Large-Eddy_simulation_of_a_turbulent_compressible_round_jet\"_vis-a-vis_Lighthill's_theory_of_jet_noise.pdf
")
(defun sam/bibtex-reduce-string (s)
  "Squeeze out TeX accents and other characters from S that are not in
the set [A-Za-z0-9:-], and return the reduced string.  This function is
used for removing control sequences and bracing from tentative BibTeX
citation labels. 

2012-10-28 [S. Sinayoko]: Adapted from bibtools "

  ;; First remove TeX control words of three or more letters, e.g.,
  ;; \cedla, \cprime, \soft, ...  One- and two-character control words
  ;; (\c, \u, \v, ..., \aa, \ae, \oe) are handled specially below in the
  ;; first and second cases of the (cond ...)
  (setq s (bibtex-gsub "[\\][A-Za-z][A-Za-z][A-Za-z]+" "" s))

  (let ((len (length s)) (m 0) (n 0) (u))
    (setq u (make-string len 0))
    (while (< n len)
      (cond
       ((and (= (aref s n) ?\\) (< n (1- len))
	     (bibtex-isaccentletter (aref s (1+ n)))) ; then have TeX accent
	(setq n (1+ n)))		; so ignore it
       ((and (= (aref s n) ?\\) (< n (1- len)))	; then have TeX control word
					;like \oe, \aa, ..., \ss
	(while (and (< n (1- len)) (bibtex-isalpha (aref s (1+ n))))
	  (setq n (1+ n))		;copy the csname but not the backslash
	  (aset u m (aref s n))
	  (setq m (1+ m))))
       ((sam/bibtex-islabelchar (aref s n))	; then have character in [A-Za-z0-9:-]
	(aset u m (aref s n))
	(setq m (1+ m)))
       (t				; else ignore this character
	nil))
      (setq n (1+ n)))
    (substring u 0 m)))

(defun entry-cleanup (str)
     "Cleanup field by removing for example breaklines"
     (let* ((no-newline (replace-regexp-in-string "\n" " " str))
	    (no-tabs (replace-regexp-in-string "\t" " " no-newline))
	    (no-comma (replace-regexp-in-string "," "" no-tabs))
	    (no-space (replace-regexp-in-string " " "_" no-comma))
	    (no-slash (replace-regexp-in-string "/" "_" no-space))
	    (s (replace-regexp-in-string "{" "" no-slash))
	    (s (replace-regexp-in-string "}" "" s)))
       (sam/bibtex-reduce-string s)))

     
(defun build-entry-filename ()
  (interactive)
  (let (fields authors year title old-file new-file)
    (setq fields  (mapcar 'bibtex-text-in-field 
			  (list "author" "year" "title" "file")))
    (setq authors 
	  (sam/bibtex-reduce-string (entry-cleanup (mapconcat 'identity 
		     (filter 'validp (split-string (pop fields))) 
		     "_"))))
    (setq year (pop fields)
	  title (entry-cleanup (pop fields)))
    (concat (mapconcat 'identity (list authors year title) "_") ".pdf")))

(defun test ()
  (interactive)
  (message (build-entry-filename)))
