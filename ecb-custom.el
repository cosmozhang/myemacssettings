
;; https://github.com/alexott/ecb
(add-to-list 'load-path "~/.emacs.d/ecb-snap")
(require 'ecb)
;(require 'ecb-autoloads)
;; 自动启动ecb，关闭每日提示
(setq ecb-auto-activate t
	ecb-tip-of-the-day nil)
;(setq ecb-auto-activate t)

;;鼠标起作用
(custom-set-variables '(ecb-primary-secondary-mouse-buttons
	(quote mouse-1--mouse-2)))
;;http://truongtx.me/2013/03/10/ecb-emacs-code-browser/
;; 设置四个窗口的布局，默认是都放在左边，可以自己更改
(setq ecb-layout-name "left6")
;; 在目录窗口显示文件
(setq ecb-show-sources-in-directories-buffer 'always)
;; 设置compile窗口的高度
(setq ecb-compile-window-height 8)
;; 设置窗口的宽度，15%
(setq ecb-windows-width 0.15)

(require 'sr-speedbar)
;; speedbar的类型
;;(setq speedbar-show-unknown-files t)  
;; 不使用图标
(setq speedbar-use-images nil)  
;; speedbar的宽度
;;(setq sr-speedbar-width 20)  
;; 放到右边去
(setq sr-speedbar-right-side t)  
(global-set-key (kbd "<f5>") (lambda()  
                               (interactive)  
                               (sr-speedbar-toggle))) 