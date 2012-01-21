(require 'savehist "savehist")

;; Saves state when emacs exits
;; Would be nice to modify the default per user
(add-to-list 'savehist-additional-variables 'search-ring)
(add-to-list 'savehist-additional-variables 'regexp-search-ring)
(add-to-list 'savehist-additional-variables 'kill-ring)

(savehist-mode 1)
