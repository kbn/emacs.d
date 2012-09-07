(when running-ms-windows
  (add-to-list 'load-path "c:/clisp/slime/"))

(if running-ms-windows
    (setq common-lisp-hyperspec-root "file:/c:/lisp/HyperSpec/")
    (setq common-lisp-hyperspec-root "file:/usr/share/doc/hyperspec/"))

(setq inferior-lisp-program "clisp -K full")
(when (require 'slime nil t)
  (slime-setup '(slime-repl)))

(global-set-key "\C-cs" 'slime-selector)

