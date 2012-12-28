(require 'find-file-in-project)
(add-to-list 'ffip-patterns "*.java")
(setq ffip-limit (* 4096 16))
(global-set-key (kbd "C-c p f") 'find-file-in-project)

