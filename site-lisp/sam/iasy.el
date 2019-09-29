
;; Some code for an Asymptote REPL. Much better for learning and exploring! 
;; This is all adapted from js-mode.el.
;;
;; - TODO add error handling to asy-view
;; - TODO tags-file-name: improve create tags command
;; - TODO make all settings changeble interactively!
;; - TODO command to get the source of a command (use TAGS? to asy source code?)
;; - TODO debugging: help with setting / clearing breakpoints (bp command?)
;; - help with setting / chaning directory : use string cd(string);

;; - DONE command to get the documentation of a command (call info?) C-h S
;; - DONE extract output file from buffer
;; - DONE integrate with docview (auto-revert-mode) instead of external pdfviewer
;; - DONE integrate this to asymptote mode: 
;;     -> put all shortcuts in one function and add hook to that function to 
;;       asy-mode.




(require 'comint)

(provide 'iasy)

(defcustom inferior-asy-program-command "asy -f pdf" "Asymptote interpreter command")

(defgroup inferior-asy nil
  "Run a asymptote process in a buffer."
  :group 'inferior-asy)

(defcustom inferior-asy-mode-hook nil
  "*Hook for customizing inferior-asy mode."
  :type 'hook
  :group 'inferior-asy)

(defvar asy-settings-outformat "pdf" "Default format of output files for Asymptote.")

(defvar asy-tags-table (expand-file-name "~/.tags/asymptote/TAGS") "Tags table for asymtpote source code.")

;;;###autoload
(defun run-asy (cmd &optional dont-switch-p)
  "Run an inferior Asymptote process, input and output via buffer `*js*'.
If there is a process already running in `*js*', switch to that buffer.
With argument, allows you to edit the command line (default is value
of `inferior-asy-program-command').
Runs the hook `inferior-asy-mode-hook' \(after the `comint-mode-hook'
is run).
\(Type \\[describe-mode] in the process buffer for a list of commands.)"

  (interactive (list (if current-prefix-arg
			 (read-string "Run asy: " inferior-asy-program-command)
			 inferior-asy-program-command)))
  (if (not (comint-check-proc "*asy*"))
      (save-excursion (let ((cmdlist (split-string cmd)))
	(set-buffer (apply 'make-comint "asy" (car cmdlist)
			   nil (cdr cmdlist)))
	(inferior-asy-mode))))
  (setq inferior-asy-program-command cmd)
  (setq asy-script-buffer (if (string= major-mode "asy-mode")
			      (buffer-file-name)
			    nil))
  (setq inferior-asy-buffer "*asy*")
  (if (not dont-switch-p)
      (pop-to-buffer "*asy*")))

;;;###autoload
(defun asy-send-tab ()
  "Send the current region to the inferior Asymptote process."
  (interactive)
  (run-asy inferior-asy-program-command t)
  (comint-send-string inferior-asy-buffer "\t"))

(defun asy-send-region (start end)
  "Send the current region to the inferior Asymptote process."
  (interactive "r")
  (run-asy inferior-asy-program-command t)
  (comint-send-region inferior-asy-buffer start end)
  (with-current-buffer inferior-asy-buffer
    (comint-send-input nil)))
;;(comint-send-string inferior-asy-buffer "\n")


;;;###autoload
(defun asy-send-region-and-go (start end)
  "Send the current region to the inferior Asymptote process."
  (interactive "r")
  (run-asy inferior-asy-program-command t)
  (comint-send-region inferior-asy-buffer start end)
  (comint-send-string inferior-asy-buffer "\n")
  (switch-to-asy inferior-asy-buffer))

;;;###autoload
(defun asy-send-buffer ()
  "Send the buffer to the inferior Asymptote process."
  (interactive)
  ;; new implementation
  (let ((temp-file (make-temp-file 
		    (format "%s_" 
			    (file-name-sans-extension 
			     (file-name-nondirectory (buffer-file-name))))
		    nil ".asy")))
    (write-region (point-min) (point-max) temp-file)
    (asy-send-file temp-file))
  ;; old implementation: not good because requires settings.multiline=true
  ;;(asy-send-region (point-min) (point-max))
  )

(defun asy-send-file (filename)
  "Send the file content to the inferior Asymptote process. (> input FILENAME)"
  ;(interactive)
  (setq asy-script-buffer filename)
  (let ((cmd (format "input '%s';" filename)))
    (message cmd)
    (comint-send-string inferior-asy-buffer cmd)
    (comint-send-string inferior-asy-buffer "\n")))


;; ;;;###autoload
;; (defun asy-send-buffer-and-go ()
;;   "Send the buffer to the inferior Asymptote process."
;;   (interactive)
;;   (asy-send-region-and-go (point-min) (point-max)))

;; ;;;###autoload
;; (defun asy-load-file (filename)
;;   "Load a file in the asymptote interpreter."
;;   (interactive "f")
;;   (let ((filename (expand-file-name filename)))
;;     (run-asy inferior-asy-program-command t)
;;     (comint-send-string inferior-asy-buffer (concat "load(\"" filename "\")\n"))))

;; ;;;###autoload
;; (defun asy-load-file-and-go (filename)
;;   "Load a file in the asymptote interpreter."
;;   (interactive "f")
;;   (let ((filename (expand-file-name filename)))
;;     (run-asy inferior-asy-program-command t)
;;     (comint-send-string inferior-asy-buffer (concat "load(\"" filename "\")\n"))
;;     (switch-to-asy inferior-asy-buffer)))

;; ;;;###autoload
(defun switch-to-asy (eob-p)
  "Switch to the asymptote process buffer.
With argument, position cursor at end of buffer."
  (interactive "P")
  (if (or (and inferior-asy-buffer (get-buffer inferior-asy-buffer))
          (asy-interactively-start-process))
      (pop-to-buffer inferior-asy-buffer)
    (error "No current process buffer.  See variable `inferior-asy-buffer'"))
  (when eob-p
    (push-mark)
    (goto-char (point-max))))

(defun iasy-init ()
  "define keys for interactive Asymptote"
  (interactive)
  (local-set-key (kbd "C-c C-c") 'asy-send-buffer)
  ;;(local-set-key (kbd "C-c C-c") 'asy-send-buffer)
  (local-set-key (kbd "M-n") 'asy-send-region)
  (local-set-key (kbd "C-c !") 'run-asy)
  (local-set-key (kbd "C-c C-v") 'asy-view)
  (setq tags-file-name asy-tags-table)
)

(defvar inferior-asy-buffer)

(defvar inferior-asy-mode-map
  (let ((map (nconc (make-sparse-keymap) comint-mode-map)))
    ;; example definition
    (define-key map "\t" 'completion-at-point)
    map)
  "Basic mode map for `iasy'")

  ;; (let ((m (make-sparse-keymap)))
  ;;   (define-key m "\C-c\C-c" 'asy-send-buffer)
  ;;   (define-key m "\M-n" 'asy-send-region)
  ;;   (define-key m (kbd "C-!") 'run-asy)
  ;;   m))

;;;
(require 'info-look) 
;; Lookup symbol in info file with C-h S
(info-lookup-add-help
    :mode 'asy-mode
    :ignore-case t
    :doc-spec '(("(Asymptote)Index" nil nil nil)))
(defun asy-info ()
  "Start texinfo manual"
  (interactive)
  (info "Asymptote"))

;;;###autoload
(define-derived-mode inferior-asy-mode comint-mode "Inferior Asymptote"
  "Major mode for interacting with an inferior asymptote process.

The following commands are available:
\\{inferior-asy-mode-map}

A asymptote process can be fired up with M-x run-asy.

Customization: Entry to this mode runs the hooks on comint-mode-hook and
inferior-asy-mode-hook (in that order).

You can send text to the inferior Asymptote process from othber buffers containing
Asymptote source.
    switch-to-asy switches the current buffer to the Asymptote process buffer.
    asy-send-region sends the current region to the Asymptote process.


"
(use-local-map inferior-asy-mode-map)
;; this sets up the prompt so it matches things like: [foo@bar]
(setq comint-prompt-regexp "^> ")
;; this makes it read only; a contentious subject as some prefer the
;; buffer to be overwritable.
(setq comint-prompt-read-only t)
)

    
(defun asy-output-file ()
  "Return name of output file. 

Search buffer for a string of the form
    shipout(prefix=filename, format='pdf'), 
where prefix and format are optional. 
If no such string is found return out.pdf 

BUG: check that the shipout command does not start with // !
"
  (interactive)
  (save-excursion 
    (goto-char 1)
    (let (out-regexp format-regexp str-regexp shipout-regexp)
      (setq str-regexp "\"\\([^\"]*\\)\"")
      (setq format-regexp (format "\\(?:, format=%s\\)?" str-regexp))
      (setq out-regexp (concat "\\(?:prefix=\\)?" str-regexp))
      (setq shipout-regexp (format "^shipout(%s%s)" out-regexp format-regexp))
      (if (search-forward-regexp shipout-regexp nil t)
	  (let (name ext)
	    (setq name (match-string-no-properties 1))
	    (setq ext (match-string-no-properties 2))
	    (unless ext
	      (setq ext asy-settings-outformat))
	    (concat name "." ext))
	"out.pdf"))))

(defun asy-send-setting (key value)
  "Send setting to Asymptote shell"
  (interactive)
  (comint-send-string inferior-asy-buffer (format "settings.%s=%s;\n" key value)))

(defun asy-view ()
  "View result using DocView in an emacs buffer"
  (interactive)
  ;; deactivate asy's interactive plotting
  ;(comint-send-string inferior-asy-buffer "settings.interactiveView=false;\n")
  (asy-send-setting "interactiveView" "false")
  ;; split screen in 3
  (delete-other-windows) ;; make sure we've got the full screen
  (split-window-horizontally)
  (other-window 1)
  (split-window-vertically)
  ;; open image
  (let ((openwith-mode nil))
    ;;(find-file "out.pdf")
    (find-file (asy-output-file))
    (setq asy-view-buffer (current-buffer))
    (doc-view-first-page)
    (auto-revert-mode 1))
  ;; open *asy* buffer in bottom window
  (other-window 1) 
  (switch-to-buffer inferior-asy-buffer)
  ;; go back to image
  (other-window -1) 
  ;; try to fit window to content (doesn't work the first time?)
  (doc-view-fit-page-to-window)
  ;(fit-window-to-buffer)
  ;; go back to script
  (other-window 2) 
  )

    ;; (switch-to-buffer inferior-asy-buffer)
    ;; (split-window-vertically)
    ;; (let ((openwith-mode nil))
    ;;   (find-file-other-window "out.pdf")
    ;;   (fit-window-to-buffer))))
