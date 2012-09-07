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

(defvar running-ms-windows
  (string-match "windows" (prin1-to-string system-type)))

(defvar running-gnu-linux
  (string-match "linux" (prin1-to-string system-type)))

  ;;;;
  ;;;; cygwin support
  ;;;;

  ;; Sets your shell to use cygwin's bash, if Emacs finds it's running
  ;; under Windows and c:\cygwin exists. Assumes that C:\cygwin\bin is
  ;; not already in your Windows Path (it generally should not be).
  ;;
(when running-ms-windows
  (let* ((cygwin-root "c:/cygwin")
         (cygwin-bin (concat cygwin-root "/bin")))
    (when (and (eq 'windows-nt system-type)
  	     (file-readable-p cygwin-root))
    
      (setq null-device "/dev/null")
      (setq exec-path (cons cygwin-bin exec-path))
      (setenv "PATH" (concat cygwin-bin ";" (getenv "PATH")))
    
      ;; NT-emacs assumes a Windows shell. Change to baash.
      (setq shell-file-name "bash")
      (setenv "SHELL" shell-file-name) 
      (setq explicit-shell-file-name shell-file-name) 
    
      ;; This removes unsightly ^M characters that would otherwise
      ;; appear in the output of java applications.
      (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m))))

(add-to-list 'load-path "~/.emacs.d/rinari")
(add-to-list 'load-path "~/.emacs.d/rinari/rhtml")
(require 'rinari nil t)

(when running-ms-windows
  (add-to-list 'load-path "c:/clisp/slime/"))

(if running-ms-windows
    (setq common-lisp-hyperspec-root "file:/c:/lisp/HyperSpec/")
    (setq common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/"))

(setq inferior-lisp-program "clisp -K full")
(when (require 'slime nil t)
  (slime-setup '(slime-repl)))

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/rails")
(when (require 'rails nil t)
  )


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
(when (require 'org-install nil t)
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (setq org-directory "~/shared/org")
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-capture-templates
	`(("t" "Todo" entry (file+headline ,(concat org-directory "/gtd.org") "Tasks")
	   "* TODO %?\n  %i\n  %a")
	  ("d" "Todo (context-free)" entry (file+headline ,(concat org-directory "/gtd.org") "Tasks")
	   "* TODO %?")
	  ("j" "Journal" entry (file+datetree ,(concat org-directory "/journal.org"))
	   "* %?\nEntered on %U\n  %i\n  %a")
	  ("a" "ASPlanner Todo" entry (file+headline "~/shared/Projects/Autostore/asplanner.org" "Tasks")
	   "* TODO %?\n  %i\n  %a")
	  ("u" "ASPlanner Journal" entry (file+datetree "~/shared/Projects/Autostore/asplanner.org")
	   "* %?\nEntered on %U\n  %i\n  %a")
	  ))

  (setq org-todo-keywords
	(quote ((sequence "TODO(t)" "|" "DONE(d!/!)")
		(sequence "WAITING(w@/!)" "SOMEDAY(s!)" "|" "CANCELLED(c@/!)"))))

  (setq org-todo-keyword-faces
	(quote (("TODO"      :foreground "red"          :weight bold)
		("NEXT"      :foreground "blue"         :weight bold)
		("DONE"      :foreground "forest green" :weight bold)
		("WAITING"   :foreground "yellow"       :weight bold)
		("SOMEDAY"   :foreground "goldenrod"    :weight bold)
		("CANCELLED" :foreground "orangered"    :weight bold))))


  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb))

(when (require 'planner nil t)
  (setq planner-project "WikiPlanner")
  (setq planner-carry-tasks-forward t)
  (setq mark-diary-entries-in-calendar nil) ;; t
  (define-key mode-specific-map [?n] 'planner-goto-today)

  (when (require 'remember-planner nil t)
    (setq remember-handler-functions '(remember-planner-append))
    (setq remember-annotation-functions planner-annotation-functions)))

(when (require 'muse nil t)
  (require 'muse-html)
  (require 'muse-latex)
  (setq muse-latex-charset-default "utf-8"
	muse-latex-encoding-default 'utf-8)
  (setq muse-html-charset-default "utf-8"
	muse-html-encoding-default 'utf-8)
  (setq muse-html-doctype "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"
          \"http://www.w3.org/TR/html4/strict.dtd\">")
  (defun muse-html-headline () (muse-publishing-directive "title"))
  (setq base-dir ".")
  (setq server "localhost")
  (setq muse-html-style-sheet
	(concat "<link rel=\"stylesheet\" type=\"text/css\" href=\""
		base-dir
		"/style/style.css\">"))
  (setq muse-html-head " <head>
    <title><lisp>(muse-publishing-directive \"title\")</lisp></title>
     <meta name=\"generator\" content=\"muse.el\" />
     <meta http-equiv=\"<lisp>muse-html-meta-http-equiv</lisp>\"
	   content=\"<lisp>muse-html-meta-content-type</lisp>\" />
    <lisp>
      (let ((maintainer (muse-style-element :maintainer)))
	(when maintainer
	  (concat \"<link rev=\\\"made\\\" href=\\\"\" maintainer \"\\\" />\")))
    </lisp>
    <lisp>muse-html-style-sheet</lisp>
  </head>")
  (setq muse-html-header "
   <lisp>muse-html-doctype</lisp>
   <html><lisp>muse-html-head</lisp>
   <body>
    <div id=\"header\">
      <h1>
        <lisp>(muse-html-headline)</lisp>
      </h1>
    </div>
    <div id=\"menubar\"><lisp>(muse-html-menu)</lisp></div>
    <div id=\"content\">
    <!-- Page -->\n
")

  (defun muse-html-menu () "
<h4><a href=\"index.html\">Home</a></h4>
<h4>Services</h4>
<ul>
<li><a href=\"Development.html\">Development</a>
<li><a href=\"FreeSoftware.html\">Free Software</a>
</ul>
<h4>Projects</h4>
<ul>
<li><a href=\"Fakturabank.html\">Fakturabank</a>
<li><a href=\"AutoStore.html\">AutoStore</a>
<li><a href=\"RamBase.html\">RamBase</a>
<li><a href=\"WebShop.html\">Web Shop</a>
<li><a href=\"Looper.html\">Looper</a>
</ul>
<h4>Datasphere</h4>
<ul>
<li><a href=\"X60_Tablet.html\">X60 Tablet</a>
<li><a href=\"T60p.html\">T60p</a>
</ul>
")

  (defun muse-last-change ()
    (if (muse-publishing-directive "lastchange")
	(concat "<div id=\"lastchange\">"
		"Page last updated at "
		(muse-publishing-directive "lastchange")
		"</div>")))

;    <include file=\"/home/kristian/shared/wiki/menu.muse\">
;        <lisp>(muse-html-menu muse-project-menu-list)</lisp>
  (setq muse-html-footer "<lisp>(muse-last-change)</lisp>
</div></body></html>")
;(if (muse-publishing-directive \"lastchange\")
;    (concat \"Page last updated at \"
;            (muse-publishing-directive \"lastchange\")))</lisp></div>

;;   (setq muse-project-menu-list
;; 	`(("Home"          ,(concat base-dir "/blog/index.html") "")
;; 	  ("Projects"      ,(concat base-dir "/projects/index.html") "")
;; 	  ("Personal Wiki" ,(concat base-dir "/wiki/index.html") "")
;; 	  ("Private"       ,(concat base-dir "/tools/private.html") "")
;; 	  ("Contact me"    ,(concat base-dir "/blog/contact") "")
;; 	  ("RSS"
;; 	   ,(concat base-dir "/tools/rss.html")
;; 	   ,(concat "<img src=\"" base-dir "/base/images/xml.png\" />&nbsp;"))))
  (defun muse-html-menu (items)
    (concat "<div class=\"menu\"><div class=\"menuhead\">Menu</div><div class=\"menubody\">"
	  (mapconcat (function (lambda (x) (concat "<div class=\"menuitem\">\n"
						   (cadr (cdr x))
						   "<a href=\"http://"
						   server
						   (cadr x)
						   "\">\n"
						   (car x)
						   "</a>"
						   "</div>")))
		     items
		     "\n"
		     )
	  "</div></div>"))

  (defun format-time-last-changed ()
    (format-time-string "%Y-%m-%d %H:%M"))

  (defun insert-last-changed ()
    (insert (format-time-last-changed)))

  (defun update-last-changed ()
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward
	     "^#lastchange\\s +[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\s [0-9]\\{2\\}:[0-9]\\{2\\}"
	     nil t)
	(delete-region (match-beginning 0) (match-end 0))
	(insert "#lastchange ")
	(insert-last-changed))))

  (defun record-last-changed ()
    (setq write-contents-hooks 'update-last-changed))

  (setq muse-mode-hook (quote (auto-fill-mode ;flyspell-mode
					      record-last-changed)))

  (setq muse-project-alist
	'(("WikiPlanner"
	   ("~/shared/Plans"
	    :default "TaskPool"
	    :major-mode planner-mode
	    :visit-link planner-visit-link)
	   (:base "planner-xhtml"
	    :path "~/shared/Plans/public_html/"))
	  ("Wiki"
	   ("~/shared/wiki" :default "index")
	   (:base "html" :path "~/shared/wiki/public/")))))


(when (require 'muse-wiki nil t)    ;;; Allow wiki-links
  (setq muse-wiki-allow-nonexistent-wikiword nil))

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
(global-set-key [f9] 'planner-create-task-from-buffer)
(global-set-key [f12] 'compile)

(global-set-key [(meta n)] 'next-error)
(global-set-key [(meta p)] 'previous-error)

(global-set-key "\C-cs" 'slime-selector)

(global-set-key [(super f)] 'slime-toggle-profile-fdefinition)
(global-set-key [(super r)] 'slime-profile-report)

(setq compilation-window-height 16)

(global-set-key [(meta s)] 'tags-search)

(global-set-key (kbd "C-c o") 'occur)

;(defun slime-pause-router ()
;  (interactive)
;  (slime-send '(com.autostore.router::interface-pause)))
;  (slime-eval-async '(com.autostore.router::interface-pause)))

(setq gnus-select-method '(nntp "news.gmane.org"))
(setq visible-bell t)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)

(put 'downcase-region 'disabled nil)

(defun toggle-fullscreen ()
  (interactive) 
  (cond
   (running-gnu-linux
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
			   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
   (t
    (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen) 
					     nil 
					   'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen) 

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

(when (require 'thingatpt nil t)

  (defun unixtime-convert ()
    (interactive)
    (let ((time (number-at-point)))
      (if time
	  (message
	   (format-time-string "%Y-%m-%d %T"
			       (seconds-to-time (number-at-point))))
	(message "<No time at point>"))))

  (global-set-key "\C-c\C-u" 'unixtime-convert))

;(setq grep-find-command
;      "find . -type f \".*\" -prune ! \( -name \"*.d\" -name \"*.o\" \) -print0 | xargs -0 -e grep -nH -e ")

(put 'scroll-left 'disabled nil)

(defun make-emacs-translucent()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha 80))

(defun make-emacs-almost-tranparent()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha 60))

(defun make-emacs-opaque()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha 100))

(defun make-emacs-transparent()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha 40))

;; wanderlust
(when (require 'wl nil t)
  (autoload 'wl "wl" "Wanderlust" t)
  (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
  (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

  ;; IMAP
  (setq elmo-imap4-default-server "dev.cavatina.no")
  (setq elmo-imap4-default-user "kristian") 
  (setq elmo-imap4-default-authenticate-type 'clear) 
  (setq elmo-imap4-default-port '143)
  (setq elmo-imap4-default-stream-type 'starttls)

  (setq elmo-imap4-use-modified-utf7 t)

  ;; SMTP
  (setq wl-smtp-connection-type 'starttls)
  (setq wl-smtp-posting-port 587)
  (setq wl-smtp-authenticate-type "plain")
  (setq wl-smtp-posting-user "kristian@cavatina.no")
  (setq wl-smtp-posting-server "mail.cavatina.no")
  (setq wl-local-domain "cavatina.no")

  (setq wl-default-folder "%inbox")
  (setq wl-default-spec "%")
;  (setq wl-draft-folder "%[dev.cavatina.no]/Drafts")
;  (setq wl-trash-folder "%[dev.cavatina.no]/Trash")

  (setq wl-folder-check-async t) 

  (setq elmo-imap4-use-modified-utf7 t)

  (autoload 'wl-user-agent-compose "wl-draft" nil t)
  (if (boundp 'mail-user-agent)
      (setq mail-user-agent 'wl-user-agent))
  (if (fboundp 'define-mail-user-agent)
      (define-mail-user-agent
	'wl-user-agent
	'wl-user-agent-compose
	'wl-draft-send
	'wl-draft-kill
	'mail-send-hook)))

;; Configure outbound mail (SMTP)
(setq smtpmail-starttls-credentials '(("mail.cavatina.no" 587 nil nil))
      smtpmail-smtp-server "mail.cavatina.no"
      smtpmail-default-smtp-server "mail.cavatina.no"
      send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-service 587
      smtpmail-auth-credentials '(("mail.cavatina.no"
				   587
				   "kristian@cavatina.no"
				   nil)))

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



(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))