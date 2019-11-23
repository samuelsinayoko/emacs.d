(require 'cl)
(require 'package)
(load "package")

(if (fboundp 'normal-top-level-add-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/site-lisp/")
           (default-directory my-lisp-dir))
      (progn
        (setq load-path
              (append
               (cl-loop for dir in (directory-files my-lisp-dir)
                     unless (string-match "^\\." dir)
                     collecting (expand-file-name dir))
               load-path)))))

(add-to-list 'package-archives '("elpa" . "~/.emacs.d/elpa"))
(package-initialize)

;;; init.el --- Where all the magic begins
;; ;; Comments out to benchmark

(require 'benchmark-init)
(benchmark-init/activate)

;; Time emacs startup
(defvar *emacs-load-start* (current-time))
(require 'cl)

;; Logging function
(defun sam/message-init (&rest rest)
  "Logging information during init"
  (with-current-buffer (get-buffer-create "*log-init*")
    (goto-char (point-max))
    (insert (apply 'format rest))
    (newline)
    (apply 'message rest)))

(defun show-time-since-init (&optional info)
  (let* ((time (destructuring-bind (hi lo ms ps) (current-time)
		(- (+ hi lo) (+ (first *emacs-load-start*)
					(second *emacs-load-start*)))))
	 (template (format "Time since start of ~/.emacs.d/init.el: %ds" time)))
    (if info
	(sam/message-init "%s [%s]" template info)
      (sam/message-init template))))

 (show-time-since-init "EO show-times")
;; ;; ELPA
;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "http://stable.melpa.org/packages/")
;;              t)
;; ;; (add-to-list 'package-archives
;; ;; 	     '("melpa" . "http://melpa.org/packages/"))
;; ;;   - for Python
;; (add-to-list 'package-archives
;;              '("elpy" . "http://jorgenschaefer.github.io/packages/"))
;; (show-time-since-init "EO package")
;; ;; Fix bug in Melpa in Emacs 24
;; ;; (defadvice package-compute-transaction
;; ;;   (before package-compute-transaction-reverse (package-list requirements) activate compile)
;; ;;   "reverse the requirements"
;; ;;   (setq requirements (reverse requirements))
;; ;;   (print requirements))
;; ;; basic initialization, (require) non-ELPA packages, etc.
;; (package-initialize nil)
;; (setq package-enable-at-startup nil)


;; ;; (require) your ELPA packages, configure them as normal
;; ;;(require 'jedi)

;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

;; ;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
;; (setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

;; (let* ((org-dir (expand-file-name
;;                  "lisp" (expand-file-name
;;                          "org" (expand-file-name
;;                                 "src" dotfiles-dir))))
;;        (org-contrib-dir (expand-file-name
;;                          "lisp" (expand-file-name
;;                                  "contrib" (expand-file-name
;;                                             ".." org-dir))))
;;        (load-path (append (list org-dir org-contrib-dir)
;;                           (or load-path nil))))
;;   ;; load up Org-mode and Org-babel
;;   (require 'org-install)
;;   (require 'ob-tangle))

(defun load-org-config (org-file)
  "Load org-mode config file"
  (let* ((el-file (concat (file-name-sans-extension org-file) ".el"))
	 (org-last-mod (nth 5 (file-attributes (file-truename org-file))))
	 (el-last-mod (nth 5 (file-attributes (file-truename el-file)))))
    (if (time-less-p org-last-mod el-last-mod)
	;; .el file is newer
	(load-file el-file)
      ;; .org file is newer: regenerate .el
      (org-babel-load-file org-file))))

;; load basics
;;(require 'org)
;;(org-babel-load-file "~/.emacs.d/basics.org")
(load-org-config "~/.emacs.d/basics.org")
(show-time-since-init "EO Basics")
;; (let* ((org-file "~/.emacs.d/emacs-config.org")
;;        (el-file (concat (file-name-sans-extension org-file) ".el"))
;;        (org-last-mod (nth 5 (file-attributes org-file)))
;;        (el-last-mod (nth 5 (file-attributes el-file))))
;;     (if (time-less-p org-last-mod el-last-mod)
;;       ;; .el file is newer
;;       (load-file el-file)
;;     ;; .org file is newer: regenerate .el
;;       (org-babel-load-file org-file)))

;;(org-babel-load-file "~/.emacs.d/emacs-config.org")
(load-org-config "~/.emacs.d/emacs-config.org")
(show-time-since-init "emacs-config")

;; custom variables
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; load up all literate org-mode files in this directory
;;(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))
;; (message "load time: %ds" (destructuring-bind (hi lo ms ps) (current-time)
;; 			    (- (+ hi lo) (+ (first *emacs-load-start*)
;; 					    (second *emacs-load-start*)))))
(show-time-since-init "total")

;;; init.el ends here
