;; Some code for an IPython REPL. Have been having problems with python-mode.el and python.el so rolling out my own

;; variables:
;; - sam-ipython-program-command
;; - sam-ipython-terminal-buffer *IPython*
;; - sam-ipython-script-buffer "script-filename"



(defcustom sam-ipython-program-command "ipython" "IPython interpreter command")
(defcustom sam-ipython-program-command-args "--matplotlib=qt4" "IPython interpreter command")
(defcustom sam-ipython-process-name "ipython" "IPython process name")
(defvar sam-ipython-script-buffer nil "Script buffer from which the terminal was lauched")
(defvar sam-ipython-view 0 "View giving layout of script and terminal")
(defconst sam-ipython-terminal-buffer (format "*%s*" sam-ipython-process-name) "Name of the IPython buffer")
;; Stolen from ipython.el
;; (defvar sam-ipython-prompt-regexp "\\(?:
;; In \\[[0-9]+\\]: *.*
;; ----+> \\(.*
;; \\)[\n]?\\)\\|\\(?:
;; In \\[[0-9]+\\]: *\\(.*
;; \\)\\)\\|^[ ]\\{3\\}[.]\\{3,\\}: *\\(.*
;; \\)"
;;   "A regular expression to match the IPython input prompt and the python
;; command after it. The first match group is for a command that is rewritten,
;; the second for a 'normal' command, and the third for a multiline command.")
(defvar sam-ipython-prompt-regexp "In \\[[0-9]+\\]: "
  "A regular expression to match the IPython input prompt")

(defun sam-ipython-get-process ()
  "Return the IPython process"
  (get-process sam-ipython-process-name))

(defun sam-ipython-send-cmd (cmd)
  "Send CMD to IPython process"
    (message "%s" cmd)
    (term-send-string (sam-ipython-get-process) cmd)
    (term-send-string (sam-ipython-get-process) "\n"))

(defun sam-ipython-run-file (filename)
  "Run file in *ipython* terminal (>  run -i FILENAME)"
  (sam-ipython-send-cmd (format "%%run -i %s" filename)))

(defun sam-ipython-run-file-time (filename)
  "Run file in *ipython* terminal and time the run (>  run -i -t FILENAME)"
  (sam-ipython-send-cmd (format "%%run -t %s" filename)))

(defun sam-ipython-run-file-profile (filename)
  "Run file in *ipython* terminal and profile the run (>  run -i -p FILENAME)"
  (sam-ipython-send-cmd (format "%%run -p %s" filename)))


(defun sam-ipython-terminal (&optional other-ipython-p)
  "Start if needed and switch to IPython terminal buffer"
  (interactive "P")
  (princ other-ipython-p)
  (let (cmd)
    (if  other-ipython-p
	;;(setq cmd (read-shell-command "IPython command: "))
	(setq cmd (read-string "IPython command: "))
      (setq cmd sam-ipython-program-command))
    (princ cmd)
    ;; Set script buffer
    (setq sam-ipython-script-buffer (current-buffer))
    ;; Adapted from `term' function in term.el to get the right names
    (set-buffer (make-term sam-ipython-process-name cmd  nil sam-ipython-program-command-args))
    (rename-buffer sam-ipython-terminal-buffer)
    (term-mode)
    (term-char-mode)
    (setq term-prompt-regexp sam-ipython-prompt-regexp)
    (pop-to-buffer sam-ipython-terminal-buffer)
    ;; Define local keys
    ;;  - doesn't work with Sam's minor mode...
    (local-set-key (kbd "M-o") 'other-window)
    (local-set-key (kbd "C-c C-v") 'sam-ipython-toggle-view)
    (local-set-key (kbd "M-f") 'ido-switch-buffer)
    (local-set-key (kbd "M-c") 'ido-kill-buffer)
    (local-set-key (kbd "C-a") 'term-send-raw)
    (local-set-key (kbd "M-j") 'term-send-left)
    (local-set-key (kbd "M-l") 'term-send-right)
    (when (fboundp 'yas-minor-mode)
      (yas-minor-mode -1))
    )
  )


(defun sam-ipython-run-buffer ()
  "Send the buffer to the inferior IPython process."
  (interactive)
  ;; new implementation
  (let ((temp-file (make-temp-file
		    (format "%s_"
			    (file-name-sans-extension
			     (file-name-nondirectory (buffer-file-name))))
		    nil ".ipython")))
    (write-region (point-min) (point-max) temp-file)
    (sam-ipython-run-file temp-file)))

(defun sam-ipython-run-buffer-time ()
  "Send the buffer to the inferior IPython process and time."
  (interactive)
  ;; new implementation
  (let ((temp-file (make-temp-file
		    (format "%s_"
			    (file-name-sans-extension
			     (file-name-nondirectory (buffer-file-name))))
		    nil ".ipython")))
    (write-region (point-min) (point-max) temp-file)
    (sam-ipython-run-file-time temp-file)))

(defun sam-ipython-run-buffer-profile ()
  "Send the buffer to the inferior IPython process and profile."
  (interactive)
  ;; new implementation
  (let ((temp-file (make-temp-file
		    (format "%s_"
			    (file-name-sans-extension
			     (file-name-nondirectory (buffer-file-name))))
		    nil ".ipython")))
    (write-region (point-min) (point-max) temp-file)
    (sam-ipython-run-file-profile temp-file)))

;; (defun sam-ipython-run-region (start end)
;;   "Send the current region to the IPython process."
;;   (interactive "r")
;;   ;; Copy region to kill ring
;;   (copy-region-as-kill start end)
;;   (sam-ipython-send-cmd "%paste"))

(defun sam-ipython-run-region (start end)
  "Send the current region to the IPython process."
  (interactive "r")
  ;; -------------------------------------------------------
  ;; Implementation that relies on Tk (needs some X-like window system to be running)
  ;; -------------------------------------------------------
  ;; Copy region to kill ring
  ;;(copy-region-as-kill start end)
  ;;(sam-ipython-send-cmd "%paste")
  ;; -------------------------------------------------------
  ;; New implementation (!!! requires IPython 2.0 for quiet output
  ;; -q. Remove it if using older version of IPython)
  ;; -------------------------------------------------------
  (sam-ipython-send-cmd (concat "%cpaste -q\n" (buffer-substring start end) "\n--"))
)

(defun sam-ipython-run-statement ()
  "Send the current statement to the IPython process and move to next
statement. "
  (interactive)
  (let (start)
    (beginning-of-line)
    (setq start (point))
    (py-next-statement 1)
    (sam-ipython-run-region start (point))))

(defun sam-ipython-toggle-view ()
  "Toggle view between script | terminal | left right script+terminal | top bottom script+terminal"
  (interactive)
  (setq sam-ipython-view (% (1+ sam-ipython-view) 4))
  (sam-ipython-set-view sam-ipython-view))

(defun sam-ipython-set-view (view)
  "Set ipython view"
  (when (= view 0) (sam-ipython-script-view))
  (when (= view 1) (sam-ipython-vertical-view))
  (when (= view 2) (sam-ipython-horizontal-view))
  (when (= view 3) (sam-ipython-terminal-view)))

(defun sam-ipython-script-view ()
  "Display the script file only"
  (switch-to-buffer sam-ipython-script-buffer)
  (delete-other-windows))

(defun sam-ipython-terminal-view ()
  "Display the script file only"
  (switch-to-buffer sam-ipython-terminal-buffer)
  (delete-other-windows))

(defun sam-ipython-vertical-view ()
  "Display the script on top and the terminal at the bottom"
  (sam-ipython-script-view)
  (split-window-vertically)
  (other-window 1)
  (switch-to-buffer sam-ipython-terminal-buffer))

(defun sam-ipython-horizontal-view ()
  "Display the script on the left and the terminal on the right"
  (sam-ipython-script-view)
  (split-window-horizontally)
  (other-window 1)
  (switch-to-buffer sam-ipython-terminal-buffer))


;;;###autoload
(define-minor-mode sam-ipython-mode
  "Define IPython REPL based on terminal mode to have access to all the IPython terminal goodness."
  :ligher " IPy"
  :keymap (let ((map (make-sparse-keymap)))
    ;; example definition
    ;;(define-key-map (kbd "M-o") 'other-window)
    (define-key map (kbd "C-c !") 'sam-ipython-terminal)
    (define-key map (kbd "C-c C-v") 'sam-ipython-toggle-view)
    (define-key map (kbd "C-c C-c") 'sam-ipython-run-buffer)
    (define-key map (kbd "C-c C-t") 'sam-ipython-run-buffer-time)
    (define-key map (kbd "C-c C-p") 'sam-ipython-run-buffer-profile)
    (define-key map (kbd "M-n") 'sam-ipython-run-region)
    ;;(define-key map (kbd "C-c C-v") 'ipython-view)
    map))

(provide 'sam-ipython)
;;http://stackoverflow.com/questions/13102494/buffer-locally-overriding-minor-mode-key-bindings-in-emacs
;; (add-hook '<major-mode>-hook
;;   (lambda ()
;;     (let ((oldmap (cdr (assoc '<minor-mode> minor-mode-map-alist)))
;;           (newmap (make-sparse-keymap)))
;;       (set-keymap-parent newmap oldmap)
;;       (define-key newmap [<thekeyIwanttohide>] nil)
;;       (make-local-variable 'minor-mode-overriding-map-alist)
;;       (push `(<minor-mode> . ,newmap) minor-mode-overriding-map-alist))))
