(when (require 'package nil t)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/") t))

(global-set-key "\C-xg" 'magit-status)

(when (require 'magit nil t)
  ;; no highlight
  (defun magit-highlight-section ()))

;; Load ssh-agency.el helper on windows, if available.
(ignore-errors
  (load "ssh-agency.el"))
