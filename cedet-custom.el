;; 基于http://emacser.com/cedet.htm和http://emacser.com/built-in-cedet.htm修改得到
;; 英文参考这个http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html

;; 启用CEDET，设置semantic
(setq semantic-default-submodes '(global-semanticdb-minor-mode  ;; 保存分析内容
								  global-semantic-idle-scheduler-mode  ;; Emacs空闲时自动分析buffer内容
								  global-semantic-idle-summary-mode  ;; minibuffer显示函数原型
								  ;;global-semantic-idle-completions-mode  ;; 自动提示可以补全的内容
								  ;;global-semantic-decoration-mode  ;; 类/函数上方加一条线
								  global-semantic-highlight-func-mode  ;; 高亮显示光标所在函数
								  ;;global-semantic-stickyfunc-mode  ;; 当前函数名显示在buffer上
								  global-semantic-mru-bookmark-mode  ;; 书签记录
								  global-semantic-idle-local-symbol-highlight-mode))  ;; 高亮光标处的同名变量
(semantic-mode 1)  ;; 启用semantic
;; 最近修改过的内容高亮
(global-semantic-highlight-edits-mode (if window-system 1 -1))
;; 标识无法解析的内容
(global-semantic-show-unmatched-syntax-mode 1)
;; Mode Line上显示当前解析状态
(global-semantic-show-parser-state-mode 1)

;; 导入高级的名字补全，信息显示等
(require 'semantic/ia)
;; 代码跳转，跳到变量函数的定义
(global-set-key [f12] 'semantic-ia-fast-jump)
;; 跳回
(defadvice push-mark (around semantic-mru-bookmark activate)
	(semantic-mrub-push semantic-mru-bookmark-ring (point) 'mark)
	ad-do-it)
(defun semantic-ia-fast-jump-back ()
	(interactive)
	(if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
		(error "Semantic Bookmark ring is currently empty"))
	(let* ((ring (oref semantic-mru-bookmark-ring ring))
        (alist (semantic-mrub-ring-to-assoc-list ring))
        (first (cdr (car alist))))
    (if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
        (setq first (cdr (car (cdr alist)))))
    (semantic-mrub-switch-tags first)))
(global-set-key [S-f12] 'semantic-ia-fast-jump-back)  ;; 跳回
;; 自动补全
(defun auto-compelet-cedet-hook ()
	(local-set-key [(control return)] 'semantic-ia-complete-symbol)  ;; C RET，不会多一个窗口
	(local-set-key "\C-c>" 'semantic-complete-analyze-inline)  ;; C-c>，会多一个窗口
	(local-set-key [M-S-f12] 'semantic-analyze-proto-impl-toggle))  ;; 原型
(add-hook 'c-mode-common-hook 'auto-compelet-cedet-hook)
;; 点号和>后补全提示，会在新的窗口里显示可用的补全
;;(defun auto-c-mode-cedet-hook ()
;;	(local-set-key "." 'semantic-complete-self-insert)
;;	(local-set-key ">" 'semantic-complete-self-insert))
;;(add-hook 'c-mode-common-hook 'auto-c-mode-cedet-hook)

;; imenu的设置, 生成Tags菜单，菜单里列出了函数，变量等
(defun tags-menu-semantic-hook ()
	(imenu-add-to-menubar "Tags"))
(add-hook 'semantic-init-hooks 'tags-menu-semantic-hook)

;; 可视化书签https://github.com/joodland/bm
(require 'bm)
(global-set-key (kbd "<f2>") 'bm-toggle)  ;; F2当前行设置或取消书签
(global-set-key (kbd "<C-f2>") 'bm-next)  ;; C-F2查找下一书签
(global-set-key (kbd "<S-f2>") 'bm-previous)  ;; S-F2查找上一书签
;; C-S-F2清空当前文件所有书签, 所有buffer就用bm-remove-all-all-buffers
(global-set-key (kbd "<C-S-f2>") 'bm-remove-all-current-buffer)  
;; 鼠标左键点右边缘设置或取消当前行书签，左缘用left-margin
(global-set-key (kbd "<right-fringe> <mouse-1>") 'bm-toggle-mouse)  
;; 鼠标中键点右边缘查找下一书签
(global-set-key (kbd "<right-fringe> <mouse-2>") 'bm-next-mouse)
;; 鼠标右键点右边缘查找上一书签
(global-set-key (kbd "<right-fringe> <mouse-3>") 'bm-previous-mouse)
;; 鼠标右键点双击右边缘查找上一书签清空当前文件所有书签
(global-set-key (kbd "<right-fringe> <double-mouse-3>") 'bm-remove-all-current-buffer) 
(setq bm-in-lifo-order t)  ;; 按后进先出顺序循环书签
(setq bm-cycle-all-buffers t)  ;; 在所有打开的buffer中循环书签
(setq bm-marker 'bm-marker-right)  ;; 书签显示在右边
(setq bm-highlight-style 'bm-highlight-only-fringe)  ;; 书签只显示在边缘，结合上一句就是右边缘

;speedbar
(global-set-key [f4] 'speedbar-get-focus)

;; 代码折叠
;; 用semantic实现
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode -1) ;; 开启代码折叠模式(manual)
(global-set-key (kbd "C-?") 'global-semantic-tag-folding-mode)  ;; 绑定C-?开启关闭代码折叠模式
;; 折叠代码块，绑定到C--
(define-key semantic-tag-folding-mode-map (kbd "C--") 'semantic-tag-folding-fold-block)
;; 展开代码块，绑定到C-+
(define-key semantic-tag-folding-mode-map (kbd "C-+") 'semantic-tag-folding-show-block)
;; 折叠所有代码，绑定到C-_
;(define-key semantic-tag-folding-mode-map (kbd "C-c , _") 'semantic-tag-folding-fold-all)
;; 展开代码块，绑定到C-+
;(define-key semantic-tag-folding-mode-map (kbd "C-+") 'semantic-tag-folding-show-all))
;; 用senator实现
;(define-key global-map (kbd "C--") 'senator-fold-tag)  ;; 折叠代码块，绑定到C-c , -与上面一致
;(define-key global-map (kbd "C-+") 'senator-unfold-tag)  ;; 展开代码块，绑定到C-c , +与上面一致