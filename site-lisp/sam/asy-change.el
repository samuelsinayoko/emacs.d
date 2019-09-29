(defun change-width-height-cmax(w h cmax)
  "Change width and height in asymptote script"
  (interactive "nwidth [0]: \nnheight [0]: \nncmax [0]:")
  (when (not (= w 0))
    (save-excursion
      (when (re-search-forward "real width= \\(.*\\)cm;")
	(replace-match (format "real width= %2.2fcm;" w)))))
  (when (not (= h 0))
    (save-excursion
      (when (re-search-forward "real height=[ ]?\\(.*\\)cm;")
	(replace-match (format "real height= %2.2fcm;" h)))))
  (when (not (= cmax 0))
    (save-excursion
      (re-search-forward "range clim=Range(-\\(.*\\), \\1);")
      (replace-match (format "range clim=Range(-%f, %f);" cmax cmax))
      ;; Change value in cmax.org
      (let ((filename (buffer-name))
	    (dir (car (last (split-string  default-directory "/") 2))))
	(save-current-buffer
	  (set-buffer (get-buffer-create "cmax.org"))
	  (save-excursion
	    (goto-char (point-min))
	    (search-forward dir)
	    (search-forward filename)
	    (when (re-search-forward "cmax = \\(.*\\)e-")
	      (replace-match (format "cmax = %2.2fe-" cmax)))))))))
	      



