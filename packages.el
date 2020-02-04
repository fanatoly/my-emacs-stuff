(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ;; ("marmalade" . "http://marmalade-repo.org/packages")
			 ("melpa-stable" . "http://stable.melpa.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))


(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))


;; Add in your own as you wish:
(setq my-packages
      '(lua-mode
        magit
	scala-mode
	find-file-in-project
	coffee-mode
	protobuf-mode
	markdown-mode
	gist
	yagist
	find-file-in-repository
	ess
	ess-R-data-view
	sbt-mode
	rvm
	ensime
	rspec-mode
	haml-mode
	exec-path-from-shell
	thrift
	groovy-mode
	virtualenv
	pyenv-mode
	nvm
	anaconda-mode
	xterm-color
	multi-term
	projectile
	use-package))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(use-package ensime
  :ensure t
  :pin melpa)

(use-package tide
  :ensure t
  :demand
  :config (add-hook 'typescript-mode-hook
		    (lambda()
		      (progn
			(tide-setup)
			(flycheck-mode)
			(setq flycheck-check-syntax-automatically '(save mode-enabled)))))
  :config (setq tide-server-max-response-length most-positive-fixnum)
  :config
  :config
  :pin melpa)

(use-package bazel-mode
  :ensure t
  :demand
  :mode "\\.bzl\\'"
  :mode "BUILD"
  :pin melpa-stable)

(use-package typescript-mode
  :ensure t
  :demand
  :mode "\\.ts\\'"
  :mode "\\.tsx\\'"
  :config (setq typescript-indent-level 2)
  :config (c-set-offset 'case-label '+)
  :pin melpa-stable)

(use-package prettier-js
  :ensure t
  :demand
  :config (add-hook 'typescript-mode-hook 'prettier-js-mode))

(use-package projectile
  :demand
  :pin melpa-stable
  :init   (setq projectile-use-git-grep t)
  :config (projectile-global-mode t)
  :config (setq projectile-enable-caching t)
  ;; legacy projectile keybinding
  :bind   (("C-c p s g" . projectile-grep)))

(use-package go-mode
  :ensure t
  :demand
  :pin melpa-stable)


(use-package direnv
  :ensure t
  :demand
  :pin melpa-stable)

(use-package elisp-format
  :ensure t
  :demand
)

(use-package magit-rbr
  :ensure t
  :demand)

(require 'stone-mode)
(require 'bazel-build)

(use-package package-lint
  :ensure t
  :demand)


(require 'use-package)

