(require 'ensime)

;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;; (add-hook 'java-mode-hook 'ensime-scala-mode-hook)

(add-to-list 'auto-mode-alist '("\\.scala" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.gradle" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.groovy" . groovy-mode))
(require 'compile)
(add-to-list 'compilation-error-regexp-alist 'maven)
(add-to-list 'compilation-error-regexp-alist-alist
       '(maven "\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*"
           1 2 3))


(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 4
				  tab-width 4
				  indent-tabs-mode nil)))

(require 'java-mode-indent-annotations)

(add-hook 'java-mode-hook 'java-mode-indent-annotations-setup)

(defun sbt:fix-prompt-in-comint ()
  (setq inhibit-read-only t))
(add-hook 'sbt-mode-hook 'sbt:fix-prompt-in-comint)

(define-key ensime-mode-map (kbd "C-c C-d d")'ensime-db-attach)

(setq ensime-sbt-command "sbt")

(set-face-attribute 'ensime-implicit-highlight nil :underline nil)


(defun sbt-restart ()
  (interactive)
  (sbt:run-sbt t t))

(defun comint-hard-quit-subjob ()
  "Send quit signal to the current subjob.
This command also kills the pending input
between the process mark and point."
  (interactive)
  (quit-process nil comint-ptyp))


(defun comint-hard-quit-subjob ()
  "Send quit signal to the current subjob.
This command also kills the pending input
between the process mark and point."
  (interactive)
  (interrupt-process nil comint-ptyp))
