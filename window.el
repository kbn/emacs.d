;;; Frame management
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

;;; Window management
(defun select-next-window ()
  "Switch to the next window" 
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window" 
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "<XF86Forward>") 'select-next-window)
(global-set-key (kbd "<XF86Back>")  'select-previous-window)

(global-set-key (kbd "<XF86Forward>") 'select-next-window)
(global-set-key (kbd "<XF86Back>")  'select-previous-window)

(global-set-key (kbd "M-<left>") 'windmove-left)          ; move to left windnow
(global-set-key (kbd "M-<right>") 'windmove-right)        ; move to right window
(global-set-key (kbd "M-<up>") 'windmove-up)              ; move to upper window
(global-set-key (kbd "M-<down>") 'windmove-down)          ; move to downer window
