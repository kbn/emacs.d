(when (require 'org-install nil t)
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (setq org-directory "~/org")
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-capture-templates
	`(("t" "Todo" entry (file+headline ,(concat org-directory "/gtd.org") "Tasks")
	   "* TODO %?\n  %i\n  %a")
	  ("d" "Todo (context-free)" entry (file+headline ,(concat org-directory "/gtd.org") "Tasks")
	   "* TODO %?")
	  ("j" "Journal" entry (file+datetree ,(concat org-directory "/journal.org"))
	   "* %?\nEntered on %U\n  %i\n  %a")
	  ("k" "Diary" entry (file+datetree ,"/media/truecrypt1/diary.org")
	   "* %?\nEntered on %U\n  %i")
	  ("a" "ASPlanner Todo" entry (file+headline "~/Projects/Autostore/asplanner.org" "Tasks")
	   "* TODO %?\n  %i\n  %a")
	  ("u" "ASPlanner Journal" entry (file+datetree "~/Projects/Autostore/asplanner.org")
	   "* %?\nEntered on %U\n  %i\n  %a")
	  ))

  (setq org-todo-keywords
	(quote ((sequence "TODO(t)" "|" "DONE(d!/!)")
		(sequence "WAITING(w@/!)" "SOMEDAY(s!)" "|" "CANCELLED(c@/!)")
		(sequence "ISSUE(i)" "|" "POSTPONED(p)" "|" "DISCUSS(u)" "|" "RESOLVED(r)"))))

  (setq org-todo-keyword-faces
	(quote (("TODO"      :foreground "red"          :weight bold)
		("NEXT"      :foreground "blue"         :weight bold)
		("DONE"      :foreground "forest green" :weight bold)
		("WAITING"   :foreground "yellow"       :weight bold)
		("SOMEDAY"   :foreground "goldenrod"    :weight bold)
		("CANCELLED" :foreground "orangered"    :weight bold)
		("ISSUE"     :foreground "red"          :weight bold)
		("POSTPONED" :foreground "goldenrod"    :weight bold)
		("DISCUSS"   :foreground "yellow"       :weight bold)
		("RESOLVED"  :foreground "forest green" :weight bold))))

  ;; active Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)
     (emacs-lisp . t)
     (perl . t)
     (python . t)
     (ruby . t)
     (lisp . t)
     ))

  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb))

(when (require 'ox-publish nil t)
  (setq org-publish-project-alist
	'(
	  ("org-notes"
	   :base-directory "~/org/public/"
	   :base-extension "org"
	   :publishing-directory "~/public_html/";"/ssh:kristian@home.cavatina.no:/var/www/home.cavatina.no/htdocs/"
	   :recursive t
	   :section-numbers nil
	   :publishing-function org-html-publish-to-html
	   :headline-levels 4             ; Just the default for this project.
;	   :auto-preamble t
	   :style "<link rel=\"stylesheet\" href=\"style/style.css\" type=\"text/css\"/>"
	   :auto-sitemap t
	   :sitemap-title ""
	   :makeindex t
	   )
	  ("org-static"
	   :base-directory "~/org/public/"
	   :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	   :publishing-directory "~/public_html/";"/ssh:kristian@home.cavatina.no:/var/www/home.cavatina.no/htdocs/"
	   :recursive t
	   :publishing-function org-publish-attachment
	   )
	  ("org" :components ("org-notes" "org-static"))
	  )))

(when (require 'org-re-reveal nil t)
  (setq org-re-reveal-root "file:///C:/Users/2795/src/reveal.js"))

(setq org-src-preserve-indentation t)
(setq org-edit-src-content-indentation 0)
