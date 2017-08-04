(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ;; ("marmalade" . "http://marmalade-repo.org/packages")
			 ("melpa-stable" . "https://melpa-stable.milkbox.net/packages/")
			 ("melpa" . "https://melpa.milkbox.net/packages/")))


(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))


;; Add in your own as you wish:
(setq my-packages
      '(lua-mode
	scala-mode2
	magit
	find-file-in-project
	coffee-mode
	protobuf-mode
	icicles
	markdown-mode
	go-mode
	gist
	yagist
	find-file-in-repository
	ess
	ess-R-data-view
	ess-R-object-popup
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

(use-package projectile
  :demand
  :pin melpa-stable
  :init   (set projectile-use-git-grep t)
  :config (projectile-global-mode t)
  :bind   (("C-x g" . projectile-grep)))


(require 'use-package)

