;; Tabbar settings
;;(require 'tabbar)
;;(tabbar-mode 1)
(load-file "~/.emacs.d/tabbar-tweak.el")
;; C-<  --> 前一个标签
(global-set-key [(control <)] 'tabbar-backward)
;; C->  --> 后一个标签
(global-set-key [(control >)] 'tabbar-forward)
;; C-M-<  --> 前一个组
;(global-set-key [(control meta <)] 'tabbar-backward-group)
;; C-M->  --> 后一个组
;(global-set-key [(control meta >)] 'tabbar-forward-group)
;; 把Process和Common组去掉
(setq tabbar-buffer-list-function
    (lambda () 
		(remove-if 
			(lambda (buffer)
				(find (aref (buffer-name buffer) 0) " *"))
		(buffer-list))))
;; 所有的标签都只放到一个组AllTabs
(setq tabbar-buffer-groups-function (lambda()(list "AllTabs")))