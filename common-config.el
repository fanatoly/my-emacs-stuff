;; I've never used emacs scroll bars
(toggle-scroll-bar -1)
;; or the toolbar
(tool-bar-mode 0)
;; Adds Ctrl-x [arrow key] window arrangement history keybinding
(winner-mode)

;; Adds Ctrl-[arrow key] window movement
(windmove-default-keybindings)

;; after selecting a region, keeps it highlighted
(transient-mark-mode t)
(delete-selection-mode t)

;; Set foreground and background
(set-foreground-color "white")
(set-background-color "black")

;; don't show GNU splash screen
(setq inhibit-startup-message t)


(put 'set-goal-column 'disabled nil)

;; ** Maximum colors
(setq font-lock-maximum-decoration t)

;;line wrapping
(setq truncate-partial-width-windows nil)

;; makes 'y' or 'n' suffice for yes or no answers
(fset 'yes-or-no-p 'y-or-n-p)

(ansi-color-for-comint-mode-on)

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)

;;Get the clipboard to work
(setq x-select-enable-clipboard t)

;; searching and replacing
(setq query-replace-highlight t)

;;Shifts the brace two spots back
(setq c-continued-brace-offset -2)

;; uses distinctive path parts to identify identically named buffers
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

(if (functionp 'ns-toggle-fullscreen) (ns-toggle-fullscreen))

(add-to-list 'auto-mode-alist '("\\.log\\|\\.out" . auto-revert-tail-mode))
(add-to-list 'auto-mode-alist '("\\.hbs" . html-mode))

(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq ediff-window-setup-function 'ediff-setup-windows-plain) ;; Tiling window managers + OS X Yosemite fullscreen poop make it better to use the inline ediff mode.

(setq indent-tabs-mode nil)

(ido-mode)

;; larger monitors lead to excessive splitting
(setq split-height-threshold 100)
