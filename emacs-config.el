
;;;; Info files
(require 'info)
(setq Info-directory-list
      (cons (expand-file-name "~/.info/") Info-default-directory-list))

(require 'dired)
(define-key dired-mode-map "I"
  (lambda () (interactive)
    (info (dired-get-filename))))

;; Load zap-up-to-char from Emacs's misc.el if necessary
  (autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.")

  (defun reopen-file ()
    (interactive)
    (find-file (format "/ssh:%s:%s" (getenv "HOSTNAME") buffer-file-name)))

  (defun store-buffer-name ()
    (interactive)
    (let ((s buffer-file-name))
      (with-temp-buffer
        (insert s)
        (clipboard-kill-region (point-min) (point-max)))))

  (defun unfill-paragraph ()
    (interactive)
    (let ((fill-column (point-max)))
      (fill-paragraph nil)))

  (defun unfill-region (start end)
    (interactive "r")
    (let ((fill-column (point-max)))
      (fill-region start end nil)))


  (defun sam/copy-buffer-file-name ()
    "Copy buffer file name to clipboard"
    (interactive)
    (kill-new buffer-file-name)
    (message "copied %s" buffer-file-name))
  (global-set-key (kbd "C-c ;") 'sam/copy-buffer-file-name)

  (defun reload-configuration ()
    "Reload .emacs file"
    (interactive)
    (load-file emacs-init-file))

  (defun pjoin (root &rest subpaths)
    "Concatenate subpaths with root path"
    (let ((directories (cons root subpaths)))
      (directory-file-name (mapconcat 'file-name-as-directory directories ""))))

  (defun undo-kill-buffer (arg)
    "Re-open the last buffer killed.  With ARG, re-open the nth buffer."
    (interactive "p")
    (let ((recently-killed-list (copy-sequence recentf-list))
          (buffer-files-list
           (delq nil (mapcar (lambda (buf)
                               (when (buffer-file-name buf)
                                 (expand-file-name (buffer-file-name buf)))) (buffer-list)))))
      (mapc
       (lambda (buf-file)
         (setq recently-killed-list
               (delq buf-file recently-killed-list)))
       buffer-files-list)
      (find-file
       (if arg (nth arg recently-killed-list)
         (car recently-killed-list)))))

  ;; Open previous / next line
  (defun open-next-line (arg)
    "Move to the next line and then opens a line.
      See also `newline-and-indent'."
    (interactive "p")
    (end-of-line)
    (open-line arg)
    (next-line 1)
    (indent-according-to-mode))
  (defun open-previous-line (arg)
    "Open a new line before the current one.
       See also `newline-and-indent'."
    (interactive "p")
    (beginning-of-line)
    (open-line arg)
    (indent-according-to-mode))
  (defun backward-kill-word-or-kill-region (&optional arg)
        (interactive "p")
        (if (region-active-p)
            (copy-region-as-kill (region-beginning) (region-end))
          (backward-kill-word arg)))

  (defun transpose-comma (&optional N)
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

  (global-set-key (kbd "C-,") 'transpose-comma)

  (defun visit-dot-emacs ()
    "Visit ~/.emacs.d/emacs-config.org file"
    (interactive)
    (find-file "~/.emacs.d/emacs-config.org"))
  (defun visit-dot-gnus ()
    "Visit ~/.emacs.d/gnus.d/.gnus file"
    (interactive)
    (find-file "~/.emacs.d/gnus.d/gnus-config.el"))
  (defun visit-org-notes ()
    "Visit org-mode notes file"
    (interactive)
    (find-file "~/Dropbox/docs/org/notes.org"))


  (defun eshell/clear ()
    "Clears the shell buffer ala Unix's clear or DOS' cls"
    (interactive)
    ;; the shell prompts are read-only, so clear that for the duration
    (let ((inhibit-read-only t))
      ;; simply delete the region
      (delete-region (point-min) (point-max))))

  (defun kill-help-buffer()
    "Kill buffer in other window"
    (interactive)
                                          ;  (fset 'kill-help-buffer "\C-xoq")
    (save-excursion
      ;; Cycle window until we reach *Help* buffer
      (while (not (equal (buffer-name) "*Help*"))
        (select-window (next-window)))
      (View-quit)))

  (defun my-backup-file-name (fpath)
    "Return a new file path of a given file path.
  If the new path's directories does not exist, create them."
    (let (backup-root bpath)
      (setq backup-root "~/.emacs.d/backup")
      (setq bpath (concat backup-root fpath "~"))
      (make-directory (file-name-directory bpath) bpath)
      bpath
      )
    )
  (defun toggle-fullscreen (&optional f)
    (interactive)
    (let ((current-value (frame-parameter nil 'fullscreen)))
      (set-frame-parameter nil 'fullscreen
                           (if (equal 'fullboth current-value)
                               (if (boundp 'old-fullscreen) old-fullscreen nil)
                             (progn (setq old-fullscreen current-value)
                                    'fullboth)))))
  (global-set-key (kbd "<f11>") 'toggle-fullscreen)
  (global-set-key (kbd "<f1>") 'compile)

(defun eval-and-replace (value)
  "Evaluate the sexp at point and replace it with its value"
  (interactive (list (eval-last-sexp nil)))
  (kill-sexp -1)
  (insert (format "%S" value)))

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;;;; Aliases
(defalias 'sf 'text-scale-adjust) ;; set font
(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ee 'eval-expression)
(defalias 'lf 'load-file)
(defalias 'sh 'my-term)
(defalias 'nsh 'my-term-new)
(defalias 'rb 'revert-buffer)
(defalias 'fb 'fit-window-to-buffer) ;; fit window height to buffer content
(defalias 'ff 'fit-frame-to-buffer) ;; fit frame height to buffer content
(defalias '.e 'visit-dot-emacs)
(defalias '.b (lambda () (interactive)
                (find-file "~/.emacs.d/basics.org")))
(defalias '.i (lambda () (interactive)
                (find-file "~/.emacs.d/init.el")))
(defalias '.g 'visit-dot-gnus)
(defalias '.n 'visit-org-notes)
(defalias 'mc 'kmacro-set-counter)
(defalias 'mi 'kmacro-insert-counter)

(defvar emacs-init-file "~/.emacs.d/init.el")
(defvar gnus-init-file "~/.emacs.d/gnus.d/gnus-config.el")

;;;; System specific variables
(defvar linux-p nil "Linux machine")
(defvar ms-windows-p nil "MS Windows machine")
(defvar cygwin-p nil "Cygwin")
(defvar mac-osx-p nil "Mac OS X")
(defvar home-p nil "Home box")
(defvar office-p nil "Office box")
(defvar isvr-p nil "ISVR box")
(cond ((eq system-type 'darwin) (setq mac-osx-p t))
      ((eq system-type 'cygwin) (setq cygwin-p t))
      ((eq system-type 'ms-dos) (setq ms-windows-p t))
      ((or (eq system-type 'gnu)
           (eq system-type 'gnu/linux)
           (eq system-type 'gnu/kfreebsd)) (setq linux-p t)))

;;;; Global variables
(defvar HOME (getenv "HOME")
  "Home directory name")
(defvar DEV (pjoin HOME "dev")
  "Development directory")
(defvar APPS (pjoin HOME "apps")
  "Applications directory")
(defvar DBOX (pjoin HOME "Dropbox")
  "Dropbox directory")
(defvar PYTHON (pjoin HOME "miniconda3" "bin")    "Python bin directory")
;;(defvar PYTHON "/usr/bin" "Python bin directory")

;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

(when (string-equal (getenv "HOSTNAME") "sal")
  (setq office-p t))
(when (string-equal (getenv "HOSTNAME") "uos-208569")
  (setq isvr-p t)) ;; this doesn't work for some reason
(when (string-equal system-name "utcss")
  (setq home-p t)) ;; this doesn't work for some reason
;;(unless (file-exists-p "~/Dropbox/docs/organisation/")
;;  (setq isvr-p t))

(when mac-osx-p ;; For MacOSX
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq browse-url-browser-function (quote browse-url-default-macosx-browser))
  (setq exec-path (cons "/usr/local/bin" exec-path))
  (setq exec-path (cons "/usr/texbin" exec-path))
  (setq exec-path (cons "/usr/local/texlive/2014/bin/x86_64-darwin//pdflatex" exec-path))
  (setq exec-path (cons (expand-file-name "~/bin") exec-path))
  ;; (setq exec-path (cons  "/Library/Frameworks/EPD64.framework/Versions/Current/bin" exec-path))
  (setq ns-use-srgb-colorspace t)
  (setenv "PATH" (concat
                  (expand-file-name "~/bin") ":"
                  (expand-file-name "~/apps/bin") ":"
                  PYTHON ":"
                  "/opt/local/bin" ":"
                  "/usr/local/texlive/2014/bin/x86_64-darwin/" ":"
                  (getenv "PATH") ":"
                  "/usr/local/bin" ":"
                  "/usr/texbin"))
  )

;; "/Library/Frameworks/EPD64.framework/Versions/Current/bin" ":")))
;;(setq reftex-default-bibliography "~/Dropbox/Phd/BIBLIOGRAPHY/biblio_phd.bib"))
(when office-p
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "google-chrome"))
;; Make sure PYTHON binaries are in the path
(setq exec-path (cons PYTHON exec-path))
;; Make sure APPS/bin is in the path
;;(setq exec-path (cons (pjoin APPS "bin") exec-path))
;; (add-hook 'gnus-article-mode-hook
;;           (lambda ()
;;             (set (make-local-variable 'w3m-goto-article-function)
;;                  'browse-url)))

;; PDF viewer
(defvar pdf-viewer "okular" "pdf viewer")
(cond (office-p (setq pdf-viewer "okular"))
      (mac-osx-p (setq pdf-viewer "open")))
;; Don't use --dired with ls
(setq ls-lisp-use-insert-directory-program nil)
(require 'ls-lisp)

;; (unless (package-installed-p 'use-package)
;;   (package-install 'use-package))
;;(eval-when-compile
;;  (require 'use-package))
(require 'use-package)
;;(setq use-package-verbose t)
;;(setq load-prefer-newer t)

(show-time-since-init "EO Use-package")

;; ido: help with buffers / opening files
(require 'ido)
(ido-mode t)
(setq enable-recursive-minibuffers nil)
(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-use-virtual-buffers t)
(setq ido-use-filename-at-point (quote guess))
(setq ido-use-url-at-point t)
(put 'ido-exit-minibuffer 'disabled nil)

;; Overwride sam-key-mode's C-SPC
(add-hook 'minibuffer-inactive-mode-hook
    (lambda ()
      (let ((oldmap (cdr (assoc 'sam-keys-mode minor-mode-map-alist)))
            (newmap (make-sparse-keymap)))
        (set-keymap-parent newmap oldmap)
        (define-key newmap (kbd "C-SPC") 'ido-restrict-to-matches)
        (make-local-variable 'minor-mode-overriding-map-alist)
        (push `(sam-keys-mode . ,newmap) minor-mode-overriding-map-alist))))

;; recent files (from Mickey at
  ;; http://www.masteringemacs.org/articles/2011/01/27/find-files-faster-recent-files-package/
(use-package recentf
  :config
  ;;(require 'recentf)
  ;;; get rid of `find-file-read-only' and replace it with something
  ;;; more useful.
  (global-set-key (kbd "C-x C-r") 'ido-recentf-open)
  ;;; enable recent files mode.
  (recentf-mode t)
  ;;; 50 files ought to be enough.
  (setq recentf-max-saved-items 200)
  (defun ido-recentf-open ()
    "Use `ido-completing-read' to \\[find-file] a recent file"
    (interactive)
    (if (find-file (ido-completing-read "Find recent file: " recentf-list))
        (message "Opening file...")
      (message "Aborting"))))

;; ido everything
;; (defvar ido-enable-replace-completing-read t
;;   "If t, use ido-completing-read instead of completing-read if possible.

;; Set it to nil using let in around-advice for functions where the
;; original completing-read is required.  For example, if a function
;; foo absolutely must use the original completing-read, define some
;; advice like this:

;;(defadvice foo (around original-completing-read-only activate)
;;  (let (ido-enable-replace-completing-read) ad-do-it))")

;; ;; Replace completing-read wherever possible, unless directed otherwise
;; (defadvice completing-read
;;   (around use-ido-when-possible activate)
;;   (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
;;           (boundp 'ido-cur-list)) ; Avoid infinite loop from ido calling this
;;       ad-do-it
;;     (let ((allcomp (all-completions "" collection predicate)))
;;       (if allcomp
;;           (setq ad-return-value
;;                 (ido-completing-read prompt
;;                                   allcomp
;;                                   nil require-match initial-input hist def))
;;         ad-do-it))))

;; smex
;;(load-file "~/.emacs.d/site-lisp/smex.el") ;; use elpa instead
;;(smex-initialize)
;; (setq smex-save-file "~/.emacs.d/.smex-items")
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;; idomenu
;;(load-file "~/.emacs.d/site-lisp/idomenu.el")
(autoload 'idomenu "idomenu" nil t)
(global-set-key (kbd "M-/") 'idomenu)

;; Iedit: to replace things easily locally
(load-file "~/.emacs.d/site-lisp/iedit.el")
(require 'iedit)
(define-key global-map (kbd "C-;") 'iedit-mode)
(define-key isearch-mode-map (kbd "C-;") 'iedit-mode)

(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (let ((debug-cmd "import ipdb; ipdb.set_trace()"))
  ;;(let ((debug-cmd "from IPython.core.debugger import Tracer; Tracer()()"))
    (save-excursion
      ;; Insert line above and indent
      ;; deal with special case of being at top of module
      (if (= (forward-line -1) 0)
          (progn
            (end-of-line)
            (newline-and-indent))
        (beginning-of-line)
        (newline-and-indent)
        (forward-line -1))
      (message (format "%s:%s" buffer-file-name (line-number-at-pos)))
      (insert debug-cmd))
    (highlight-lines-matching-regexp (concat "^[ ]*" debug-cmd))))

;;(require 'linum)
(require 'pycoverage)

(defun maybe-pycoverage-mode ()
  (interactive)
  (when (derived-mode-p 'python-mode)
    (progn
      (unless (string-match-p "test_" (file-name-nondirectory (buffer-file-name)))
        (pycoverage-mode t)))))

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("elpy" . "http://jorgenschaefer.github.io/packages/"))
;;(defalias 'workon 'conda-env-activate)
(defalias 'workon 'pyvenv-activate)
(require 'elpy)
(require 'sam-ipython)
;; this seems to be needed to find the conda envs
;; check that RPC is set to the correct python in elpy-config
(add-to-list 'load-path
             ".emacs.d/elpa/yasnippet-20180204.1613")
(require 'yasnippet)
(elpy-enable)
;;(add-hook elpy-mode-hook '(lambda () (sam-ipython-mode t))
(progn
  (setenv "WORKON_HOME" (expand-file-name "~/.anaconda3/envs"))
  (define-key elpy-mode-map (kbd "C-c C-c")
    'elpy-shell-send-region-or-buffer-and-go)
  (define-key elpy-mode-map (kbd "M-n")
    'elpy-shell-send-region-or-buffer-and-step)
  (define-key elpy-mode-map (kbd "M-O")
    'elpy-shell-switch-to-shell)
  (define-key elpy-mode-map (kbd "M-.")
    'elpy-goto-definition))
(add-hook 'elpy-mode-hook
          '(lambda ()
             (setq python-shell-interpreter "ipython3")
             ;; use simple prompt because IPython>=5 breaks elpy-shell
             (setq python-shell-interpreter-args "--simple-prompt --pprint")
             (setq elpy-rpc-backend "jedi")
             (setq imenu-auto-rescan t)
             (setq elpy-rpc-timeout 10)
             (setenv "WORKON_HOME" (expand-file-name "~/.anaconda3/envs"))
             (when (version<= "26.0.50" emacs-version)
               (display-line-numbers-mode))
             ;; don't use pycoverage as it messes with line numbers
             ;; in emacs 26
             ;;(maybe-pycoverage-mode)
             ))
(define-key inferior-python-mode-map (kbd "M-O")
  'elpy-shell-switch-to-buffer)
(define-key elpy-mode-map (kbd "C-c C-b") 'python-add-breakpoint)
(defun sam/jupyter-console-existing ()
  "Start Jupyter shell by attaching to an existing kernel"
  (interactive)
  (let ((kernel (read-string "Kernel id: ")) )
    (setq python-shell-interpreter "jupyter"
          python-shell-interpreter-args (format "console --simple-prompt --existing %s" kernel))
    (elpy-shell-switch-to-shell)))
(defun sam/conda-env-activate ()
  "activate conda environment.
  TODO: add this to .dir-locals.el
  ((nil . ((conda-project-env-name . \"mlbook\"))))
  "
  (interactive)
  (conda-env-activate-for-buffer)
  (elpy-rpc-restart))
(defalias 'cea 'sam/conda-env-activate)
;; (require 'anaconda-mode)
;; (add-hook 'elpy-mode-hook '(lambda () (anaconda-mode t)))

;; Default options
(tool-bar-mode -1)
(show-paren-mode 1)
(global-font-lock-mode t)
(winner-mode 1) ; go back between layouts
(global-visual-line-mode 1) ; visual line mode


(setq confirm-kill-emacs 'yes-or-no-p
      transient-mark-mode t
      inhibit-splash-screen t
      visible-bell t
      indent-tabs-mode nil
      sentence-end-double-space nil
      ;; Scrolling
      scroll-margin 3
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(put 'set-goal-column 'disabled nil)

;; scrolling
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)

(put 'downcase-region 'disabled nil)

;; For one-key
;;(setq max-lisp-eval-depth 10000)
;;(setq max-specpdl-size 10000)

;; ;; Clipboard
;; (setq mouse-drag-copy-region nil)
;; (setq x-select-enable-primary t)
;; (setq x-select-enable-clipboard t)

(put 'narrow-to-region 'disabled nil)
;; Delete trailing white spaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Revert buffers automatically
(global-auto-revert-mode 1)

;; Frame title
(setq frame-title-format (concat "%b - emacs@" (system-name)))
;; For mu4e
(set-language-environment "UTF-8")

;; Recursive mini-buffer
(setq enable-recursive-minibuffers nil)

;;(load-theme 'tango-dark)
  ;;(load-theme 'tangotangofixed t)
  ;;(load-theme 'tango-2 t) ;; in MELPA repository
  ;;(load-theme 'tangotango t) ;; in MELPA repository
  (load-theme 'naquadah t) ;; in MELPA repository
  ;(load-theme 'badwolf t) ;; in MELPA repository
  ;; Modify the block headers in org-mode to better isolated the code from the org-mode stuff
  ;; (custom-theme-set-faces
  ;;  'tangotango
  ;;  '(org-block-begin-line ((t (:underline t :foreground "#888a85" :background "#2e3434"))))
  ;;  '(org-block-end-line ((t (:foreground "#888a85" :overline t :background "#2e3434"))))
;;  )
(setq naquadah-p nil)
(defun sam/toggle-theme ()
  "Toggle NAQUADAH theme on and off"
  (interactive)
  (if naquadah-p
      (enable-theme 'naquadah)
    (disable-theme 'naquadah))
  (setq naquadah-p (not naquadah-p)))

;; Backups
(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.backup-dir"))
      delete-old-versions t
      kept-new-versions 5
      kept-old-versions 2
      version-control t)

(eval-after-load 'grep
  '(define-key grep-mode-map
    (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode))

(eval-after-load 'wgrep
  '(define-key grep-mode-map
    (kbd "C-c C-c") 'wgrep-finish-edit))

(projectile-global-mode t)

(use-package projectile
:ensure t
:config
(setq projectile-keymap-prefix (kbd "C-c C-p"))
(setq projectile-tags-command (expand-file-name "~/apps/bin/ctags -Re -f \"%s\" %s")))

(show-time-since-init "EO Tmp")
