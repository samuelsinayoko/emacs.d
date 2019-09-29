(defvar pytoc-py-buffer nil "Buffer containing python file")
(defvar pytoc-toc-buffer "*pytoc*" "Buffer containing table of content")
(defvar pytoc-markers nil "List of markers storing the position of each heading in the file visited by `pytoc-py-buffer'")
(defvar pytoc-ignore-regexp 
;  "[    ]*\\(#- +\n\\|if \\|elif \\|else \\|while \\|for \\|try \\|except \\|with \\)"
  "[    ]*\\(#- +\n\\|class\\|def\\)"
  "Ignore headings with these regexps. This is to avoid clutering the table of contents.")
(defvar pytoc-ignore-classes t "ignore class definitions in toc")
(defvar pytoc-ignore-defs t "ignore function definitions in toc")
(defvar pytoc-max-level 2 "max level shown in blocks")
(defvar pytoc-file-max-level 0 "max level in this file.")
(defvar pytoc-file-max-indentation 0 "max indentation in python file.")
(defvar pytoc-vertical t "Vertical table of content")
(defvar pytoc-min-indentation 0 "min indentation level in toc")
(defvar pytoc-max-indentation 1 "max indentation level in toc")
(defun pytoc-ignore-regexp ()
  "return pytoc-ignore-regexp"
  (let* ((start "[ ]*\\(" ) 
	(end "\\)" )
	(sep "\\|")
	(empty-title "#- +$")
	(class "class")
	(def "def")
	(regexp (concat start empty-title)))
    (when pytoc-ignore-classes
      (setq regexp (concat regexp sep class)))
    (when pytoc-ignore-defs
      (setq regexp (concat regexp sep def)))
    (concat regexp end)))
;; (defun pytoc-toggle-classes ()
;;   "toggle pytoc-ignore-classes"
;;   (if pytoc-ignore-classes
;;       (setq pytoc-ignore-classes nil)
;;       (setq pytoc-ignore-classes t))
;;   (pytoc-rescan))

(defun pytoc-toggle-defs-and-classes ()
  "toggle pytoc-ignore-defs-and-classes"
  (interactive)
  (if pytoc-ignore-defs
      (setq pytoc-ignore-defs nil pytoc-ignore-classes nil)
      (setq pytoc-ignore-defs t pytoc-ignore-classes t))
  (pytoc-rescan))

(defun pytoc-toggle-defs ()
  "toggle pytoc-ignore-defs"
  (interactive)
  (if pytoc-ignore-defs
      (setq pytoc-ignore-defs nil)
      (setq pytoc-ignore-defs t))
  (pytoc-rescan))

			     
(defvar pytoc-mode-map 
  (let ((map (make-sparse-keymap)))
    (loop for x in
	  '(("k"        . forward-line)
	    ("i"        . previous-line)
	    ("r"        . pytoc-rescan)
	    ("q"        . pytoc-quit)
	    ("Q"     . pytoc-goto-starting-point)
	    ;; interaction with python buffer
	    ("j"        . pytoc-goto-heading)
	    (" "        . pytoc-goto-heading)
	    ("l"        . pytoc-goto-heading-and-hide)
	    ("\r"       . pytoc-goto-heading-and-hide)
	    ("v"        . pytoc-view-heading)
	    ("."        . pytoc-view-starting-point)
	    ;; filtering
	    ("d"        . pytoc-toggle-defs-and-classes)
	    ("+"        . pytoc-increment-max-level)
	    ("-"        . pytoc-decrement-max-level)
	    (">"        . pytoc-increment-min-indentation)
	    ("<"        . pytoc-decrement-max-indentation))
	  do (define-key map (car x) (cdr x)))
    map)
    "Keymap used for *pytoc* buffer")

(defun pytoc-rescan ()
  "Regenerate table of content of python file."
  (interactive)
  (defun get-chomped-line ()
    "Return current line without spaces at the beginning"
    (let (beg end)
      (save-excursion
	(beginning-of-line)
	(skip-chars-forward " ")
	(setq beg (point))
	(end-of-line)
	(setq end (point)))
      (buffer-substring beg end)))
  (let (line previous-line next-line)
    ;; Save neighboring lines to come back later
    (beginning-of-line)
    (setq line (get-chomped-line))
    (let ((current-indentation (pytoc-indentation-level)))
      (save-excursion
	(catch 'exit 
	  (while (or (= (pytoc-indentation-level) current-indentation)
		     (not (looking-at " *#-+ ")))
	    (when (bobp) (throw 'exit nil))
	    (forward-line -1)))
	(setq previous-line (get-chomped-line)))
      (save-excursion
	(catch 'exit 
	  (while (or (= (pytoc-indentation-level) current-indentation)
		     (not (looking-at " *#-+ ")))
	    (when (eobp) (throw 'exit nil))
	    (forward-line 1)))
	(setq next-line (get-chomped-line))))
    ;; Regenerate toc and come back
    (with-current-buffer pytoc-py-buffer
      (pytoc-make-toc))
    (beginning-of-buffer)
    (cond 
     ((search-forward line nil t) (goto-char (match-beginning 0)))
     ((search-forward previous-line nil t) (progn (beginning-of-line) 
						  (goto-char (match-beginning 0))))
     ((search-forward next-line nil t) (progn (beginning-of-line) 
					      (goto-char (match-beginning 0))))))
  (pytoc-show-hook))

(defun pytoc-view-heading ()
  (interactive)
  (pytoc-goto-heading)
  (select-window (pytoc-toc-window)))

(defun pytoc-view-starting-point ()
  (interactive)
  (let ((position (marker-position (car pytoc-markers))))
    (switch-to-buffer-other-window pytoc-py-buffer)
    (goto-char position)
    (switch-to-buffer-other-window pytoc-toc-buffer)
    (pytoc-sync)))

(defun pytoc-toc-window ()
  "Return current window of *pytoc* if it exists and nil otherwise"
  (get-buffer-window pytoc-toc-buffer))

(defun pytoc-quit ()
  (interactive)
  (if (not (one-window-p)) 
      (delete-window)
    (switch-to-buffer pytoc-py-buffer)))
  

    
(defun pytoc-mode ()
  "Major mode for moving around easily in a Python file. 
Press `?' for a summary of important key bindings.

Here are all local bindings.

\\{pytoc-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'pytoc-mode
        mode-name "pytoc")
  (use-local-map pytoc-mode-map)
  (setq truncate-lines t)
  (hl-line-mode) ; highlight current line
  ;; (add-hook 'post-command-hook 'reftex-toc-post-command-hook nil t)
  ;; (add-hook 'pre-command-hook  'reftex-toc-pre-command-hook nil t)
  ;;(run-hooks 'reftex-toc-mode-hook)
)

(defun pytoc-make-toc()
     "Generate table of content for current python buffer in *pytoc* buffer."
     (interactive)
     (setq pytoc-py-buffer (current-buffer) pytoc-markers nil)
     (pytoc-save-starting-point)
     (get-buffer-create pytoc-toc-buffer)
     ;; Clear *pytoc* buffer
     (with-current-buffer pytoc-toc-buffer
       (setq buffer-read-only nil)
       (when (buffer-string)
	 (erase-buffer)))
     ;; Generate table of content for current (python) file
     (let ((init-heading-pos-pybuffer 
	    (save-excursion (outline-back-to-heading 1) (point)))
	   (init-heading-pos-tocbuffer (point-min))
	   (ignore-regexp (pytoc-ignore-regexp))
	   init-heading-p 
	   current-heading)
       (outline-map-region 
	(lambda ()
	  (when (looking-at " *#-+ ")  ; a bloc
	    (when (> (pytoc-bloc-level) pytoc-file-max-level)
	      (setq pytoc-file-max-level (pytoc-bloc-level)))
	    (when (> (pytoc-indentation-level) pytoc-file-max-indentation)
	      (setq pytoc-file-max-indentation (pytoc-indentation-level))))
	  (unless (or (looking-at ignore-regexp) 
		      (> (pytoc-outline-level) pytoc-max-level)
		      (> (pytoc-indentation-level) pytoc-max-indentation)
		      (< (pytoc-indentation-level) pytoc-min-indentation))
	    ;; save position and display heading
	    (if (= (match-beginning 0) init-heading-pos-pybuffer)
		(setq init-heading-p t))
	    (setq current-heading (thing-at-point 'line))
	    (push (point-marker) pytoc-markers)
	    (with-current-buffer pytoc-toc-buffer
	      (when init-heading-p
		  (setq init-heading-pos-tocbuffer (point))
		  (setq init-heading-p nil))
	      (insert (pytoc-fontify current-heading)))))
	  (point-min)
	  (point-max))
       (with-current-buffer pytoc-toc-buffer 
	 (goto-char init-heading-pos-tocbuffer)
	 (pytoc-mode)
	 ;;(set-window-hscroll (selected-window) (* 4 pytoc-min-indentation))
	 (setq buffer-read-only t)))
     (setq  pytoc-markers (nreverse pytoc-markers)))

(defun pytoc-show-hook ()
  "Function ran after everything else to modify how things are displayed"
  (pytoc-rm-leftmost-indent))

(defun pytoc-rm-leftmost-indent ()
  "Clear leftmost indentation if present."
  (setq buffer-read-only nil)
  (save-excursion
    (let* ((beg (point-min))
	   (skip (save-excursion 
		   (goto-char (point-min)) 
		   (* 4 (pytoc-indentation-level))))
	   (end (save-excursion
		 (goto-char (point-max)) 
		 (forward-line -1)
		 (+ (point) skip))))
      (delete-rectangle beg end)))
  (setq buffer-read-only t))

(defun pytoc-bloc-level ()
  "Return level of current bloc.
#- level 1
#-- level 2
#--- level 3
..."
  (let ((block-regexp " *#\\(-+\\) "))
    (if (looking-at block-regexp)
	(length (match-string 1))
      (warn "Not a bloc. Setting level to 0.")
      0)))
(defun pytoc-increment-max-level  ()
  "Increment pytoc-max-level"
  (interactive)
  (unless (= pytoc-max-level pytoc-file-max-level)
    (incf pytoc-max-level)
    (pytoc-rescan)))

(defun pytoc-decrement-max-level  ()
  "Increment pytoc-max-level"
  (interactive)
  (unless (= pytoc-max-level 1)
    (decf pytoc-max-level)
    (pytoc-rescan)))

(defun pytoc-increment-min-indentation  ()
  "Increment `pytoc-min-indentation'. Cycles between 0 and `pytoc-min-indentation'."
  (interactive)
  (if (< pytoc-min-indentation pytoc-max-indentation)
      (incf pytoc-min-indentation)
    (setq pytoc-min-indentation 0))
  (pytoc-rescan))

(defun pytoc-decrement-max-indentation  ()
  "Decrement `pytoc-max-indentation'. Cycles between `pytoc-min-indentation' and `pytoc-file-max-indentation'."
  (interactive)
  (if (> pytoc-max-indentation pytoc-min-indentation)
      (decf pytoc-max-indentation)
    (setq pytoc-max-indentation pytoc-file-max-indentation))
  (pytoc-rescan))


(defun pytoc-outline-level ()
  "Return current outline level"
  (let ((def-or-class-regexp " *\\(class\\|def\\) "))
    (if (looking-at def-or-class-regexp)
	0
      (pytoc-bloc-level))))

(defun pytoc-indentation-level ()
  "Return current indentation level"
  (save-excursion
    (beginning-of-line)
    (/ (skip-chars-forward " ") 4)))

(defun pytoc-save-starting-point ()
  "Push starting point as a marker in pytoc-markers"
  (if (consp pytoc-markers)
      (setcar pytoc-markers (point-marker))
    (push (point-marker) pytoc-markers)))

(defun pytoc-show-toc ()
  "Show python table of content in other window."
  (interactive)
  (unless (get-buffer pytoc-toc-buffer)
    (pytoc-make-toc))
  (pytoc-save-starting-point)
  (let ((w (pytoc-toc-window)))
    (if (window-live-p w)
	(select-window w)
      (if pytoc-vertical
	  (split-window-horizontally (floor (* (window-width) 0.3)))
	(split-window-vertically (floor (* (window-height) 0.3))))
      (switch-to-buffer pytoc-toc-buffer)))
  (pytoc-sync)
  (pytoc-show-hook))

(defun pytoc-sync ()
  "Set line to current heading in `pytoc-py-buffer'."
  (let* ((py-heading
	 (with-current-buffer pytoc-py-buffer
	   (save-excursion 
	     (outline-back-to-heading)
	     (while (or (looking-at pytoc-ignore-regexp)
			(> (pytoc-outline-level) pytoc-max-level)
			(> (pytoc-indentation-level) pytoc-max-indentation)
			(< (pytoc-indentation-level) pytoc-min-indentation))
	       (forward-line -1)
	       (outline-back-to-heading))
	     (let ((beg (match-beginning 0))
		   (end (save-excursion (end-of-line) (point))))
	       (buffer-substring-no-properties beg end))))))
    (save-excursion
      (goto-char (point-min))
      (search-forward py-heading))
    (goto-char (match-beginning 0))))
	
	   
(defun pytoc-goto-heading ()
  "Goto current heading"
  (interactive)
  (let	((position (marker-position 
		    (nth (line-number-at-pos) pytoc-markers))))
    (switch-to-buffer-other-window pytoc-py-buffer)
    (goto-char position))
  ;; reveal entry if it is currently hidden
  (when (overlays-at (point)) 
    (show-entry)))

(defun pytoc-goto-starting-point ()
  "Goto starting point"
  (interactive)
  (pytoc-view-starting-point)
  (pytoc-quit))


(defun pytoc-goto-heading-and-hide ()
  "Goto current heading"
  (interactive)
  (pytoc-goto-heading)
  (select-window (pytoc-toc-window))
  (delete-window))


(defun pytoc-goto-heading-old ()
  "Goto current heading"
  (interactive)
  (let (heading)
    (save-excursion
      (outline-back-to-heading)
      (setq heading (thing-at-point 'line)))
    (switch-to-buffer-other-window pytoc-py-buffer)
    (save-excursion
      (goto-char (point-min))
      (search-forward heading))
    (goto-char (match-beginning 0))
    ;; reveal entry if it is currently hidden
    (when (overlays-at (point)) 
	(show-entry))))
	
(defun pytoc-fontify (heading)
  "Fontify heading"
  (let ((unchanged-regexp "[    ]*\\(class\\|def\\) "))
    (if (looking-at unchanged-regexp) 
	(heading)
      (with-temp-buffer
	(insert heading)
	(goto-char (point-min))
	(when (looking-at "[    ]*#\\(-+\\) ")
	  (let ((level (length (match-string 1)))
		(bol (save-excursion (beginning-of-line) (point)))
		(eol (save-excursion (end-of-line) (point))))
	    (put-text-property bol eol 'face (nth (1- level) pytoc-level-faces))))
	(buffer-string)))))

(defvar pytoc-level-faces
  '(pytoc-level-1 pytoc-level-2 pytoc-level-3 pytoc-level-4 pytoc-level-5 pytoc-level-6 pytoc-level-7 pytoc-level-8)
  "List of faces applied to each user heading in buffer *pytoc*")
  
(defgroup pytoc-faces nil
  "Faces in pytoc."
  :tag "Pytoc Faces")

(defface pytoc-level-1 ;; originally copied from font-lock-function-name-face
  (org-compatible-face 'outline-1
    '((((class color) (min-colors 88) (background light)) (:foreground "Blue1"))
      (((class color) (min-colors 88) (background dark)) (:foreground "LightSkyBlue"))
      (((class color) (min-colors 16) (background light)) (:foreground "Blue"))
      (((class color) (min-colors 16) (background dark)) (:foreground "LightSkyBlue"))
      (((class color) (min-colors 8)) (:foreground "blue" :bold t))
      (t (:bold t))))
  "Face used for level 1 headlines."
  :group 'pytoc-faces)

(defface pytoc-level-2 ;; originally copied from font-lock-variable-name-face
  (org-compatible-face 'outline-2
    '((((class color) (min-colors 16) (background light)) (:foreground "DarkGoldenrod"))
      (((class color) (min-colors 16) (background dark))  (:foreground "LightGoldenrod"))
      (((class color) (min-colors 8)  (background light)) (:foreground "yellow"))
      (((class color) (min-colors 8)  (background dark))  (:foreground "yellow" :bold t))
      (t (:bold t))))
  "Face used for level 2 headlines."
  :group 'pytoc-faces)

(defface pytoc-level-3 ;; originally copied from font-lock-keyword-face
  (org-compatible-face 'outline-3
    '((((class color) (min-colors 88) (background light)) (:foreground "Purple"))
      (((class color) (min-colors 88) (background dark))  (:foreground "Cyan1"))
      (((class color) (min-colors 16) (background light)) (:foreground "Purple"))
      (((class color) (min-colors 16) (background dark))  (:foreground "Cyan"))
      (((class color) (min-colors 8)  (background light)) (:foreground "purple" :bold t))
      (((class color) (min-colors 8)  (background dark))  (:foreground "cyan" :bold t))
      (t (:bold t))))
  "Face used for level 3 headlines."
  :group 'pytoc-faces)

(defface pytoc-level-4   ;; originally copied from font-lock-comment-face
  (org-compatible-face 'outline-4
    '((((class color) (min-colors 88) (background light)) (:foreground "Firebrick"))
      (((class color) (min-colors 88) (background dark))  (:foreground "chocolate1"))
      (((class color) (min-colors 16) (background light)) (:foreground "red"))
      (((class color) (min-colors 16) (background dark))  (:foreground "red1"))
      (((class color) (min-colors 8) (background light))  (:foreground "red" :bold t))
      (((class color) (min-colors 8) (background dark))   (:foreground "red" :bold t))
      (t (:bold t))))
  "Face used for level 4 headlines."
  :group 'pytoc-faces)

(defface pytoc-level-5 ;; originally copied from font-lock-type-face
  (org-compatible-face 'outline-5
    '((((class color) (min-colors 16) (background light)) (:foreground "ForestGreen"))
      (((class color) (min-colors 16) (background dark)) (:foreground "PaleGreen"))
      (((class color) (min-colors 8)) (:foreground "green"))))
  "Face used for level 5 headlines."
  :group 'pytoc-faces)

(defface pytoc-level-6 ;; originally copied from font-lock-constant-face
  (org-compatible-face 'outline-6
    '((((class color) (min-colors 16) (background light)) (:foreground "CadetBlue"))
      (((class color) (min-colors 16) (background dark)) (:foreground "Aquamarine"))
      (((class color) (min-colors 8)) (:foreground "magenta"))))
  "Face used for level 6 headlines."
  :group 'pytoc-faces)

(defface pytoc-level-7 ;; originally copied from font-lock-builtin-face
  (org-compatible-face 'outline-7
    '((((class color) (min-colors 16) (background light)) (:foreground "Orchid"))
      (((class color) (min-colors 16) (background dark)) (:foreground "LightSteelBlue"))
      (((class color) (min-colors 8)) (:foreground "blue"))))
  "Face used for level 7 headlines."
  :group 'pytoc-faces)

(defface pytoc-level-8 ;; originally copied from font-lock-string-face
  (org-compatible-face 'outline-8
    '((((class color) (min-colors 16) (background light)) (:foreground "RosyBrown"))
      (((class color) (min-colors 16) (background dark)) (:foreground "LightSalmon"))
      (((class color) (min-colors 8)) (:foreground "green"))))
  "Face used for level 8 headlines."
  :group 'pytoc-faces)

(provide 'pytoc)