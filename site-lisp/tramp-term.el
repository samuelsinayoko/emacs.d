;; Various bits of code here were lifted from 
;; http://www.emacswiki.org/emacs-se/AnsiTermHints
;;
;; The intent of this is to wrap the tramp directory tracking
;; in a convenient and reusable way.

(require 'term)

(defun tramp-term ()
  "Create an ansi-term running ssh sesstion and automatically
enable tramp integration in that terminal."
  (interactive)
  (let ((hostname (tt--select-host))
        (prompt-bound nil))
    (tt--do-ssh-login hostname)
    (tt--initialize-tramp hostname))
  (message "tramp-term initialized"))

(defun tt--do-ssh-login (hostname)
  "Perform the ssh login dance.  Supports password or cert logins
to HOSTNMAE."
  (let ((buffer-uniquifier 1)
        (buffer-name hostname))
    (while (get-buffer (format "*%s*" buffer-name))
      (setq buffer-uniquifier (1+ buffer-uniquifier))
      (setq buffer-name (format "%s<%d>" hostname buffer-uniquifier)))
    (tt--create-term buffer-name "ssh" hostname))
  (save-excursion
    (while (not (search-backward "Last login:" nil t))
      (let ((prompt-pos (tt--find-password-prompt prompt-bound)))
        (if (not prompt-pos)
            (sleep-for 0.1)
          (setq prompt-bound (1+ prompt-pos))
          (term-send-raw-string (concat (read-passwd "Password: ") "
")))))))

(defun tt--initialize-tramp (hostname)
  "Send bash commands to set up tramp integration."
  (term-send-raw-string (format "
function set-eterm-dir {
    echo -e \"\\033AnSiTu\" \"$USER\"
    echo -e \"\\033AnSiTc\" \"$PWD\"
    echo -e \"\\033AnSiTh\" \"%s\"
    history -a
}
PROMPT_COMMAND=set-eterm-dir
clear
" hostname)))

(defun tt--select-host ()
  "Return a host from a list of hosts."
  (completing-read "[user@]host: " (tt--parse-hosts-from-ssh-config)))

(defun tt--parse-hosts-from-ssh-config ()
  "Parse any host directives from ~/.ssh/config and return them
as a list of strings"
  (with-temp-buffer
    (insert-file-contents "~/.ssh/config")
    (let ((beg (point)))
      (while (search-forward-regexp "^host[[:blank:]]+" nil t)
        (delete-region beg (point))
        (end-of-line)
        (insert " ")
        (setq beg (point))))
    (delete-region (1- (point)) (point-max))
    (replace-regexp "[[:blank:]]+" "\" \"" nil (point-min) (point-max))
    (read (concat "(\"" (buffer-string) "\")"))))

(defun tt--find-password-prompt (bound)
  "Search backward for a password or passphrase and return it's
starting position or nil.  Do not search backward past BOUND"
  (search-backward-regexp "\\(password\\|passphrase.*\\):" bound t))

(defun tt--create-term (new-buffer-name cmd &rest switches)
  "Create an ansi-term running an arbitrary command, including
extra parameters."
  (setq term-ansi-buffer-name new-buffer-name)
  (setq term-ansi-buffer-name (generate-new-buffer-name term-ansi-buffer-name))
  (setq term-ansi-buffer-name (apply 'make-term term-ansi-buffer-name cmd nil switches))
  (set-buffer term-ansi-buffer-name)
  (term-mode)
  (term-char-mode)
  (term-set-escape-char ?\C-x)
  (switch-to-buffer term-ansi-buffer-name))

(provide 'tramp-term)
