; require outline-magic.el by CarstenDominik found here: 
; http://www.astro.uva.nl/~dominik/Tools/outline-magic.el
; modified code here by Nikwin slightly found here: 
;  http://stackoverflow.com/questions/1085170/how-to-achieve-code-folding-effects-in-emacs/1085551#1085551
; Time-stamp: <2012-04-20 23:20:29 sinayoks>
; Modified outline-regexp and added outline-heading-alist.
(require 'pytoc)
(add-hook 'python-mode-hook 'my-python-outline-hook)
;; TODO: put this into hook: current version redefines org-cycle-internal-local globally
(defadvice org-cycle-internal-local (around for-python-code)
  "Modify org-cycle-interla-local in python-mode"
  (if (eq major-mode 'python-mode) 
      (py-org-cycle-internal-local)
    ad-do-it))
(ad-activate 'org-cycle-internal-local)

(defun py-org-cycle-internal-local ()
  "Do the local cycling action.

Adapted from org-cycle-internal-local from org.el. Modified by
Samuel Sinayoko for use with python code.
"
  (let ((goal-column 0) eoh eol eos level has-children children-skipped)
    ;; First, some boundaries
    (save-excursion
      (org-back-to-heading)
      (setq level (funcall outline-level))
      (save-excursion
	(beginning-of-line 2)
	(if (or (featurep 'xemacs) (<= emacs-major-version 21))
	    ; XEmacs does not have `next-single-char-property-change'
	    ; I'm not sure about Emacs 21.
	    (while (and (not (eobp)) ;; this is like `next-line'
			(get-char-property (1- (point)) 'invisible))
	      (beginning-of-line 2))
	  (while (and (not (eobp)) ;; this is like `next-line'
		      (get-char-property (1- (point)) 'invisible))
	    (goto-char (next-single-char-property-change (point) 'invisible))
	    (and (eolp) (beginning-of-line 2))))
	(setq eol (point)))
      (outline-end-of-heading)   (setq eoh (point))
      (save-excursion
	(outline-next-heading)
	(setq has-children (and (org-at-heading-p t)
				(> (funcall outline-level) level))))
      ;; if we're in a list, org-end-of-subtree is in fact org-end-of-item.
      (if (org-at-item-p)
	  (setq eos (if (and (org-end-of-item) (bolp))
			(1- (point))
		      (point)))
	(org-end-of-subtree t)
	(unless (eobp) 
	  ;; next two lines modified by S. Sinayoko for optimal use with python
	  (skip-chars-forward " \t") 
	  (skip-chars-forward "\n"))
	(setq eos (if (eobp) (point) (1- (point))))))
    ;; Find out what to do next and set `this-command'
    (cond
     ((= eos eoh)
      ;; Nothing is hidden behind this heading
      (run-hook-with-args 'org-pre-cycle-hook 'empty)
      (message "EMPTY ENTRY")
      (setq org-cycle-subtree-status nil)
      (save-excursion
	(goto-char eos)
	(outline-next-heading)
	(if (org-invisible-p) (org-flag-heading nil))))
     ((and (or (>= eol eos)
	       (not (string-match "\\S-" (buffer-substring eol eos))))
	   (or has-children
	       (not (setq children-skipped
			  org-cycle-skip-children-state-if-no-children))))
      ;; Entire subtree is hidden in one line: children view
      (run-hook-with-args 'org-pre-cycle-hook 'children)
      (org-show-entry)
      (show-children)
      (message "CHILDREN")
      (save-excursion
	(goto-char eos)
	(outline-next-heading)
	(if (org-invisible-p) (org-flag-heading nil)))
      (setq org-cycle-subtree-status 'children)
      (run-hook-with-args 'org-cycle-hook 'children))
     ((or children-skipped
	  (and (eq last-command this-command)
	       (eq org-cycle-subtree-status 'children)))
      ;; We just showed the children, or no children are there,
      ;; now show everything.
      (run-hook-with-args 'org-pre-cycle-hook 'subtree)
      (outline-flag-region eoh eos nil)
      (message (if children-skipped "SUBTREE (NO CHILDREN)" "SUBTREE"))
      (setq org-cycle-subtree-status 'subtree)
      (run-hook-with-args 'org-cycle-hook 'subtree))
     (t
      ;; Default action: hide the subtree.
      (run-hook-with-args 'org-pre-cycle-hook 'folded)
      (outline-flag-region eoh eos t)
      (message "FOLDED")
      (setq org-cycle-subtree-status 'folded)
      (run-hook-with-args 'org-cycle-hook 'folded)))))

(defun mypy-outline-level () ;; TODO
  "Compute the level of current header.

Make sure the function and classes definitions, and the control commands have always a lower level than the user  defined blocs (starting with '#- '), while respecting the indentation level.  
"
  (let (indentation level)
    (save-excursion
      (skip-chars-forward " ")
      (setq indentation (current-column))
      (setq level
	    (when (looking-at outline-regexp)
	      (or (cdr (assoc (match-string 0) outline-heading-alist))
		  (- (match-end 0) (match-beginning 0)))))
      (+ (* 100 indentation) level))))

;; (defun py-outline-next-heading ()
;;   "Move to the next (possibly invisible) heading line or to change of indentation."
;;   (interactive)
;;   ;; Make sure we don't match the heading we're at.
;;   (if (and (bolp) (not (eobp))) (forward-char 1))
;;   (let (il0 il1)
;;     (setq il0 (py-outline-level)) ; current indentation level
;;     (while (true)
;;       (setq il1 (
;;     (if (re-search-forward (concat "^\\(?:" outline-regexp "\\)")
;; 			   nil 'move)
;; 	(goto-char (match-beginning 0))))

(defun my-python-outline-hook ()
  ;;(setq outline-regexp "[    ]*\\(#-+\\|class\\|def\\|if\\|elif\\|else\\|while\\|for\\|try\\|except\\|with\\) ")
  ;; (setq outline-heading-alist
  ;; 	'(("def " . 10) ("class " . 10) 
  ;; 	  ("if " . 11) ("for " . 11) ("while " . 11) ("try" . 11)
  ;; 	  ("elif " . 12) ("else" . 12) ("except" . 12) ("with" . 12)))
  (setq outline-regexp "[    ]*\\(#-+\\|class\\|def\\) ")
  (setq outline-heading-alist
	'(("def " . 10) ("class " . 10))) 
  (setq outline-level 'py-outline-level)
  (outline-minor-mode t)
  ;(hide-body)
  ;(show-paren-mode 1)
  (define-key py-mode-map [M-f] 'outline-cycle)
  ;; Display table of content in other window for easy navigation
  (define-key py-mode-map "\M-[" 'pytoc-show-toc)
  (define-key outline-minor-mode-map [M-down] 'outline-move-subtree-down)
  (define-key outline-minor-mode-map [M-up] 'outline-move-subtree-up)
)


(provide 'python-magic)