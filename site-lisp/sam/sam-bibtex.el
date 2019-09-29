(require 'bibtex)


(defvar sam-bibtex-key-to-filename-script "bibtexkey2pdf" "Shell
command taking a bibtex key and returning the relative path to
the associated pdf. Should return empty string if no file is
found.")

;; (defun sam-bibtex-reduce-string (s)
;;   "Squeeze out TeX accents and other characters from S that are not in
;; the set [A-Za-z0-9:-], and return the reduced string.  This function is
;; used for removing control sequences and bracing from tentative BibTeX
;; citation labels. 

;; 2012-10-28 [S. Sinayoko]: Adapted from bibtools "

;;   ;; First remove TeX control words of three or more letters, e.g.,
;;   ;; \cedla, \cprime, \soft, ...  One- and two-character control words
;;   ;; (\c, \u, \v, ..., \aa, \ae, \oe) are handled specially below in the
;;   ;; first and second cases of the (cond ...)
;;   (setq s (bibtex-gsub "[\\][A-Za-z][A-Za-z][A-Za-z]+" "" s))

;;   (let ((len (length s)) (m 0) (n 0) (u))
;;     (setq u (make-string len 0))
;;     (while (< n len)
;;       (cond
;;        ((and (= (aref s n) ?\\) (< n (1- len))
;; 	     (bibtex-isaccentletter (aref s (1+ n)))) ; then have TeX accent
;; 	(setq n (1+ n)))		; so ignore it
;;        ((and (= (aref s n) ?\\) (< n (1- len)))	; then have TeX control word
;; 					;like \oe, \aa, ..., \ss
;; 	(while (and (< n (1- len)) (bibtex-isalpha (aref s (1+ n))))
;; 	  (setq n (1+ n))		;copy the csname but not the backslash
;; 	  (aset u m (aref s n))
;; 	  (setq m (1+ m))))
;;        ((sam/bibtex-islabelchar (aref s n))	; then have character in [A-Za-z0-9:-]
;; 	(aset u m (aref s n))
;; 	(setq m (1+ m)))
;;        (t				; else ignore this character
;; 	nil))
;;       (setq n (1+ n)))
;;     (substring u 0 m)))



(defun sam-bibtex-change-field (field string)
  "Change the content of field in current entry"
  (save-excursion
    (bibtex-narrow-to-entry)
    (goto-char 1)
    (if (search-forward-regexp 
	 (format "%s[[:space:]]*=[[:space:]]*{" field) nil t)
	(progn (bibtex-empty-field) (insert string))
      (end-of-buffer)
      (forward-char -1)
      (search-backward "}")
      (bibtex-make-field (list field "" string nil) t t))
    (widen)))
  
(defun sam-bibtex-link-pdf-entry (key beg end &optional debug)
  "Function used with `bibtex-map-entries' to add file"
  (interactive)
  (let (title)
    (setq title (shell-quote-argument (bibtex-text-in-field "title")))
    ;;(message (format "- %s, %s" key title))
    (let (cmd filename)
      (setq cmd (format "./%s %s %s" sam-bibtex-key-to-filename-script key title))
      (setq filename (shell-command-to-string cmd))
      (setq filename (replace-regexp-in-string "\n" "" filename))
      (if (string= filename "")
	  (message "WARNING in entry \"%s\": associated file not found." key)
	(sam-bibtex-change-field "file" (format ":%s:pdf" filename)) ;; JabRef's format
	(if debug (message "Changed file field to \"%s\" in entry \"%s\"" filename key))))))

(defun sam-bibtex-link-pdfs (&optional bibin bibout)
  "Link each entry with the associated pdf file"
  (interactive)
  (unless bibin
    (setq bibin buffer-file-name))
  (unless bibout
    (setq bibout (replace-regexp-in-string "\\.bib" "_out.bib" bibin)))
  (save-excursion
    (find-file bibin)
    (bibtex-map-entries 'sam-bibtex-link-pdf-entry)
    (write-file bibout)))

(defun sam-bibtex-format-title (key beg end &optional debug)
  "Function used with `bibtex-map-entries' to format titles. First word capitalized only"
  (interactive)
  (let (old-title new-title)
    (setq old-title (bibtex-text-in-field "title"))
    (setq new-title (with-temp-buffer
		      (insert old-title)
		      (downcase-region (point-min) (point-max))
		      (goto-char 1)
		      (capitalize-word 1)
		      (buffer-string)))
    (message "- %s, %s" key new-title)
    (sam-bibtex-change-field "title" new-title) ;; new title
    (message "Changed title field from \"%s\" to \"%s\" in entry \"%s\"" old-title new-title  key)))


(defun sam-bibtex-format-all-title ()
  "reformat all titles in current buffer"
  (interactive)
  (bibtex-map-entries 'sam-bibtex-format-title))

(provide 'sam-bibtex)
