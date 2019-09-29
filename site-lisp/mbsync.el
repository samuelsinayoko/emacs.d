;;; mbsync.el --- run mbsync to fetch mails

(defgroup mbsync nil "mbsync customization group"
  :group 'convenience)

(defcustom mbsync-ext-hook nil
  "Hook run after `mbsync' is done."
  :group 'mbysnc
  :type 'hook)

(defcustom mbsync-executable (executable-find "mbsync")
  "Where to find the `mbsync' utility"
  :group 'mbsync)

(defcustom mbsync-args '("-a")
  "List of options to pass to the `mbsync' command"
  :group 'mbsync)

(defvar mbsync-process-filter-pos nil)

(defun mbsync-process-filter (proc string)
  "Filter for `mbsync', auto accepting certificates"
  (with-current-buffer (process-buffer proc)
    (unless (bound-and-true-p mbsync-process-filter-pos)
      (make-local-variable 'mbsync-process-filter-pos)
      (setq mbsync-process-filter-pos (point-min)))

    (save-excursion
      (let ((inhibit-read-only t))
	(goto-char (point-max))
	(insert string)

	;; accept certificates
	(goto-char mbsync-process-filter-pos)
	(while (re-search-forward "Accept certificate?" nil t)
	  (process-send-string proc "y\n"))))

    (save-excursion
      ;; message progress
      (goto-char mbsync-process-filter-pos)
      (while (re-search-forward (rx bol "Channel " (+ (any alnum)) eol) nil t)
	(message "%s" (match-string 0))))

    (setq mbsync-process-filter-pos (point-max))))

(defun mbsync-sentinel (proc change)
  "Mail sync is over, message it then run `mbsync-exit-hook'"
  (when (eq (process-status proc) 'exit)
    (message "mbsync is done")
    (run-hooks 'mbsync-exit-hook)))

(defun mbsync (&optional show-buffer)
  "run the `mbsync' command, asynchronously, then run `mbsync-exit-hook'"
  (interactive "p")
  (catch 'previous-sync-not-finished
    (let* ((name "*mbsync*")
	   (dummy
	    (when (get-buffer name)
	      ;; don't sync (wait untill the previous sync finishes)
	      (kill-buffer name)
	      ;;(message "Previous sync not finished... exiting. Kill *mbsync* buffer manually")
	      ;;(throw 'previous-sync-not-finished nil)
	      ))
	   (proc (apply 'start-process name name mbsync-executable mbsync-args)))
      (set-process-filter proc 'mbsync-process-filter)
      (set-process-sentinel proc 'mbsync-sentinel)
      (when (and (called-interactively-p) (eq show-buffer 4))
	(set-window-buffer (selected-window) (process-buffer proc))))))

(provide 'mbsync)
