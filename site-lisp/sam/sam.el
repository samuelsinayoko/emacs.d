;;;; In python mode: cd in shell to script directory
(defun py-cd-to-script-directory ()
  "Change directory in shell to the script directory"
  (interactive)
  (process-send-string (or (get-process "Python")
			   (get-process "IPython")
			   (get-process "ipython"))
		       (format "cd %s\n" default-directory)))

;;;; To colorize regions in LaTeX differently
					; Can be used to differentiate between reviewer's comments and
					; authors' responses when publishing a paper.
(defun reviewer ()
  "Insert a markup \item \emph{ } around region"
  (interactive)
  (goto-char (region-end)) (insert "}")
  (goto-char (region-beginning)) (insert "\\item \\emph{")
  )

(defun color ()
  "Insert a markup \item \emph{ } around region"
  (interactive)
  (goto-char (region-end)) (insert "}")
  (goto-char (region-beginning)) (insert "\\new{")
  )

(global-set-key (kbd "M-# #")  'color)
(global-set-key (kbd "M-# i")  'reviewer)
(global-set-key (kbd "M-# p")  'remove-hard-wrap-paragraph)
(global-set-key (kbd "M-# r")  'remove-hard-wrap-region)

;;;; From Scott Frazer
					; http://scottfrazersblog.blogspot.com/2009/12/emacs-using-bookmarked-directories.html
					; Combine ido and dired with bookmarks
(defun my-ido-bookmark-jump ()
  "Jump to bookmark using ido"
  (interactive)
  (let ((dir (my-ido-get-bookmark-dir)))
    (when dir
      (find-alternate-file dir))))

(defun open-ref ()
 "Open a reference using ido"
 (interactive)
 (let ((biblio-dir (expand-file-name "~/documents/biblio/mendeley")))
   (shell-command
    (concat pdf-view-command
	    (ido-completing-read "open ref:" (directory-files biblio-dir))))))

(defun my-ido-get-bookmark-dir ()
  "Get the directory of a bookmark."
  (let* ((name (ido-completing-read "Use dir of bookmark: " (bookmark-all-names) nil t))
         (bmk (bookmark-get-bookmark name)))
    (when bmk
      (setq bookmark-alist (delete bmk bookmark-alist))
      (push bmk bookmark-alist)
      (let ((filename (bookmark-get-filename bmk)))
        (if (file-directory-p filename)
            filename
          (file-name-directory filename))))))
(defun my-ido-dired-mode-hook ()
  (define-key dired-mode-map "$" 'my-ido-bookmark-jump))
(add-hook 'dired-mode-hook 'my-ido-dired-mode-hook)
(defun my-ido-use-bookmark-dir ()
  "Get directory of bookmark"
  (interactive)
  (let* ((enable-recursive-minibuffers t)
         (dir (my-ido-get-bookmark-dir)))
    (when dir
      (ido-set-current-directory dir)
      (setq ido-exit 'refresh)
      (exit-minibuffer))))
;;(require 'ido)
;;(define-key ido-file-dir-completion-map (kbd "$") 'my-ido-use-bookmark-dir)

(defun copy-sexp (&optional arg)
  "Copy the sexp (balanced expression) following point.
With ARG, kill that many sexps after point.
Negative arg -N means kill N sexps before point.
Based on kill-sexp."
  (interactive "p")
  (let ((opoint (point)))
    (forward-sexp (or arg 1))
    (kill-ring-save opoint (point))))

(defun transpose-buffers ()
  "Transpose the buffers shown in two windows."
  (interactive "")
  (let ((this-win (window-buffer))
        (next-win (window-buffer (next-window))))
    (set-window-buffer (selected-window) next-win)
    (set-window-buffer (next-window) this-win)
    (select-window (next-window))))

(defun kill-other-buffer()
  """Kill buffer in other window"""
  (interactive)
  (select-window (next-window))
  (kill-buffer (window-buffer))
  (select-window (previous-window)))

(defun point-register-u ()
  "Store point in register"
  (interactive)
  (point-to-register ?u))

(defun jump-to-register-u ()
  "Jump to register u. Bind this to M-oo so that one can quickly
store point to register u with M-uu and jump back with M-oo"
  (interactive)
  (jump-to-register ?u))

;;  Hungarian
(defun insert-*()
  "Insert *. Useful when writing with hungarian keyboard"
  (interactive)
  (insert "*"))
;;(global-set-key (kbd "C-x 8") 'insert-*)
(defun org-drill-template(en ma)
  "Create flash card for drill mode"
  (interactive "sEnglish: \nsMagyar: ")
  (insert "**           :drill:
    :PROPERTIES:
    :DRILL_CARD_TYPE: twosided
    :END:
")
  (insert "*** English\n" en "\n")
  (insert "*** Magyar\n" ma))
(defalias 'odt 'drill-template)

;; Org-mode
(defun wrap-region (beg end)
  "Enclose region with some character"
  (interactive "r")
  (let ((s (read-from-minibuffer "String: ")))
    (save-excursion
      (goto-char end)
      (insert s)
      (goto-char beg)
      (insert s))))

(defun org-table-field-boundaries () ;; use org-table-end and org-table-beginning
  "Mark current field"
  (interactive)
  (save-excursion
    (let (beg end)
      (org-table-beginning-of-field)
      (setq beg (point))
      (org-table-end-of-field)
      (setq end (point))
      (list beg end))))

(defun org-table-mathify-old (beg end)
  "Insert $ sign around every field of table"
  (interactive "r")
  (save-excursion
    (goto-char end)
    (condition-case nil
	(while (> (point) beg)
	  (org-table-previous-field)
	  (skip-chars-forward " ")
	  (insert "$")
	  (skip-chars-forward "^|")
	  (skip-chars-backward " ")
	  (insert "$"))
      (message "done"))))

(defun org-table-from-lisp (lsp-table)
  "Convert a lisp formatted org table back to a formatted string."
  (with-temp-buffer
    (insert (mapconcat #'(lambda (row)
			  (if (eq row 'hline)
			      "|-"
			    (concat "| " (mapconcat 'identity row " | ") " |")))
		       lsp-table "\n"))
    (org-table-align)
    (buffer-string)))

(defun org-table-map-fields (f)
  (let ((mapped-table
	 (org-table-from-lisp
	  (mapcar '(lambda (row)
		     (if (eq row 'hline)
			 'hline
		       (mapcar f row)))
		  (org-table-to-lisp)))))
    (delete-region (org-table-begin) (org-table-end))
    (insert mapped-table)))

(defun org-table-mathify ()
  "Add $ signs around each field of the table"
  (interactive)
  (org-table-map-fields '(lambda (x) (concat "$" x "$"))))

;; Send test email with elisp
(defun send-test-email ()
  (interactive)
  (progn
    (mail)
    (mail-to) (insert "s.sinayoko@soton.ac.uk")
    (mail-subject) (insert "[TEST] Email test from Emacs")
    (mail-text) (insert "Automatically generated test email")
    (mail-send)
    (bury-buffer "*mail*")))
