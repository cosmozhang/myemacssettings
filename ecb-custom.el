
;; https://github.com/alexott/ecb
(add-to-list 'load-path "~/.emacs.d/ecb-snap")
(require 'ecb)
(require 'ecb-autoloads)
;; 自动启动ecb，关闭每日提示
(setq ecb-auto-activate t
	ecb-tip-of-the-day nil)
;;(setq ecb-auto-activate t)

;;鼠标起作用
(custom-set-variables '(ecb-primary-secondary-mouse-buttons
	(quote mouse-1--mouse-2)))
;;http://truongtx.me/2013/03/10/ecb-emacs-code-browser/
;; 设置四个窗口的布局，默认是都放在左边，可以自己更改
(setq ecb-layout-name "left6")
;; 在目录窗口显示文件
(setq ecb-show-sources-in-directories-buffer 'always)
;; 设置compile窗口的高度
(setq ecb-compile-window-height 10)
;; 设置窗口的宽度，15%
(setq ecb-windows-width 15)


;;;; 各窗口间切换
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)
 
;;;; 隐藏和显示ecb窗口
(define-key global-map [(control f1)] 'ecb-hide-ecb-windows)
(define-key global-map [(control f2)] 'ecb-show-ecb-windows)
 
;;;; 使某一ecb窗口最大化
;(define-key global-map "/C-c1" 'ecb-maximize-window-directories)
;(define-key global-map "/C-c2" 'ecb-maximize-window-sources)
;(define-key global-map "/C-c3" 'ecb-maximize-window-methods)
;(define-key global-map "/C-c4" 'ecb-maximize-window-history)
;;;; 恢复原始窗口布局
(define-key global-map [(control f3)] 'ecb-restore-default-window-sizes)

;(require 'sr-speedbar)
;; speedbar的类型
;;(setq speedbar-show-unknown-files t)  
;; 不使用图标
;(setq speedbar-use-images nil)  
;; speedbar的宽度
;;(setq sr-speedbar-width 20)  
;; 放到右边去
;(setq sr-speedbar-right-side t)  
;(global-set-key (kbd "<f5>") (lambda()  
;                               (interactive)  
;                               (sr-speedbar-toggle))) 