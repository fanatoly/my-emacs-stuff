;;; stone-mode.el --- Major mode for Stone IDL files -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defconst stone-mode-font-lock-keywords
  (list
   '("#.*$" . font-lock-comment-face)
   '("\\<\\(alias\\|attrs\\|default\\|deprecated\\( by\\)?\\|example\\|extends\\|import\\|namespace\\|route\\|struct\\|union_closed\\|union\\)\\>" . font-lock-keyword-face)
   '("\\<\\(Bytes\\|Boolean\\|\\(Float\\|U?Int\\)\\(32\\|64\\)\\|List\\|String\\|Timestamp\\|Void\\)\\>" . font-lock-type-face)
   '("\\<\\([A-Z][A-Za-z0-9_]*\\)" . font-lock-type-face)
   '("\\<\\(true\\|false\\)\\>" . font-lock-constant-face)
   )
  "Font lock keywords for `stone-mode'.")

(defvar stone-mode-indent-offset 4
  "The indentation offset for Stone IDL files.")

(defun stone-mode-indent-line ()
  "Indent the current line as a Stone IDL file."
  (interactive)
  (beginning-of-line)
  (if (bobp)
      (indent-line-to 0)
    (let (max-indent)
      (save-excursion
        (forward-line -1)
        (while (looking-at "^[:space:]*$")
          (forward-line -1))
        (setq max-indent (+ (current-indentation) stone-mode-indent-offset)))
      (let ((new-indent (+ (current-indentation) stone-mode-indent-offset)))
        (if (> new-indent max-indent)
            (indent-line-to 0)
          (indent-line-to new-indent))))))

(define-derived-mode stone-mode fundamental-mode "Stone"
  "Major mode for editing Stone IDL files."
  (set (make-local-variable 'font-lock-defaults) '(stone-mode-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'stone-mode-indent-line)
  (set (make-local-variable 'electric-indent-inhibit) t))

;; TODO set a custom `fill-paragraph-function' when loading `stone-mode'

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.stone\\'" . stone-mode))

(provide 'stone-mode)
