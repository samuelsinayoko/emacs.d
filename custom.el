;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(TeX-PDF-mode t)
 ;; '(TeX-output-view-style (quote (("^pdf$" "." "kpdf %s.pdf") ("^html?$" "." "google-chrome %o") ("^eps$" "." "display %o"))))
 ;; '(TeX-source-correlate-method (quote synctex))
 ;; '(TeX-source-correlate-mode t)
 ;; '(TeX-source-correlate-start-server t)
 ;; '(TeX-view-predicate-list (quote ((output-pdf-osx (and (string-match "pdf" (TeX-output-extension)) mac-osx-p)))))
 ;; '(TeX-view-program-list (quote (("Open" "open %o") ("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b") ("Okular" "okular -unique %o#src:%n%b"))))
 ;; '(TeX-view-program-selection (quote ((engine-omega "dvips and gv") (output-dvi "xdvi") (output-pdf-osx "Skim") (output-pdf "Okular") (output-html "xdg-open"))))
;;  '(asy-command "asy -V")
;;  '(asy-compilation-buffer (quote none))
;;  '(canlock-password "945831ee6cafe4f5cd3a5d7c28ebc128ff09cd0f")
;;  '(column-number-mode t)
;;  '(delete-selection-mode nil)
;;  '(dired-dwim-target t)
;;  '(file-name-shadow-mode t)
;;  '(gnus-ignored-from-addresses (quote ("s\\\\.sinayoko@eng\\\\.cam\\\\.ac\\\\.uk" "ss2059@cam\\\\.ac\\\\.uk")))
;;  '(mark-even-if-inactive t)
;;  '(org-agenda-files (quote ("~/Dropbox/docs/organisation/agenda.org" "~/Dropbox/docs/organisation/journal.org" "~/Dropbox/docs/organisation/todo.org")))
;;  '(org-file-apps (quote ((auto-mode . emacs) ("\\.mm\\'" . default) ("\\.x?html?\\'" . default) ("\\.pdf\\'" . "/usr/bin/kpdf %s"))))
;;  '(org-mobile-agendas (quote all))
;;  '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
;;  '(pdf-view-command pdf-viewer)
;;  '(ps-view-command pdf-viewer)
;;  '(safe-local-variable-values (quote ((speck-dictionary . hu))))
;;  '(scroll-bar-mode (quote right))
;;  '(send-mail-function (quote smtpmail-send-it))
;;  '(sp-ignore-modes-list (quote (calc-mode dired-mode gnus-article-mode gnus-group-mode gnus-summary-mode ibuffer-mode magit-branch-manager-mode magit-commit-mode magit-diff-mode magit-key-mode magit-log-mode magit-reflog-mode magit-stash-mode magit-status-mode magit-wazzup-mode minibuffer-inactive-mode monky-mode sr-mode term-mode)))
;;  '(sql-sqlite-program "sqlite3")
;;  '(term-bind-key-alist (quote (("C-c C-c" . term-interrupt-subjob) ("C-p" . previous-line) ("C-n" . next-line) ("C-s" . isearch-forward) ("C-r" . isearch-backward) ("C-m" . term-send-raw) ("M-b" . term-send-backward-word) ("M-p" . term-send-up) ("M-n" . term-send-down) ("M-M" . term-send-forward-kill-word) ("M-N" . term-send-backward-kill-word) ("M-r" . term-send-reverse-search-history) ("M-," . term-send-input) ("M-." . comint-dynamic-complete))))
;;  '(transient-mark-mode 1)
;;  '(w3m-key-binding (quote info))
;;  '(w3m-use-cookies t))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(speck-mouse ((((class color)) (:background "brown"))))
;;  '(speck-query ((((class color)) (:background "red")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(TeX-output-view-style
   (quote
    (("^pdf$" "." "okular %s.pdf")
     ("^html?$" "." "google-chrome %o")
     ("^eps$" "." "display %o"))))
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-predicate-list
   (quote
    ((output-pdf-osx
      (and
       (string-match "pdf"
		     (TeX-output-extension))
       mac-osx-p)))))
 '(TeX-view-program-list
   (quote
    (("Open" "open %o")
     ("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")
     ("Okular" "okular -unique %o#src:%n%b"))))
 '(TeX-view-program-selection
   (quote
    ((engine-omega "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf-osx "Skim")
     (output-pdf "Okular")
     (output-html "xdg-open"))))
 '(asy-command "asy -V")
 '(asy-compilation-buffer (quote none))
 '(auth-source-save-behavior nil)
 '(canlock-password "945831ee6cafe4f5cd3a5d7c28ebc128ff09cd0f" t)
 '(column-number-mode t)
 '(conda-env-autoactivate-mode nil)
 '(custom-safe-themes
   (quote
    ("43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" "9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "680e399d223ad36a6c82dbddc85ff3e2ad42ea1d7b8a7b31cbe32e2f21d18901" "176b5d586cd73cb08e6865ffdbdd174285efa33938fa43bbd266fb28c72568a1" "236750116154e2a83996aa56d20dc4b9468182b0ea29207d8693992f19cece18" "51a73a250051d5ed7b6789c0e302c564922f731ef9835ea23ab8aa5f82a2c23b" "6c9ddb5e2ac58afb32358def7c68b6211f30dec8a92e44d2b9552141f76891b3" "1c6c7d5e4beaec0a54d814454106d180de7b90f8961d3edd2f6567f7c08da97e" "5d9351cd410bff7119978f8e69e4315fd1339aa7b3af6d398c5ca6fac7fd53c7" "8f57ddf375da6a5f9d593d62dcdff4070695ce7f10f3b7918c1bf69e919402c7" "80c0127e2d558f8661c5bbcbe4fd413d099472f8ce68673b8a4d14e5a0fb49fe" "6393531c74231be4fdf0483a133906a9f7acb019cea028c91a180cab96b378b3" "82a21c3fd2c638e5f4e2e8765444272f60913deb4baef0bab733e9cc943dd057" "4ffc675985ba7d97eeb444075c8a801099255262272496af56998d9c27012bc3" "e9cf4e53ee6fbe44368fc0668d58a6f60c807d73812ef5bda67768bf05c50851" "05a843960902b15186e923263130d17dfaaaf8cea5c3e69266fb834ead290bed" "77f7dba653383b3551d26abc925e67a536d451769ae55548797e6ff723f43b0c" "882b8280ff2d354977fde23d57c60031e5fb8d4d40b15bca11850a14065419a5" "b479cc0c64d6c3977cc48aec872a02628dc10c3dbc08c70509e4355a426f9985" "fd3d2151c8cb0e64b3c45f16402961169d3a2b5e5a350e8fd7380071c2ee75af" "634b03577e329c56f5761b6884e3cafeff08f034d4817773ebf75c943eaa52d9" "33f36e9ed7cad3d49262a9f811327ca2bdc57f07bb6b9188ae50054361f70703" "8de895211fa4735c6e7e9e61fec66ff1c00030f6ece2bc5b87dce7b19afc9935" "3739467e6d43556d6aa0b0203a3ce12955f3d3bc3fe717ba91c2d79282c257b4" "47be0a02db1d4de49982463aa0faac7dc5e50f67074251edd545d2f3bc685155" "c5736a3d210eaa5d42c232887bc40d305aeabfad7f014458dcce4448a5d98cb2" "4d9e95202e3821109c8c8a93a1708a6b69f4b0bf9b1b70afb39f9fedfdaa9db7" "6eb277abed0b51aeaa4cd5f483cbc7019f87bd5af9120445c70fbf6fea0f8e9a" "dbf8cb30319aa88d14c569ef4509bd2c9ad6c8c58e7e7a7ae61a872cb32e9de2" "843a82ff3b91bec5430f9acdd11de03fc0f7874b15c1b6fbb965116b4c7bf830" "d0b8cb9028293747e030af91a7930dc8777243d31af9974a0187d94dc0c2e4c3" "9e915c42887b341f8b6fddac7a1b691467c93428853dde210db95a4346a14abe" default)))
 '(delete-selection-mode nil)
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-sane-defaults)))
 '(elpy-test-runner (quote elpy-test-pytest-runner))
 '(file-name-shadow-mode t)
 '(gnus-ignored-from-addresses
   (quote
    ("s\\\\.sinayoko@eng\\\\.cam\\\\.ac\\\\.uk" "ss2059@cam\\\\.ac\\\\.uk")))
 '(ledger-reports
   (quote
    (("mali" "ledger -f mali.ledger balance")
     ("test" "ledger -f mali.ledger balance")
     ("test" "ledger -f sam.ledger balance")
     ("bal" "ledger -f %(ledger-file) bal")
     ("reg" "ledger -f %(ledger-file) reg")
     ("payee" "ledger -f %(ledger-file) reg @%(payee)")
     ("account" "ledger -f %(ledger-file) reg %(account)"))))
 '(ledger-schedule-file "schedule.ledger")
 '(mark-even-if-inactive t)
 '(mu4e-headers-fields
   (quote
    ((:human-date . 12)
     (:flags . 6)
     (:maildir . 24)
     (:from-or-to . 22)
     (:subject))))
 '(mu4e-user-mail-address-list
   (quote
    ("s.sinayoko@soton.ac.uk" "ss53g10@soton.ac.uk" "s.sinayoko@eng.cam.ac.uk" "ss2059@cam.ac.uk" "samuel.sinayoko@gmail.com")))
 '(org-agenda-files
   (quote
    ("~/Dropbox/docs/organisation/todo.org" "~/Dropbox/docs/organisation/agenda.org" "~/Dropbox/docs/organisation/journal.org" "~/Dropbox/docs/organisation/learn.org")))
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "/usr/bin/kpdf %s"))))
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 1.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-latex-table-caption-above nil)
 '(org-latex-to-mathml-convert-command "java -jar %j -unicode -force -df %o %I")
 '(org-latex-to-mathml-jar-file
   "/Users/sinayoks/docs/share/conferences/2015/wtn2015/mathtoweb.jar")
 '(org-mobile-agendas (quote all))
 '(org-modules (quote (org-bibtex org-docview org-habit)))
 '(org-odt-convert-process "LibreOffice")
 '(org-odt-convert-processes
   (quote
    (("LibreOffice" "/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to %f%x --outdir %d %i")
     ("unoconv" "unoconv -f %f -o %d %i"))))
 '(org-odt-preferred-output-format "docx")
 '(package-selected-packages
   (quote
    (dockerfile-mode feature-mode jupyter interleave ox-gfm symon counsel swiper leuven-theme ein exec-path-from-shell conda yasnippet yaml-mode wgrep-ag w3m use-package smex slime realgud rainbow-mode quack projectile php-mode paredit pandoc-mode outshine outorg org-mac-iCal ob-ipython notmuch navi-mode naquadah-theme multiple-cursors monky magit ledger-mode latex-extra json-mode jedi-direx idomenu hyperbole expand-region erlang elpy auto-compile anaconda-mode ag)))
 '(pdf-view-command pdf-viewer)
 '(ps-view-command pdf-viewer)
 '(py-ipython-execute-delay 0.3)
 '(py-shell-name "~/anaconda/bin/ipython")
 '(python-shell-interpreter "ipython")
 '(safe-local-variable-values
   (quote
    ((conda-project-env-name . "mlbook")
     (visual-line-mode)
     (eval setq-local org-babel-default-header-args:IPython
	   (quote
	    ((:session . "feeg6002"))))
     (eval setq-local org-babel-default-header-args:Python
	   (quote
	    ((:session . "feeg6002"))))
     (speck-dictionary . hu))))
 '(scroll-bar-mode (quote right))
 '(send-mail-function (quote smtpmail-send-it))
 '(sp-ignore-modes-list
   (quote
    (calc-mode dired-mode gnus-article-mode gnus-group-mode gnus-summary-mode ibuffer-mode magit-branch-manager-mode magit-commit-mode magit-diff-mode magit-key-mode magit-log-mode magit-reflog-mode magit-stash-mode magit-status-mode magit-wazzup-mode minibuffer-inactive-mode monky-mode sr-mode term-mode)))
 '(sql-sqlite-program "sqlite3")
 '(term-bind-key-alist
   (quote
    (("C-c C-c" . term-interrupt-subjob)
     ("C-p" . previous-line)
     ("C-n" . next-line)
     ("C-s" . isearch-forward)
     ("C-r" . isearch-backward)
     ("C-m" . term-send-raw)
     ("M-b" . term-send-backward-word)
     ("M-p" . term-send-up)
     ("M-n" . term-send-down)
     ("M-M" . term-send-forward-kill-word)
     ("M-N" . term-send-backward-kill-word)
     ("M-r" . term-send-reverse-search-history)
     ("M-," . term-send-input)
     ("M-." . comint-dynamic-complete))) t)
 '(transient-mark-mode 1)
 '(w3m-key-binding (quote info))
 '(w3m-use-cookies t))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(speck-mouse ((((class color)) (:background "brown"))))
;;  '(speck-query ((((class color)) (:background "red"))))
;;  '(term-color-blue ((t (:background "dodger blue" :foreground "dodger blue"))))
;;  '(term-color-cyan ((t (:background "cyan2" :foreground "cyan2"))))
;;  '(term-color-green ((t (:background "#6ac214" :foreground "#6ac214"))))
;;  '(term-color-magenta ((t (:background "magenta" :foreground "magenta"))))
;;  '(term-color-red ((t (:background "tomato" :foreground "tomato"))))
;;  '(term-color-yellow ((t (:background "#edd400" :foreground "#edd400")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ledger-font-xact-highlight-face ((t (:background "gray3"))))
 '(speck-mouse ((t (:background "Purple"))))
 '(speck-query ((t (:background "Orange")))))
(put 'ido-exit-minibuffer 'disabled nil)
