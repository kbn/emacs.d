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

(ignore-errors
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;;;;; Theme ;;;;;
  ;; Cycle through this set of themes
  (setq my-themes '(nil deeper-blue wheatgrass))

  (setq my-cur-theme nil)
  (defun cycle-my-theme ()
    "Cycle through a list of themes, my-themes"
    (interactive)
    (when my-cur-theme
      (disable-theme my-cur-theme))
    (setq my-themes (append my-themes (list my-cur-theme)))
    (setq my-cur-theme (pop my-themes))
    (when my-cur-theme
      (load-theme my-cur-theme t)))

  ;; Switch to the first theme in the list above
  (cycle-my-theme)

  ;; Bind this to C-t
  (global-set-key "\C-t" 'cycle-my-theme))


;;;---------------------------------------------------------------------
;;; display-buffer

;; The default behaviour of `display-buffer' is to always create a new
;; window. As I normally use a large display sporting a number of
;; side-by-side windows, this is a bit obnoxious.
;;
;; The code below will make Emacs reuse existing windows, with the
;; exception that if have a single window open in a large display, it
;; will be split horisontally.

(setq pop-up-windows nil)

(defun my-display-buffer-function (buf not-this-window)
  (if (and (not pop-up-frames)
           (one-window-p)
           (or not-this-window
               (not (eq (window-buffer (selected-window)) buf)))
           (> (frame-width) 124))
      (split-window-horizontally))
  ;; Note: Some modules sets `pop-up-windows' to t before calling
  ;; `display-buffer' -- Why, oh, why!
  (let ((display-buffer-function nil)
        (pop-up-windows nil))
    (display-buffer buf not-this-window)))

(setq display-buffer-function 'my-display-buffer-function)
