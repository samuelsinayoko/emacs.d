;;; ====================================================================
;;;  @Emacs-Lisp-file{
;;;     author          = "Nelson H. F. Beebe",
;;;     version         = "1.00",
;;;     date            = "25 February 1998",
;;;     time            = "15:28:41 MST",
;;;     filename        = "clsc19.el",
;;;     address         = "Center for Scientific Computing
;;;                        University of Utah
;;;                        Department of Mathematics, 105 JWB
;;;                        155 S 1400 E RM 233
;;;                        Salt Lake City, UT 84112-0090
;;;                        USA",
;;;     telephone       = "+1 801 581 5254",
;;;     FAX             = "+1 801 581 4148",
;;;     URL             = "http://www.math.utah.edu/~beebe",
;;;     checksum        = "20408 360 1567 14017",
;;;     email           = "beebe@math.utah.edu, beebe@acm.org,
;;;                        beebe@ieee.org (Internet)",
;;;     codetable       = "ISO/ASCII",
;;;     keywords        = "emacs, lisp, occur-mode",
;;;     supported       = "yes",
;;;     docstring       = "This file contains a collection of functions
;;;                        extending occur-mode for GNU emacs version 19
;;;                        or earlier.  A companion file, clsc20.el,
;;;                        contains corresponding functions for emacs
;;;                        version 20 or later.
;;;
;;;                        These two files exist because the internal
;;;                        implementation of occur changed radically at
;;;                        emacs 20, making it unreasonable to attempt
;;;                        to support both variants in a single file.
;;;
;;;                        The choice between the two is made in
;;;                        clsc.el, so clsc19.el and clsc20.el never
;;;                        need be known to end-user code.
;;;
;;;                        The checksum field above contains a CRC-16
;;;                        checksum as the first value, followed by the
;;;                        equivalent of the standard UNIX wc (word
;;;                        count) utility output of lines, words, and
;;;                        characters.  This is produced by Robert
;;;                        Solovay's checksum utility.",
;;;  }
;;; ====================================================================

(provide 'clsc19)

(defvar occur-match-beginning nil
  "*Byte position of beginning of occur match.")


(defvar occur-match-end nil
  "*Byte position of end of occur match.")


;=======================================================================

;; M-x occur and M-x occur-mode in emacs/lisp/replace.el use three global
;; variables for communication:
;;
;; 	occur-nlines		numeric argument to M-x occur
;;	occur-buffer		name of buffer in which M-x occur was last run
;;	occur-pos-list		list of marker elements
;;
;; The contents of the *Occur* buffer consist of a header line, followed by
;; 2*occur-nlines + 1 lines for each match, with each such group separated by a
;; line of dashes.  occur-goto-occurrence acts by computing the current line
;; position in the *Occur* buffer, and dividing it by 2*occur-nlines + 2 to get
;; the index of an element in occur-pos-list, from which it can goto the
;; occurrence.
;;
;; M-x after and M-x before work much like M-x occur, except that they display
;; empty lines in the *After* or *Before* buffers to suppress the view of lines
;; before or after the match.
;;
;; We provide occur-mode-extended-goto-occurrence as a fancy replacement for
;; occur-goto-occurrence.  It accepts an occur-pos-list with elements that are
;; themselves lists of (marker region-start region-end) triples.  When possible,
;; the region is highlighted for a time controllable by occur-highlight-time.
;; occur-mode-extended-goto-occurrence can be used with M-x after, M-x before,
;; M-x occur, and M-x show-LaTeX-labels.

(defun after (regexp &optional nlines)
  "Show all lines containing REGEXP following point.  Display each line
with NLINES lines after.  NLINES defaults to 0.  Interactively it is the
prefix arg."
  (interactive "sAfter (show lines matching regexp): \nP")
  (setq nlines (if nlines (prefix-numeric-value nlines) 0))
  (let ((curbuf (current-buffer)) (first t) (k) (the-list ()) (the-marker) )
    (with-output-to-temp-buffer "*After*"
      (save-excursion
	(set-buffer standard-output)
	(occur-mode)
	(setq occur-nlines nlines)
	(setq occur-buffer curbuf)
	(local-set-key "\C-c\C-c" 'occur-mode-extended-goto-occurrence)
	(if (not (string-lessp (substring emacs-version 0 2) "19"))
	    (local-set-key [mouse-2] 'occur-mode-mouse-goto))
	(princ "Lines matching ")
	(prin1 regexp)
	(princ " in buffer ")
	(princ occur-buffer)
	(princ ".  ")
	(princ (if (string-lessp (substring emacs-version 0 2) "19")
		   "" "Mouse-2 or "))
	(princ "C-c C-c goes to match.\n"))
      (save-excursion
	(goto-char (point-min))
	;; [02-Mar-1996] We check for both end-of-buffer and a pattern
	;; match, because a pattern of "^$" is always found at
	;; end-of-buffer. Without the end-of-buffer check, an infinite
	;; loop ensued when this pattern was used [to show the first line
	;; of each paragraph].
	(while (and (< (point) (point-max)) (re-search-forward regexp nil t))
	  (let* ((buffer (current-buffer))
		 (start (save-excursion (beginning-of-line) (point)))
		 (end (save-excursion (forward-line (1+ nlines)) (point)))
		 (line-tag)
		 (empty-string)
		 (line-number (1+ (count-lines (point-min) start))))
	    (save-excursion
	      (setq the-marker (make-marker))
	      (set-marker the-marker (point))
	      (set-buffer standard-output)
	      ;; (setq the-list (cons the-marker the-list))
	      (setq the-list (cons (list the-marker (match-beginning 0) (match-end 0))
				   the-list))
	      (if (> nlines 0)
		  (progn
		    (or first (insert "--------\n"))
		    (setq first nil)))
	      (setq line-tag (format "%3d" line-number))
	      (setq empty-string (make-string (length line-tag) ?\ ))
	      (setq k nlines)
	      (while (> k 0)
		(insert empty-string ":\n")
		(setq k (1- k)))
	      (insert line-tag ":")
	      (let ((b (point)))
		(insert-buffer-substring buffer start end)
		(goto-char b)
		(while (search-forward "\n" nil t)
		  (if (< (point) (point-max))
		      (insert empty-string ":")))))
	    (forward-line 1))))
      (set-buffer standard-output)
      (setq occur-pos-list (nreverse the-list))
      (if (interactive-p)
	  (message "%d matching lines." (length occur-pos-list)))
      (toggle-read-only))))

(defun before (regexp &optional nlines)
  "Show all lines containing REGEXP following point.  Display each line
with NLINES lines before.  NLINES defaults to 0.  Interactively it is
the prefix arg."
  (interactive "sBefore (show lines matching regexp): \nP")
  (setq nlines (if nlines (prefix-numeric-value nlines) 0))
  (let ((curbuf (current-buffer)) (k) (the-list ()) (the-marker))
    (with-output-to-temp-buffer "*Before*"
      (save-excursion
	(set-buffer standard-output)
	(occur-mode)
	(setq occur-nlines nlines)
	(setq occur-buffer curbuf)
	(local-set-key "\C-c\C-c" 'occur-mode-extended-goto-occurrence)
	(if (not (string-lessp (substring emacs-version 0 2) "19"))
	    (local-set-key [mouse-2] 'occur-mode-mouse-goto))
	(princ "Lines matching ")
	(prin1 regexp)
	(princ " in buffer ")
	(princ occur-buffer)
	(princ ".  ")
	(princ (if (string-lessp (substring emacs-version 0 2) "19")
		   "" "Mouse-2 or "))
	(princ "C-c C-c goes to match.\n"))
      (save-excursion
	(goto-char (point-min))
	;; [02-Mar-1996] We check for both end-of-buffer and a pattern
	;; match, because a pattern of "^$" is always found at
	;; end-of-buffer. Without the end-of-buffer check, an infinite
	;; loop ensued when this pattern was used [to show the last line
	;; of each paragraph].
	(while (and (< (point) (point-max)) (re-search-forward regexp nil t))
	  (let* ((buffer (current-buffer))
		 (start (save-excursion (beginning-of-line)
					(forward-line (- nlines)) (point)))
		 (end (save-excursion (forward-line 1) (point)))
		 (line-tag)
		 (empty-string)
		 (line-number (1+ (count-lines (point-min) start))))
	    (save-excursion
	      (setq the-marker (make-marker))
	      (set-marker the-marker (point))
	      (set-buffer standard-output)
	      ;; (setq the-list (cons the-marker the-list))
	      (setq the-list (cons (list the-marker (match-beginning 0) (match-end 0))
				   the-list))
	      (setq line-tag (format "%3d" line-number))
	      (setq empty-string (make-string (length line-tag) ?\ ))
	      (while (<= line-number nlines)
		(insert empty-string ":\n")
		(setq line-number (1+ line-number)))
	      (insert line-tag ":")
	      (let ((b (point)))
		(insert-buffer-substring buffer start end)
		(goto-char b)
		(while (search-forward "\n" nil t)
		  (if (< (point) (point-max))
		      (insert empty-string ":"))))
	      (setq k nlines)
	      (while (> k 0)
		(insert empty-string ":\n")
		(setq k (1- k)))
	      (if (> nlines 0)
		  (insert "--------\n")))
	    (forward-line 1))))
      (set-buffer standard-output)
      (setq occur-pos-list (nreverse the-list))
      (if (interactive-p)
	  (message "%d matching lines." (length occur-pos-list)))
      (toggle-read-only))))


;; This is a modification of occur-mode-goto-occurrence from
;; emacs/lisp/replace.el to support extended occur-pos-list structures
(defun occur-mode-goto-occurrence ()
  "Go to the line this occurrence was found in, in the buffer it was found in."
  (interactive)
  (if (or (null occur-buffer)
	  (null (buffer-name occur-buffer)))
      (progn
	(setq occur-buffer nil
	      occur-pos-list nil)
	(error "Buffer in which occurrences were found is deleted")))
  (let* ((occur-number (save-excursion
			 (beginning-of-line)
			 (/ (1- (count-lines (point-min)
					     (save-excursion
					       (beginning-of-line)
					       (point))))
			    (cond ((< occur-nlines 0)
				   (- 2 occur-nlines))
				  ((> occur-nlines 0)
				   (+ 2 (* 2 occur-nlines)))
				  (t 1)))))
	 (pos (nth occur-number occur-pos-list)))
    (setq occur-match-beginning nil)
    (setq occur-match-end nil)
    (cond
     ((listp pos)			;element == (marker begin end)
      (setq occur-match-beginning (nth 1 pos))
      (setq occur-match-end (nth 2 pos))
      (setq pos (nth 0 pos)))
     ((markerp pos))			;element == marker
     ((null pos) (error "No occurrence on this line")))	;element == nil
    (pop-to-buffer occur-buffer)
    (goto-char (marker-position pos))))


(defun occur-mode-extended-goto-occurrence ()
  "Go to the line this occurrence was found in, in the buffer it was
found in, and if possible, momentarily highlight the braced text at
point.  Although this function uses the occur-mode support code, it
preserves any existing information from an *Occur* buffer."
  (interactive)
  (let ((occur-nlines occur-nlines)	;dynamic binding means we can
	(occur-buffer occur-buffer)	;create new values for these
	(occur-pos-list occur-pos-list)) ;while preserving old ones

    (cond				;bind new occur-xxx variables
     ((string-equal "*LaTeX Labels*" (buffer-name))
      (setq occur-buffer LaTeX-labels-occur-buffer)
      (setq occur-nlines 0)
      (setq occur-pos-list LaTeX-labels-occur-pos-list)))

    (occur-mode-goto-occurrence)	;use standard occur-mode function

    ;; Finally, highlight the match, if possible and not suppressed

    (if (and
	 (fboundp 'transient-mark-mode)
	 (> occur-highlight-time 0))
	(cond
	 ((and (boundp 'LaTeX-labels-occur-pos-list)
	       (eq occur-pos-list LaTeX-labels-occur-pos-list))
	  (let ((transient-mark-mode))
	    (push-mark (point))
	    (transient-mark-mode 1)
	    (search-forward "}")
	    (backward-char 1)
	    (sit-for occur-highlight-time)
	    (pop-mark)))
	 ((and (not (null occur-match-beginning))
	       (not (null occur-match-end)))
	  (let ((transient-mark-mode))
	    (push-mark occur-match-beginning)
	    (transient-mark-mode 1)
	    (goto-char occur-match-end)
	    (sit-for occur-highlight-time)
	    (pop-mark)))))))


(defun occur-mode-mouse-goto (start-event)
  "Move point to the position of the mouse cursor in an occur-mode buffer, and
then in a second window, go to the match closest to point."
  (interactive "e")
  (mouse-set-point start-event)
  (occur-mode-extended-goto-occurrence))


(defun show-long-lines (&optional arg)
  "Show lines longer than arg (default = 72) characters."
  (interactive "P")
  (setq arg (if arg (prefix-numeric-value arg) 72))
  (let ((curbuf (current-buffer)) (linenum) (the-list ()) (the-marker))
    (if (eq 'arg 1)
	(setq arg 72))
    (with-output-to-temp-buffer "*Long Lines*"
      (save-excursion
	(set-buffer standard-output)
	(occur-mode)
	(setq occur-nlines 0)
	(setq occur-buffer curbuf)
	(local-set-key "\C-c\C-c" 'occur-mode-extended-goto-occurrence)
	(if (not (string-lessp (substring emacs-version 0 2) "19"))
	    (local-set-key [mouse-2] 'occur-mode-mouse-goto))
	(princ "Lines longer than ")
	(princ arg)
	(princ " in buffer ")
	(princ occur-buffer)
	(princ ".  ")
	(princ (if (string-lessp (substring emacs-version 0 2) "19")
		   "" "Mouse-2 or "))
	(princ "C-c C-c goes to match.\n"))
      (save-excursion
	(goto-char (point-min))
	(setq linenum 1)
	(while (< (point) (point-max))
	  (end-of-line)
	  (if (> (current-column) arg)
	      (progn
		(let ((buffer (current-buffer))
		      (start (save-excursion (beginning-of-line) (point)))
		      (end (save-excursion (forward-line 1) (point))))
		  (save-excursion
		    (setq the-marker (make-marker))
		    (set-marker the-marker (point))
		    (set-buffer standard-output)
		    (setq the-list
			  (cons (list the-marker start (1- end)) the-list))
		    (insert (format "%3d:" linenum))
		    (insert-buffer-substring buffer start end)))))
	  (forward-line 1)
	  (setq linenum (1+ linenum))))
      (set-buffer standard-output)
      (setq occur-pos-list (nreverse the-list))
      (if (interactive-p)
	  (message "%d long lines." (length occur-pos-list)))
      (toggle-read-only))))
