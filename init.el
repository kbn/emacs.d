;; Make sure ELPA packages are loaded before init
(when (require 'package nil t)
  (setq package-enable-at-startup nil)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.org/packages/") t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
  (package-initialize))

(defvar default-font-family (if (member "Consolas" (font-family-list))
				"Consolas"
			      "DejaVu Sans Mono"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#002b36" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(case-fold-search t)
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(compile-command "DEBUG=1 make -j 2 -k")
 '(current-language-environment "English")
 '(custom-safe-themes
   (quote
    ("bf3ec301ea82ab546efb39c2fdd4412d1188c7382ff3bbadd74a8ecae4121678" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "fd0d98a75fb613edc1b4f1b8ca866a0315b494a21b44a93e15b47a096334a064" default)))
 '(delete-selection-mode t nil (delsel))
 '(desktop-enable t nil (desktop))
 '(fci-rule-color "#073642")
 '(global-font-lock-mode t nil (font-lock))
 '(grep-files-aliases
   (quote
    (("asm" . "*.[sS]")
     ("c" . "*.c")
     ("cc" . "*.cc *.cxx *.cpp *.C *.CC *.c++")
     ("cchh" . "*.cc *.[ch]xx *.[ch]pp *.[CHh] *.CC *.HH *.[ch]++")
     ("hh" . "*.hxx *.hpp *.[Hh] *.HH *.h++")
     ("ch" . "*.[ch] *.[ch]pp")
     ("el" . "*.el")
     ("h" . "*.h")
     ("l" . "[Cc]hange[Ll]og*")
     ("m" . "[Mm]akefile*")
     ("tex" . "*.tex")
     ("texi" . "*.texi"))))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(magit-diff-use-overlays nil)
 '(magit-use-overlays nil)
 '(menu-bar-mode nil)
 '(org-agenda-files
   (quote
    ("~/shared/Projects/Autostore/asplanner.org" "~/shared/doc/Cavatina/2010/Regnskap.org" "~/shared/org/cavatina.org" "~/shared/org/gtd.org")))
 '(package-selected-packages (quote (markdown-mode groovy-mode)))
 '(py-python-command "ipython")
 '(py-python-command-args (quote ("-i")))
 '(safe-local-variable-values
   (quote
    ((c-basic-offset 4)
     (eval when
	   (require
	    (quote rainbow-mode)
	    nil t)
	   (rainbow-mode 1)))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t nil (paren))
 '(solarized-distinct-fringe-background t)
 '(solarized-high-contrast-mode-line t)
 '(syslog-debug-face
   (quote
    ((t :background unspecified :foreground "#2aa198" :weight bold))))
 '(syslog-error-face
   (quote
    ((t :background unspecified :foreground "#dc322f" :weight bold))))
 '(syslog-hour-face (quote ((t :background unspecified :foreground "#859900"))))
 '(syslog-info-face
   (quote
    ((t :background unspecified :foreground "#268bd2" :weight bold))))
 '(syslog-ip-face (quote ((t :background unspecified :foreground "#b58900"))))
 '(syslog-su-face (quote ((t :background unspecified :foreground "#d33682"))))
 '(syslog-warn-face
   (quote
    ((t :background unspecified :foreground "#cb4b16" :weight bold))))
 '(tool-bar-mode nil nil (tool-bar))
 '(transient-mark-mode t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#b58900")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#859900")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#2aa198")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(vc-handled-backends (quote (Bzr Git Hg Mtn Arch SVN CVS SCCS RCS)))
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight normal :height 101 :width normal :foundry "unknown" :family font-family-default))))
 '(diff-added ((t (:foreground "forest green"))))
 '(diff-removed ((t (:foreground "red3"))))
 '(diff-removed-face ((t (:foreground "Red"))) t)
 '(mode-line ((((type x w32 mac) (class color)) (:background "grey75" :foreground "black")))))

(defun load-init (fname)
  "Load .el init file from .emacs.d/"
  (let ((path (concat (file-name-directory
		       (or load-file-name buffer-file-name))
		      fname ".el")))
    (when (file-exists-p path)
      (load-file path)
      t)))

(load-init "platform")

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
(add-to-list 'load-path "~/prog/slime")
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/org-mode/lisp")

(server-start)

;(require 'nxml)

(setq tex-dvi-view-command "xdvi")
(setq scalable-fonts-allowed t)

(global-set-key [(meta g)] 'goto-line)
(global-set-key [(meta y)] 'clipboard-yank)
(global-set-key [(meta w)] 'clipboard-kill-ring-save)
(global-set-key [(meta r)] 'rgrep)
(global-set-key [(meta c)] 'compile)

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

; (global-set-key (kbd "M-SPC") 'set-mark-command)

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

(defun celsius ()
  "Insert °C"
  (interactive)
  (insert "°C"))

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

(when (require 'ffap nil t)
  (defun my-c-make-function-from-prototype ()
    "Turn a function prototype into a skeleton implementation."
    (interactive)
    (let (ret-val fcn-name args const namespaces start-of-fcn)
      (save-excursion
	(end-of-line)
	(c-beginning-of-statement 1)
	(beginning-of-line)
	(when (re-search-forward
	       "\\s-*\\(.*\\s-+[\\*|&]?\\)\\([-a-zA-Z0-9_!=<>~]+\\)\\s-*[(]" nil t)
;	       "\\s-*\\(.*\\)\\s-+\\([-a-zA-Z0-9_!=<>~]+\\)\\s-*[(]" nil t)
	  (setq ret-val (match-string 1))
	  (setq ret-val (replace-regexp-in-string "\\(virtual\\|static\\)\\s-*" "" ret-val))
;	  (setq ret-val (replace-regexp-in-string "\\s-+$" "" ret-val))
	  (setq fcn-name (match-string 2))
	  (when (re-search-forward "\\([^)]*\\)[)]" nil t)
	    (setq args (match-string 1))
	    (setq args (replace-regexp-in-string "\\s-*=.+?," "," args))
	    (setq args (replace-regexp-in-string "\\s-*=.+?)" ")" args))
	    (setq args (replace-regexp-in-string "\\s-*=.+?$" "" args))
	    (if (looking-at "\\s-*const")
		(setq const " const")
	      (setq const ""))
	    (condition-case nil
		(while 't
		  (backward-up-list 1)
		  (when (re-search-backward
			 "\\(class\\|namespace\\|struct\\)\\s-+\\([a-zA-Z0-9_]+\\)" nil t)
		    (setq namespaces (concat (match-string 2) "::" namespaces))))
	      (error nil)))))
      ;; Switch to other file and insert implementation
      (ff-get-other-file)
      (setq start-of-fcn (point))
      (insert (concat "\n" ret-val ;(unless (string= ret-val "") " ")
		      namespaces fcn-name "(" args ")" const))
      (insert "\n{\n}\n")
      (unless (eobp)
	(insert "\n"))
      (indent-region start-of-fcn (point) nil)
      (goto-char start-of-fcn)
      (when (fboundp 'doxymacs-insert-function-comment)
	(doxymacs-insert-function-comment))))
  (global-set-key "\C-xf" 'my-c-make-function-from-prototype))

(when (require 'doxymacs nil t)
  (add-hook 'c-mode-common-hook 'doxymacs-mode)
  (defun my-doxymacs-font-lock-hook ()
    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
        (doxymacs-font-lock)))
  (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook))

(defun strip-trailing-whitespace ()
  "remove all whitespace from the end of lines in the entire buffer"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\s-+$" nil t)
      (replace-match ""))))

;; Force gdb-mi to not dedicate any windows
(defadvice gdb-display-buffer (after undedicate-gdb-display-buffer)
  (set-window-dedicated-p ad-return-value nil))
(ad-activate 'gdb-display-buffer)

(defadvice gdb-set-window-buffer (after undedicate-gdb-set-window-buffer (name &optional ignore-dedi window))
  (set-window-dedicated-p window nil))
(ad-activate 'gdb-set-window-buffer)

(load-init "window")
(load-init "git")
(load-init "cl")
(load-init "org")
(load-init "autostore")
(load-init "tex")
(or (load-init "local")
    (load-init "local-default"))

(load-init "htmlize")

(autoload 'smart-tabs-mode "smart-tabs-mode"
  "Intelligently indent with tabs, align with spaces!")
 (autoload 'smart-tabs-mode-enable "smart-tabs-mode")
 (autoload 'smart-tabs-advice "smart-tabs-mode")
 (autoload 'smart-tabs-insinuate "smart-tabs-mode")

(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python
		      'ruby 'nxml)

(require 'desktop)
