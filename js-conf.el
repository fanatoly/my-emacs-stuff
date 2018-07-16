(setenv "NODE_NO_READLINE" "1")
(setq-default indent-tabs-mode nil)
(defun setup-coffee-mode ()
    (progn
      (setq-local c-basic-offset 4)
      (setq-local tab-width 4)
      (setq-local js-indent-level 2)
      (setq-local coffee-tab-width 2)
      (setq-local indent-tabs-mode t)))

(add-hook 'coffee-mode-hook 'setup-coffee-mode)

(defun setup-js-mode ()
  (progn
    (setq-local c-basic-offset 4)
    (setq-local tab-width 4)
    (setq-local js-indent-level 2)
    (setq-local coffee-tab-width 2)
    (setq-local indent-tabs-mode nil)))
(add-hook 'js-mode-hook 'setup-js-mode)

(require 'nvm)
(defun nvm-use-current ()
  (interactive)
  (nvm-use-for))


(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1))

