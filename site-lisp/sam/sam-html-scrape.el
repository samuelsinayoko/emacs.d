(require 'sgml-mode)
(defun sam-html-scrape-buffer-tag (tag &optional drop-tag)
  "Scrape tag within this buffer"
  (save-excursion
    (goto-char 1)
    (search-forward (format "<%s" tag))
    (if drop-tag
	(search-forward ">")
      (search-backward "<"))
    (setq p1 (point)) ; beginning of tag
    (backward-char)
    (sgml-skip-tag-forward 1)
    (if drop-tag
	(search-backward "<"))
    (buffer-substring p1 (point))))

(defun sam-html-scrape-string-tag (string tag &optional drop-tag)
  "Remove tag from string"
  (interactive)
  (with-temp-buffer
    (insert string)
    (sam-html-scrape-buffer-tag tag drop-tag)))

(defun sam-html-scrape-file-tag (filename tag &optional drop-tag)
  "Get content of tag in html file. For example (sam-html-tag-content \"test.html\" \"body\") returns the content of the body.
"
  (interactive)
  (let (string)
    (save-excursion
      (find-file filename)
      (sam-html-scrape-buffer-tag tag drop-tag))))

;; test buffer
(defun sam-html-scrape-tag-test (filename)
  (interactive)
  (progn
    (let (string)
      (find-file "test0.html")
      (insert-file-contents filename)
      (setq string (sam-html-scrape-buffer-tag  "head" t))
      (erase-buffer)
      (insert string)))

  ;; test string
  (progn
    (let (string)
      (find-file "test0.html")
      (insert-file-contents filename)
      (setq string (sam-html-scrape-buffer-tag  "head" t))
      (erase-buffer)
      (insert (sam-html-scrape-string-tag string "style")))) 

  ;; test file
  (progn
    (find-file "test2.html")
    (erase-buffer) 
    (insert (sam-html-scrape-file-tag filename "script"))
    (newline)
    (insert (sam-html-scrape-file-tag filename "style")))

  (progn
    (find-file "test3.html")
    (erase-buffer) 
    (insert (sam-html-scrape-file-tag filename "body" t))))

(provide 'sam-html-scrape)
