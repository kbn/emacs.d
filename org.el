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
