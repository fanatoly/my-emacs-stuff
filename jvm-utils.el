(require 'ensime)
(require 'scala-mode2)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'java-mode-hook 'ensime-scala-mode-hook)

(add-to-list 'auto-mode-alist '("\\.scala" . scala-mode))
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
