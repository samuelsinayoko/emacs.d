(require 'bibtex)

(defvar sam-bibtex-key-to-filename-script "bibtexkey2pdf" "Shell
command taking a bibtex key and returning the relative path to
the associated pdf. Should return empty string if no file is
found.")

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
  
(defun sam-bibtex-link-pdf-entry (key beg end)
  "Function used with `bibtex-map-entries' to add file"
  (interactive)
  (let (title)
    (setq title (shell-quote-argument (bibtex-text-in-field "title")))
    (message (format "- %s, %s" key title))
    (let (cmd filename)
      (setq cmd (format "./%s %s" sam-bibtex-key-to-filename-script key))
      (setq filename (shell-command-to-string cmd))
      (unless (string= filename "")
	(sam-bibtex-change-field "file" filename)
	(message "Changed file field to \"%s\" in entry \"%s\"" filename key)))))

(defun sam-bibtex-link-pdfs (&optional bibin bibout)
  "Link each entry with the associated pdf file"
  (interactive)
  (unless bibin
    (setq bibin buffer-file-name))
  (unless bibout
    (setq bibout bibin))
  (save-excursion
    (switch-to-buffer bibin)
    (bibtex-map-entries 'sam-bibtex-link-pdf-entry)
    (write-file bibout)))
