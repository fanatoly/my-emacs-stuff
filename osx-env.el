(if (eq 'darwin system-type)
    (progn
      (exec-path-from-shell-initialize)
       (setenv "LANG" "en_US.UTF-8"))
  )
