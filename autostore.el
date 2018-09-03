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

(setenv "AS_LIBRARY_PATH" "$HOME/src/jhc/lib")

;(defun slime-pause-router ()
;  (interactive)
;  (slime-send '(com.autostore.router::interface-pause)))
;  (slime-eval-async '(com.autostore.router::interface-pause)))
