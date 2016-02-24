(add-hook 'coffee-mode-hook (lambda ()
			    (setq c-basic-offset 4
				  tab-width 4
				  js-indent-level 2
				  coffee-tab-width 2
				  indent-tabs-mode t)))
(add-hook 'js-mode-hook (lambda ()
			  (setq c-basic-offset 4
				tab-width 4
				js-indent-level 2
				coffee-tab-width 2
				indent-tabs-mode nil)))
(defun nvm-use-current ()
  (interactive)
  (nvm-use-for))
