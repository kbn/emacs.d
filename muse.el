(when (require 'planner nil t)
  (setq planner-project "WikiPlanner")
  (setq planner-carry-tasks-forward t)
  (setq mark-diary-entries-in-calendar nil) ;; t
  (define-key mode-specific-map [?n] 'planner-goto-today)

  (when (require 'remember-planner nil t)
    (setq remember-handler-functions '(remember-planner-append))
    (setq remember-annotation-functions planner-annotation-functions)))

(global-set-key [f9] 'planner-create-task-from-buffer)

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
