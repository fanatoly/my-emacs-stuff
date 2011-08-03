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
  (if (and (boundp 'compilation-last-buffer) (not (eq compilation-last-buffer nil)))
       (save-excursion 
         (set-buffer compilation-last-buffer)
         (select-window (get-buffer-window compilation-last-buffer))
         (end-of-buffer)
        )
   (print "No compile window available"))
   )  

(global-set-key [C-f3] 'bring-up-compilation)

;; making sure that compilation shows me the end
(add-hook 'compilation-mode-hook 'compilitation-to-buffer-end)
