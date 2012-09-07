;; wanderlust
(when (require 'wl nil t)
  (autoload 'wl "wl" "Wanderlust" t)
  (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
  (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

  ;; IMAP
  (setq elmo-imap4-default-server "dev.cavatina.no")
  (setq elmo-imap4-default-user "kristian") 
  (setq elmo-imap4-default-authenticate-type 'clear) 
  (setq elmo-imap4-default-port '143)
  (setq elmo-imap4-default-stream-type 'starttls)

  (setq elmo-imap4-use-modified-utf7 t)

  ;; SMTP
  (setq wl-smtp-connection-type 'starttls)
  (setq wl-smtp-posting-port 587)
  (setq wl-smtp-authenticate-type "plain")
  (setq wl-smtp-posting-user "kristian@cavatina.no")
  (setq wl-smtp-posting-server "mail.cavatina.no")
  (setq wl-local-domain "cavatina.no")

  (setq wl-default-folder "%inbox")
  (setq wl-default-spec "%")
;  (setq wl-draft-folder "%[dev.cavatina.no]/Drafts")
;  (setq wl-trash-folder "%[dev.cavatina.no]/Trash")

  (setq wl-folder-check-async t) 

  (setq elmo-imap4-use-modified-utf7 t)

  (autoload 'wl-user-agent-compose "wl-draft" nil t)
  (if (boundp 'mail-user-agent)
      (setq mail-user-agent 'wl-user-agent))
  (if (fboundp 'define-mail-user-agent)
      (define-mail-user-agent
	'wl-user-agent
	'wl-user-agent-compose
	'wl-draft-send
	'wl-draft-kill
	'mail-send-hook)))

;; Configure outbound mail (SMTP)
(setq smtpmail-starttls-credentials '(("mail.cavatina.no" 587 nil nil))
      smtpmail-smtp-server "mail.cavatina.no"
      smtpmail-default-smtp-server "mail.cavatina.no"
      send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-service 587
      smtpmail-auth-credentials '(("mail.cavatina.no"
				   587
				   "kristian@cavatina.no"
				   nil)))
