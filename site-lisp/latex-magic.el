;; Time-stamp: <2011-01-31 09:04:44 sinayoks>
;; Allows to fold outlines with org-cycle.
;; Put the following lines in .emacs file to bind to a M-f
;; (add-hook 'outline-minor-mode-hook 
;;           (lambda () 
;;             (define-key outline-minor-mode-map "\M-f" 'org-cycle)))

(add-hook 'LaTeX-mode-hook 
	  (lambda ()
	    (setq outline-regexp (concat "%+ \\|" outline-regexp))
	    (defun LaTeX-outline-level ()
	      (funcall 'my-LaTeX-outline-level))))

(defun my-LaTeX-outline-level ()
  "Find the level of current outline heading in an LaTeX document.

Version modified by Samueli to allow introduction of comments to hide equations and figures.
"
  (cond ((looking-at LaTeX-header-end) 1)
	((looking-at LaTeX-trailer-start) 1)
	((TeX-look-at TeX-outline-extra)
	 (max 1 (+ (TeX-look-at TeX-outline-extra)
		   (LaTeX-outline-offset))))
	(t
	 (save-excursion
	   (skip-chars-forward " \t")
	   (forward-char 1)
	   (cond ((looking-at "appendix") 1)
		 ((looking-at "documentstyle") 1)
		 ((looking-at "documentclass") 1)
		 ;; Next two lines modified by Samuel Sinayoko
		 ((looking-at " ") 6)
		 ((looking-at "% ") 7)
		 ((TeX-look-at LaTeX-section-list)
		  (max 1 (+ (TeX-look-at LaTeX-section-list)
			    (LaTeX-outline-offset))))
		 (t
		  (error "Unrecognized header")))))))


(defadvice LaTeX-insert-environment (after insert-%-around)
  "Insert '% environment' and '% ' around the environment"
  (save-excursion
    (LaTeX-find-matching-end)
    (newline)
    (insert "% ")
    (forward-line -2)
    (LaTeX-find-matching-begin)
    (insert "% env\n")))
(ad-activate 'LaTeX-insert-environment)

(provide 'latex-magic)