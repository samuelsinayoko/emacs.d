(setq flake8-cmd "/home/samuel/.virtualenvs/kim/bin/flake8")
(setq pyflakes-cmd "/home/samuel/.virtualenvs/kim/bin/pyflakes")

;; Simple config for pyflakes
(defun pyflakes-thisfile ()
  "Run pyflakes on current file."
  (interactive)
  (compile (format "%s %s" pyflakes-cmd (buffer-file-name)))
)

(defun flake8-thisfile ()
  "Run flake8 on current file.

- flake8 uses the pep8 style.
- Install flake8 with $pip install flake8"
  (interactive)
  (compile (format "%s %s" flake8-cmd (buffer-file-name)))
)

;; Use flymake to run pyflakes on the fly
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    ;; Make sure it's not a remote buffer or flymake would not work
    ;;(when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name)))
	   ;;(cmd "pyflakes")
	   (cmd flake8-cmd))
      (list cmd (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init))
)


(define-minor-mode sam-pyflakes-mode
    "Toggle pyflakes mode.
    With no argument, this command toggles the mode.
    Non-null prefix argument turns on the mode.
    Null prefix argument turns off the mode."
    ;; The initial value.
    nil
    ;; The indicator for the mode line.
    " Pyflakes"
    ;; The minor mode bindings.
    '( ([f2] . flake8-thisfile) )
)

(provide 'sam-pyflakes-mode)
