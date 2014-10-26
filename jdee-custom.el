(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
;(load "jde")
;; 不自动加载jde-mode
(setq jde-help-remote-file-exists-function '("beanshell"))
(setq defer-loading-jde t)
;; to read:
;;
;;  (setq defer-loading-jde t)
;;
;; 编辑.java文件时加载jde
(if defer-loading-jde
	(progn
	  (autoload 'jde-mode "jde" "JDE mode." t)
	  (setq auto-mode-alist
			(append
			 '(("\\.java\\'" . jde-mode))
			 ;'(jde-jdk (quote ("1.6")))
			 ;'(jde-jdk-registry (quote (("1.6" . "/usr/lib/jvm/java-7-oracle"))))
			 auto-mode-alist)))
  (require 'jde))
