;;compilation helper
(defun bring-up-compilation ()
  "Brings up compilation"
  (interactive)
  (if (and (boundp 'compilation-last-buffer) (not (eq compilation-last-buffer nil)))
      (set-window-buffer (selected-window) compilation-last-buffer)
    (print "No compile window available"))
  )

(defun compilitation-to-buffer-end ()
  "Takes the compilation buffer to the end"
  (interactive)
  (if (and (boundp 'compilation-last-buffer) (not (eq compilation-last-buffer nil)) (bufferp 'compilation-last-buffer))
       (save-excursion 
         (set-buffer compilation-last-buffer)
         (select-window (get-buffer-window compilation-last-buffer))
         (end-of-buffer)
        )
   (print "No compile window available"))
   )  


(global-set-key [f3] 'compile)
(global-set-key [C-f3] 'bring-up-compilation)

;; making sure that compilation shows me the end
(add-hook 'compilation-mode-hook 'compilitation-to-buffer-end)

;; make sure ansi sequences are filtered out.
(defun fanatoly-apply-ansi-color-current-buffer ()
 (ansi-color-apply-on-region (point-min) (point-max) ) )

(add-hook 'compilation-filter-hook 'fanatoly-apply-ansi-color-current-buffer)
