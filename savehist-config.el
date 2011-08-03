(require 'savehist-20+ "savehist")
(require 'maxframe)
(add-hook 'window-setup-hook 'restore-frame)

;; Saves state when emacs exits
;; Would be nice to modify the default per user
(add-to-list 'savehist-additional-variables 'search-ring)
(add-to-list 'savehist-additional-variables 'regexp-search-ring)
(add-to-list 'savehist-additional-variables 'kill-ring)
(add-to-list 'savehist-additional-variables 'mf-restore-width)
(add-to-list 'savehist-additional-variables 'mf-restore-height)
(add-to-list 'savehist-additional-variables 'mf-restore-top)
(add-to-list 'savehist-additional-variables 'mf-restore-left)

(add-hook 'savehist-save-hook 'mf-save-window-geom)

(savehist-mode 1)
