;; Minor mode encapsulating my favourite keybindings. These should not
;; be overriden by other minor modes. They are global.

;;;###autoload
(define-minor-mode sam-keys-mode
  "Sam's keybindings, hopefully more convenient than emacs defaults. Put them at the head of minor-mode-map-alist to mask all other minor mode's bindings (Principle of List Surprise). "
  :lighter " Sam"
  :global t
  :keymap (let ((map (make-sparse-keymap)))
    ;; Make cursor movement keys under right hand's home-row.
    (define-key map "\M-j" 'backward-char)
    (define-key map "\M-l" 'forward-char)
    (define-key map "\M-i" 'previous-line)
    (define-key map "\M-k" 'next-line)
    (define-key map "\M-h" 'move-beginning-of-line)
    (define-key map (kbd "M-;") 'move-end-of-line)
    ;; Movements in terms of words and sentences
    (define-key map "\M-L" 'forward-word)
    (define-key map "\M-J" 'backward-word)
    (define-key map "\M-H" 'backward-sentence)
    (define-key map "\M-:" 'forward-sentence)
    (define-key map "\M-I" 'scroll-down)
    (define-key map "\M-K" 'scroll-up)
    (define-key map "\M-a" 'set-mark-command)
    (define-key map (kbd "C-M-i") 'back-to-indentation)
    ;; Buffer
    (define-key map "\M-f" 'ido-switch-buffer)
    (define-key map (kbd "M-c") 'ido-kill-buffer)
    (define-key map (kbd "C-M-c") 'sam/kill-help-buffer)
    ;; Delete
    (define-key map (kbd "M-'") 'zap-to-char)
    (define-key map (kbd "M-w") 'sam/backward-kill-word-or-kill-region) ;; so we can
    ;; Windows
    (define-key map "\M-0" 'delete-window)
    (define-key map "\M-1" 'delete-other-windows)
    (define-key map "\M-2" 'split-window-vertically)
    (define-key map "\M-3" 'split-window-horizontally)
    (define-key map "\M-o" 'other-window)
    (define-key map "\C-\M-u" 'winner-undo) ;; requires winner-mode
    (define-key map "\M-}"  'enlarge-window)
    (define-key map "\M-{"  'shrink-window)
    (define-key map "\M-]" 'enlarge-window-horizontally)
    (define-key map "\M-[" 'shrink-window-horizontally)
    (define-key map "\M-=" 'balance-windows)
    ;; Registers
    (define-key map (kbd "M-SPC") 'push-mark-no-activate)
    (define-key map (kbd "C-SPC") 'just-one-space)
    (define-key map "\M-\r" 'jump-to-mark)
    ;; Comments
    (define-key map "\C-cc"  'comment-region)
    (define-key map "\C-cu"  'uncomment-region)
    ;; Misc
    (define-key map "\M-g" 'goto-line)
    (define-key map (kbd "C-A") 'indent-relative) ; see also tab-to-tab-stops
    (define-key map (kbd "M-r") 'undo) ;; undo easily
    (define-key map "\M-m" 'dabbrev-expand) ;; dynamic expansions
    ;;   replace regexps interactively
    (define-key map "\C-c\C-r" 'query-replace-regexp)
    ;; My functions
    (define-key map (kbd "<f5>") 'sam/reload-configuration)
    (define-key map (kbd "C-,") 'sam/transpose-comma)
    (define-key map (kbd "C-c ;") 'sam/copy-buffer-file-name)
    (define-key map (kbd "C-o") 'sam/open-previous-line)
    (define-key map (kbd "C-M-o") 'sam/open-next-line)
    map))

;; Define the functions
(defun sam/copy-buffer-file-name ()
  "Copy buffer file name to clipboard"
  (interactive)
  (kill-new buffer-file-name)
  (message "copied %s" buffer-file-name))
(defun sam/reload-configuration ()
  "Reload .emacs file"
  (interactive)
  (load-file emacs-init-file))
;; Open previous / next line
(defun sam/open-next-line (arg)
  "Move to the next line and then opens a line.
      See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (indent-according-to-mode))
(defun sam/open-previous-line (arg)
  "Open a new line before the current one.
       See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (indent-according-to-mode))
(defun sam/backward-kill-word-or-kill-region (&optional arg)
  (interactive "p")
  (if (region-active-p)
      (copy-region-as-kill (region-beginning) (region-end))
    (backward-kill-word arg)))
(defun sam/transpose-comma (&optional N)
  "Transpose words around comma. Point needs to be in word before
  comma.
  Useful to transpose the arguments of a function
  definition when coding.
  TODO: allow for negative arguments
  "
  (interactive "p")
  (let (eol)
    (save-excursion
      (end-of-line)
      (setq eol (point)))
    (beginning-of-sexp)
    (if (re-search-forward "\\(\\w+\\), \\(\\w+\\)"  eol t 1)
	(replace-match "\\2, \\1")))
  (if (and N (> N 1))
      (transpose-comma (1- N))))

(defun sam/kill-help-buffer()
    "Kill buffer in other window"
    (interactive)
    ;;  (fset 'kill-help-buffer "\C-xoq")
    (save-excursion
      ;; Cycle window until we reach *Help* buffer
      (while (not (equal (buffer-name) "*Help*"))
        (select-window (next-window)))
      (View-quit)))

(provide 'sam-keys-mode)
