(if (eq 'darwin system-type)
    (progn
      (exec-path-from-shell-initialize)
      (setenv "HEROKU_NODE_PATH"
	      (concat (getenv "HOME") "/.local/share/heroku/cli/lib/node"))
      (setenv "LANG" "en_US.UTF-8")
      (setenv "EDITOR" "emacsclient")))
