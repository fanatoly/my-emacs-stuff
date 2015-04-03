;; Key binding for the magit plugin

(defun magit-log-graph (&optional range)
  (interactive)
  (cond ((not range) (setq range "HEAD"))
        ;; Forward compatibility kludge.
        ((listp range) (setq range (car range))))
  (magit-mode-setup magit-log-buffer-name nil
                    #'magit-log-mode
                    #'magit-refresh-log-buffer
                    'oneline range (cons "--graph" magit-custom-options)))


(defun magit-push-force ()
  (let ((magit-custom-options "-f"))
    (progn
      (setq this-command 'magit-push)
      (call-interactively this-command))))


(global-set-key [(control ?c)(?g)(?s)] 'magit-status)
(global-set-key [(control ?c)(?g)(?u)] 'magit-pull)
(global-set-key [(control ?c)(?g)(?p)] 'magit-push)
(global-set-key [(control ?c)(?g)(?P)] 'magit-push-force)
(global-set-key [(control ?c)(?g)(?l)] 'magit-log-graph)
(global-set-key [(control ?c)(?g)(?b)] 'magit-branch-manager)
