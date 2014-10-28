;; Base settings
(add-to-list 'load-path "~/.emacs.d")
(load-file "~/.emacs.d/base.el")
(setq debug-on-error t)

;; Tabbar settings
(load-file "~/.emacs.d/tabbar-custom.el")

;; CEDET settings
(load-file "~/.emacs.d/cedet-custom.el")



;jdee init
(load-file "~/.emacs.d/jdee-custom.el")

;ecb init
;(load-file "~/.emacs.d/ecb-custom.el")

;yasnippet setting
;(load-file "~/.emacs.d/yasnippet-custom.el")




(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(jde-jdk (quote ("1.6")))
 '(jde-jdk-registry (quote (("1.6" . "/usr/lib/jvm/jdk1.7.0_15"))))
 '(tabbar-separator (quote (0.5))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
