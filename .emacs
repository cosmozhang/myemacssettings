;; Base settings
(add-to-list 'load-path "~/.emacs.d")
(load-file "~/.emacs.d/base.el")

;; Tabbar settings
;;(require 'tabbar)
;;(tabbar-mode 1)
(load-file "~/.emacs.d/tabbar-tweak.el")
;; C-<  --> 前一个标签
(global-set-key [(control <)] 'tabbar-backward)
;; C->  --> 后一个标签
(global-set-key [(control >)] 'tabbar-forward)
;; C-M-<  --> 前一个组
(global-set-key [(control meta <)] 'tabbar-backward-group)
;; C-M->  --> 后一个组
(global-set-key [(control meta >)] 'tabbar-forward-group)


;; CEDET settings
(load-file "~/.emacs.d/cedet-custom.el")

;Autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)


;jdee init
;(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
;(load "jde")

;ecb init
(load-file "~/.emacs.d/ecb-custom.el")

;yasnippet setting
;(load-file "~/.emacs.d/yasnippet-custom.el")

;; GDB settings
(setq gdb-many-windows t)

(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(tabbar-separator (quote (0.5))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
