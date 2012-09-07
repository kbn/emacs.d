(defvar running-ms-windows
  (string-match "windows" (prin1-to-string system-type)))

(defvar running-gnu-linux
  (string-match "linux" (prin1-to-string system-type)))

(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

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

(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun dos2unix ()
  "Convert a DOS formatted text buffer to UNIX format"
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix nil))

(defun unix2dos ()
  "Convert a UNIX formatted text buffer to DOS format"
  (interactive)
  (set-buffer-file-coding-system 'undecided-dos nil))
