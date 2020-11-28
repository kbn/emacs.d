(defvar running-ms-windows
  (string-match "windows" (prin1-to-string system-type)))

(defvar running-gnu-linux
  (string-match "linux" (prin1-to-string system-type)))

(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; Use find/grep from MSYS git, if available
(when running-ms-windows
  (message "Running Windows")
  (let ((git-bin "c:\\Program Files\\Git\\usr\\bin"))
    (when (file-readable-p git-bin)
      (message "With Git")
      (setenv "PATH"
	      (concat
	       git-bin ";"
	       (getenv "PATH")))

;      (setf null-device "/dev/null"))))

      ;; Prevent issues with the Windows null device (NUL)
      ;; when using MSYS find with rgrep.
      (defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
	"Use MSYS's /dev/null as the null-device."
	(let ((null-device "/dev/null"))
	  ad-do-it))
      (ad-activate 'grep-compute-defaults))))


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

(when running-ms-windows
  (require 'compile)
  ;; (add-hook 'c-mode-common-hook (lambda ()
  ;;   (add-to-list
  ;;    'compilation-error-regexp-alist-alist
  ;;    '(msvc "^[ \t]*\\([A-Za-z0-9\\.][^(]*\\.\\(cpp\\|c\\|h\\)\\)(\\([0-9]+\\,[0-9]+\\)) *: +\\(error\\|fatal error\\|warning\\) C[0-9]+:" 1 3)))))

  (mapcar

   (lambda (x)
     (add-to-list 'compilation-error-regexp-alist-alist x))

   (list
     ;; Microsoft C/C++:
     ;;  keyboard.c(537) : warning C4005: 'min' : macro redefinition
     ;;  d:\tmp\test.c(23) : error C2143: syntax error : missing ';' before 'if'
     ;;  .\cppcli1.cpp(36): error C2059: syntax error : 'public'
     ;;  e:\projects\myce40\tok.h(85) : error C2236: unexpected 'class' '$S1'
     ;;  myc.cpp(14) : error C3149: 'class System::String' : illegal use of managed type 'String'; did you forget a '*'?
     ;;   ("\\(\\([a-zA-Z]:\\)?[^:(\t\n]+\\)(\\([0-9]+\\)) ?\: \\(error\\|warning\\) C[0-9]+:" 1 3)
    '(msvc "^[ \t]*\\([A-Za-z0-9\\.][^(]*\\.\\(cpp\\|c\\|h\\)\\)(\\([0-9]+\\,[0-9]+\\)) *: +\\(error\\|fatal error\\|warning\\) C[0-9]+:" 1 3)

    ))

    (setq compilation-error-regexp-alist
          (mapcar 'car compilation-error-regexp-alist-alist)) )

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
