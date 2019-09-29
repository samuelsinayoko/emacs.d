;;; -*-emacs-lisp-*-
;;; ====================================================================
;;;  @Emacs-Lisp-file{
;;;     author          = "Nelson H. F. Beebe",
;;;     version         = "1.03",
;;;     date            = "31 March 2003",
;;;     time            = "09:58:17 MST",
;;;     filename        = "clsc20.el",
;;;     address         = "Center for Scientific Computing
;;;                        University of Utah
;;;                        Department of Mathematics, 110 LCB
;;;                        155 S 1400 E RM 233
;;;                        Salt Lake City, UT 84112-0090
;;;                        USA",
;;;     telephone       = "+1 801 581 5254",
;;;     FAX             = "+1 801 581 4148",
;;;     URL             = "http://www.math.utah.edu/~beebe",
;;;     checksum        = "44597 343 1417 12476",
;;;     email           = "beebe@math.utah.edu, beebe@acm.org,
;;;                        beebe@computer.org, beebe@ieee.org
;;;                        (Internet)",
;;;     codetable       = "ISO/ASCII",
;;;     keywords        = "emacs, lisp, occur-mode",
;;;     supported       = "yes",
;;;     docstring       = "This file contains a collection of functions
;;;                        extending occur-mode for GNU emacs version 20
;;;                        or later.  A companion file, clsc19.el,
;;;                        contains corresponding functions for emacs
;;;                        version 19 or earlier.
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

(provide 'clsc20)

(defun after (regexp &optional nlines)
  "Show all lines containing REGEXP following point.  Display each line
with NLINES lines after.  NLINES defaults to 0.  Interactively it is the
prefix arg."
  (interactive
   (list (let* ((default (car regexp-history))
		(input
		 (read-from-minibuffer
		  (if default
		      (format "List lines matching regexp (default `%s'): "
			      default)
		    "List lines matching regexp: ")
		  nil nil nil 'regexp-history nil t)))
	   (if (string-equal input "")
	       default
	     (set-text-properties 0 (length input) nil input)
	     input))
	 current-prefix-arg))
  (let ((nlines (if nlines
		    (prefix-numeric-value nlines)
		  list-matching-lines-default-context-lines)))
    (occur-after-before regexp (abs nlines) t)))

(defun before (regexp &optional nlines)
  "Show all lines containing REGEXP following point.  Display each line
with NLINES lines before.  NLINES defaults to 0.  Interactively it is the
prefix arg."
  (interactive
   (list (let* ((default (car regexp-history))
		(input
		 (read-from-minibuffer
		  (if default
		      (format "List lines matching regexp (default `%s'): "
			      default)
		    "List lines matching regexp: ")
		  nil nil nil 'regexp-history nil t)))
	   (if (string-equal input "")
	       default
	     (set-text-properties 0 (length input) nil input)
	     input))
	 current-prefix-arg))
  (let ((nlines (if nlines
		    (prefix-numeric-value nlines)
		  list-matching-lines-default-context-lines)))
    (occur-after-before regexp (- (abs nlines)))))


;; Here is a modified function occur, where the original code was
;; borrowed from the file /usr/local/share/emacs/20.2/lisp/replace.el.
;; There was already support for the before function (via negative
;; nlines).
;;
;; Support for the after and show-long-lines functions required the
;; addition of an additional argument, after-not-before (:type
;; 'boolean).  No functionality has been removed!

(defun occur-after-before (regexp &optional nlines after-not-before longer-than)
  "Show all lines in the current buffer containing a match for REGEXP.

If a match spreads across multiple lines, all those lines are shown.

Each line is displayed with NLINES lines before and after, or -NLINES
before if NLINES is negative.
NLINES defaults to `list-matching-lines-default-context-lines'.
Interactively it is the prefix arg.

The lines are shown in a buffer named `*Occur*'.
It serves as a menu to find any of the occurrences in this buffer.
\\<occur-mode-map>\\[describe-mode] in that buffer will explain how.

If REGEXP contains upper case characters (excluding those preceded by `\\'),
the matching is case-sensitive."
  (interactive
   (list (let* ((default (car regexp-history))
		(input
		 (read-from-minibuffer
		  (if default
		      (format "List lines matching regexp (default `%s'): "
			      default)
		    "List lines matching regexp: ")
		  nil nil nil 'regexp-history nil t)))
	   (if (string-equal input "")
	       default
	     (set-text-properties 0 (length input) nil input)
	     input))
	 current-prefix-arg))
  (let ((nlines (if nlines
		    (prefix-numeric-value nlines)
		  list-matching-lines-default-context-lines))
	(after-not-before (if after-not-before t nil))
	(longer-than (if longer-than (prefix-numeric-value longer-than) 0))
	(first t)
	;;flag to prevent printing separator for first match
	(occur-num-matches 0)
	(buffer (current-buffer))
	(dir default-directory)
	(linenum 1)
	(prevpos
	 ;;position of most recent match
	 (point-min))
	(case-fold-search  (and case-fold-search
				(isearch-no-upper-case-p regexp t)))
	(final-context-start
	 ;; Marker to the start of context immediately following
	 ;; the matched text in *Occur*.
	 (make-marker)))
;;;	(save-excursion
;;;	  (beginning-of-line)
;;;	  (setq linenum (1+ (count-lines (point-min) (point))))
;;;	  (setq prevpos (point)))
    (save-excursion
      (goto-char (point-min))
      ;; Check first whether there are any matches at all.
      (if (not (re-search-forward regexp nil t))
	  (message "No matches for `%s'" regexp)
	;; Back up, so the search loop below will find the first match.
	(goto-char (match-beginning 0))
	(with-output-to-temp-buffer "*Occur*"
	  (save-excursion
	    (set-buffer standard-output)
	    (setq default-directory dir)
	    ;; We will insert the number of lines, and "lines", later.
	    (insert " matching ")
	    (let ((print-escape-newlines t))
	      (prin1 regexp))
	    (insert " in buffer " (buffer-name buffer) ?. ?\n)
	    (occur-mode)
	    (setq occur-buffer buffer)
	    (setq occur-nlines nlines)
	    (setq occur-command-arguments
		  (list regexp nlines)))
	  (if (eq buffer standard-output)
	      (goto-char (point-max)))
	  (save-excursion
	    ;; Find next match, but give up if prev match was at end of buffer.
	    (while (and (not (= prevpos (point-max)))
			(re-search-forward regexp nil t))
	      (goto-char (match-beginning 0))
	      (beginning-of-line)
	      (save-match-data
		(setq linenum (+ linenum (count-lines prevpos (point)))))
	      (setq prevpos (point))
	      (goto-char (match-end 0))
	      (let* ((start
		      ;;start point of text in source buffer to be put
		      ;;into *Occur*
		      (if after-not-before
			  (save-excursion
			    (goto-char (match-beginning 0))
			    (beginning-of-line)
			    (point))
			(save-excursion
			  (goto-char (match-beginning 0))
			  (forward-line (if (< nlines 0)
					    nlines
					  (- nlines)))
			  (point))))
		     (end
		      ;; end point of text in source buffer to be put
		      ;; into *Occur*
		      (if after-not-before
			  (save-excursion
			    (goto-char (match-end 0))
			    (forward-line (1+ (abs nlines)))
			    (point))
			(save-excursion
			  (goto-char (match-end 0))
			  (if (> nlines 0)
			      (forward-line (1+ nlines))
			    (forward-line 1))
			  (point))))
		     (match-beg
		      ;; Amount of context before matching text
		      (- (match-beginning 0) start))
		     (match-len
		      ;; Length of matching text
		      (- (match-end 0) (match-beginning 0)))
		     (tag (format "%5d" linenum))
		     (empty (make-string (length tag) ?\ ))
		     tem
		     ;; Number of lines of context to show for current match.
		     occur-marker
		     ;; Marker pointing to end of match in source buffer.
		     (text-beg
		      ;; Marker pointing to start of text for one
		      ;; match in *Occur*.
		      (make-marker))
		     (text-end
		      ;; Marker pointing to end of text for one match
		      ;; in *Occur*.
		      (make-marker))
		     )
		(save-excursion
		  (setq occur-marker (make-marker))
		  (set-marker occur-marker (point))
		  (set-buffer standard-output)
		  (setq occur-num-matches (1+ occur-num-matches))
		  (or first (zerop nlines)
		      (insert "--------\n"))
		  (setq first nil)

		  ;; Insert matching text including context lines from
		  ;; source buffer into *Occur*
		  (set-marker text-beg (point))
		  (insert-buffer-substring buffer start end)
		  (set-marker text-end (point))

		  ;; Highlight text that was matched.
		  (if list-matching-lines-face
		      (put-text-property
		       (+ (marker-position text-beg) match-beg)
		       (+ (marker-position text-beg) match-beg match-len)
		       'face list-matching-lines-face))

		  ;; `occur-point' property is used by occur-next and
		  ;; occur-prev to move between matching lines.
		  (put-text-property
		   (+ (marker-position text-beg) match-beg match-len)
		   (+ (marker-position text-beg) match-beg match-len 1)
		   'occur-point t)
		  (set-marker final-context-start
			      (- (point) (- end (match-end 0))))

		  ;; Now go back to the start of the matching text
		  ;; adding the space and colon to the start of each line.
		  (goto-char (- (point) (- end start)))
		  ;; Insert space and colon for lines of context before match.
		  (setq tem (if (< linenum nlines)
				(- nlines linenum)
			      nlines))
		  (while (> tem 0)
		    (insert empty ?:)
		    (forward-line 1)
		    (setq tem (1- tem)))

		  ;; Insert line number and colon for the lines of
		  ;; matching text.
		  (let ((this-linenum linenum))
		    (while (< (point) final-context-start)
		      (if (null tag)
			  (setq tag (format "%5d" this-linenum)))
		      (insert tag ?:)
		      (forward-line 1)
		      (setq tag nil)
		      (setq this-linenum (1+ this-linenum)))
		    (while (<= (point) final-context-start)
		      (insert empty ?:)
		      (forward-line 1)
		      (setq this-linenum (1+ this-linenum))))

		  ;; Insert space and colon for lines of context after match.
		  (while (and (< (point) (point-max)) (< tem nlines))
		    (insert empty ?:)
		    (forward-line 1)
		    (setq tem (1+ tem)))

		  ;; Add text properties.  The `occur' prop is used to
		  ;; store the marker of the matching text in the
		  ;; source buffer.
		  (put-text-property (marker-position text-beg)
				     (- (marker-position text-end) 1)
				     'mouse-face 'highlight)
		  (put-text-property (marker-position text-beg)
				     (marker-position text-end)
				     'occur occur-marker)
		  (goto-char (point-max)))
		(forward-line 1)))
	    (set-buffer standard-output)
	    ;; Go back to top of *Occur* and finish off by printing the
	    ;; number of matching lines.
	    (goto-char (point-min))
	    (let ((message-string
		   (if (= occur-num-matches 1)
		       "1 line"
		     (format "%d lines" occur-num-matches))))
	      (insert message-string)
	      (if (interactive-p)
		  (message "%s matched" message-string)))))))))

(defun show-long-lines (&optional arg)
  "Show lines longer than ARG (default: 72) characters.

This function is handy for checking that Fortran code does not
extend into the line number field.

WARNING: in this implementation, horizontal tab characters count
as single characters, NOT as padding to the next column which is
a multiple of eight."
  (interactive "P")
  (setq arg (if arg (prefix-numeric-value arg) 72))
  (if (> arg 0)
      (occur-after-before(make-string (1+ arg) ?.))
    (message "No lines to show")))
