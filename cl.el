(cond
 (running-ms-windows
  (add-to-list 'load-path "c:/clisp/slime/")

  (setq common-lisp-hyperspec-root "file:/c:/lisp/HyperSpec/")

  (setq inferior-lisp-program "clisp -K full"))

 (t
  (setq common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/")

  (setq inferior-lisp-program "sbcl")))

(load (expand-file-name "~/prog/quicklisp/slime-helper.el") t)

(when (require 'slime nil t)
  (slime-setup '(slime-repl)))

(global-set-key "\C-cs" 'slime-selector)
