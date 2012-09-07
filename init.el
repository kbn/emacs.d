(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(column-number-mode t)
 '(compile-command "DEBUG=1 make -j 2 -k")
 '(current-language-environment "English")
 '(delete-selection-mode t nil (delsel))
 '(desktop-enable t nil (desktop))
 '(global-font-lock-mode t nil (font-lock))
 '(grep-files-aliases (quote (("asm" . "*.[sS]") ("c" . "*.c") ("cc" . "*.cc *.cxx *.cpp *.C *.CC *.c++") ("cchh" . "*.cc *.[ch]xx *.[ch]pp *.[CHh] *.CC *.HH *.[ch]++") ("hh" . "*.hxx *.hpp *.[Hh] *.HH *.h++") ("ch" . "*.[ch] *.[ch]pp") ("el" . "*.el") ("h" . "*.h") ("l" . "[Cc]hange[Ll]og*") ("m" . "[Mm]akefile*") ("tex" . "*.tex") ("texi" . "*.texi"))))
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/shared/Projects/Autostore/asplanner.org" "~/shared/doc/Cavatina/2010/Regnskap.org" "~/shared/org/cavatina.org" "~/shared/org/gtd.org")))
 '(py-python-command "ipython")
 '(py-python-command-args (quote ("-i")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t nil (paren))
 '(tool-bar-mode nil nil (tool-bar))
 '(transient-mark-mode t)
 '(vc-handled-backends (quote (Bzr Git Hg Mtn Arch SVN CVS SCCS RCS))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "Green"))))
 '(diff-removed ((t (:foreground "Red"))))
 '(mode-line ((((type x w32 mac) (class color)) (:background "grey75" :foreground "black")))))

(add-to-list 'load-path "~/.emacs.d")
(load "platform")

(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8)
  (setq font-lock-use-default-fonts nil)
  (setq font-lock-use-default-colors t)
  (setq delete-key-deletes-forward t)
  (setq c-electric-delete 'delete-char)
  (setq c-delete-function 'delete-char)) ;;c-electric-delete delete-char))

(defun linux-c++-mode ()
  "C++ mode with adjusted defaults."
  (interactive)
  (c++-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8)
  (setq font-lock-use-default-fonts nil)
  (setq font-lock-use-default-colors t)
  (setq delete-key-deletes-forward t)
  (setq c-electric-delete 'delete-char)
  (setq c-delete-function 'delete-char)) ;;c-electric-delete delete-char))

(setq auto-mode-alist
      (append '(("\\.C$"  . linux-c++-mode)
		("\\.cs$" . linux-c++-mode)
		("\\.cc$" . linux-c++-mode)
		("\\.cpp$" . linux-c++-mode)
		("\\.hh$" . linux-c++-mode)
		("\\.c$"  . linux-c-mode)
		("\\.h$"  . linux-c++-mode)
		("\\.H$"  . linux-c-mode)
		("\\.ASM$". asm-mode)
		("\\.asm$". asm-mode)
		("\\.A51$". asm-mode)
		("\\.a51$". asm-mode)
		("\\.CAS$". linux-c-mode)
		("\\.cos$". cos-mode)
		("\\.wsf$". javascript-mode)
		("\\.cas$". linux-c-mode))
	      auto-mode-alist))

(add-to-list 'load-path "~/lisp/org/lisp")
(require 'desktop)

(server-start)

;(require 'nxml)

(setq tex-dvi-view-command "xdvi")
(setq scalable-fonts-allowed t)

(global-set-key [(meta g)] 'goto-line)
(global-set-key [(meta y)] 'clipboard-yank)
(global-set-key [(meta w)] 'clipboard-kill-ring-save)

(global-set-key [(super f1)] 'compile)
(global-set-key [(super f2)] 'rgrep)
;(global-set-key [(meta f3)] 'desktop-read)
(global-set-key [(control delete)] 'kill-region)
(global-set-key [f12] 'compile)

(global-set-key [(meta n)] 'next-error)
(global-set-key [(meta p)] 'previous-error)

(global-set-key [(super f)] 'slime-toggle-profile-fdefinition)
(global-set-key [(super r)] 'slime-profile-report)

(setq compilation-window-height 16)

(global-set-key [(meta s)] 'tags-search)

(global-set-key (kbd "C-c o") 'occur)

(setq gnus-select-method '(nntp "news.gmane.org"))
(setq visible-bell t)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)

(put 'downcase-region 'disabled nil)

(defun do-revert-buffer()
  "revert buffer without asking for confirmation"
  (interactive "")
  (revert-buffer t t))

(defun do-term()
  "run default term"
  (interactive)
  (term (getenv "SHELL")))

(global-set-key "\C-xv" 'do-revert-buffer)
(global-set-key "\C-xt" 'do-term)

;(setq grep-find-command
;      "find . -type f \".*\" -prune ! \( -name \"*.d\" -name \"*.o\" \) -print0 | xargs -0 -e grep -nH -e ")

(put 'scroll-left 'disabled nil)

(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))


(load "window")
(load "cl")
(load "org")
(load "autostore")
(unless (load "local" t)
  (load "local-default" t))
