(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ;; ("marmalade" . "http://marmalade-repo.org/packages")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))


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
	exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
