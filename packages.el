(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages")
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
	find-file-in-repository))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))



