;;; wgrep-ag-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "wgrep-ag" "wgrep-ag.el" (22391 30470 0 0))
;;; Generated autoloads from wgrep-ag.el

(autoload 'wgrep-ag-setup "wgrep-ag" "\


\(fn)" nil nil)

(add-hook 'ag-mode-hook 'wgrep-ag-setup)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; wgrep-ag-autoloads.el ends here
