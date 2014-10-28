;color
(require'color-theme)
(load-file"~/.emacs.d/.emacs-color-theme")
(my-color-theme)

;; 如果需要关闭菜单栏，可以去掉下一行的两个分号
;;(menu-bar-mode -1)

;; 如果需要关闭工具栏，可以去掉下一行的两个分号
(tool-bar-mode -1)

;recent closed, changed
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;按f11让Emacs进入全屏显示
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

;full screen
(global-set-key [f11] 'toggle-fullscreen)


;;显示时间
(display-time)
;;时间为24小时制
(setq display-time-24hr-format t)
;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)
;;时间栏旁边启动邮件设置
;(setq display-time-use-mail-icon t)
;;时间的变化频率
(setq display-time-interval 10)


(tool-bar-mode -1);隐藏工具栏
(scroll-bar-mode -1);隐藏滚动条

(setq-default cursor-type 'bar);设置光标为竖线
;(setq-default cursor-type 'box);设置光标为方块

(setq x-select-enable-clipboard t);external粘贴板。

(setq visible-bell t);关闭烦人的出错时的提示声。

;; 关闭备份文件，临时文件
(setq make-backup-files nil)
(setq-default make-backup-files nil)

(fset 'yes-or-no-p 'y-or-n-p);yes or no to y/n

(setq inhibit-startup-message t);关闭起动时的那个“开机画面”。

;(setq initial-scratch-message ""); *scratch* buffer的提示信息 set as None

(global-linum-mode 1) ; always show line numbers
(setq linum-format "%d| ")  ;set format
;(setq column-number-mode t) ;显示列号。

(setq initial-frame-alist '( (width . 120) (height . 40)));尺寸

;(setq mouse-yank-at-point t);不要在鼠标点击的那个地方插入剪贴板内容。我不喜欢那样，经常把 我的文档搞的一团糟。我觉得先用光标定位，然后鼠标中键点击要好 的多。不管你的光标在文档的那个位置，或是在 minibuffer，鼠标 中键一点击，X selection 的内容就被插入到那个位置。

(setq kill-ring-max 200);用一个很大的 kill ring. 这样防止我不小心删掉重要的东西。

(setq default-fill-column 60);把 fill-column 设为 60. 这样的文字更好读。Start a new line at the column XX.

;; 光标在行尾时，上下行跳动保持在行尾
(setq track-eol t)

;; Tab缩进设置
(setq default-tab-width 4)  ;; 四个字符
(setq indent-tabs-mode t)  ;; 开启Tab缩进
;(setq-default indent-tabs-mode nil)
;(setq default-tab-width 4)
;(setq tab-stop-list ())
;(loop for x downfrom 40 to 1 do
;(setq tab-stop-list (cons (* x 4) tab-stop-list)));不用 TAB 字符来indent, 这会引起很多奇怪的错误。编辑 Makefile 的时候也不用担心，因为 makefile-mode 会把 TAB 键设置成真正的 TAB 字符，并且加亮显示的。

(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil);设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插 入两个空格。

(setq enable-recursive-minibuffers t);可以递归的使用 minibuffer。我经常需要这么做。

(setq scroll-margin 3
      scroll-conservatively 10000);防止页面滚动时跳动， scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文。

(setq default-major-mode 'text-mode);把缺省的 major mode 设置为 text-mode, 而不是几乎什么功能也 没有的 fundamental-mode.

(show-paren-mode t);show corresponding parenthesis
(setq show-paren-style 'parentheses);括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号。

(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。

;(setq frame-title-format "emacs@%b");在标题栏显示buffer的名字，而不是 emacs@wangyin.com 这样没用 的提示。
(setq frame-title-format '("%b @ " buffer-file-name));标题格式, "文件名  @  全路径文件名"

(auto-image-file-mode);让 Emacs 可以直接打开和显示图片。

(global-font-lock-mode t);进行语法加亮。

(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil);把这些缺省禁用的功能打开。

(setq version-control t)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 2)
(setq dired-kept-versions 1);设置一下备份时的版本控制，这样更加安全。

(mapcar
 (function (lambda (setting)
	     (setq auto-mode-alist
		   (cons setting auto-mode-alist))))
 '(("\\.xml$".  sgml-mode)
   ("\\\.bash" . sh-mode)
   ("\\.rdf$".  sgml-mode)
   ("\\.session" . emacs-lisp-mode)
   ("\\.l$" . c-mode)
   ("\\.css$" . css-mode)
   ("\\.cfm$" . html-mode)
   ("gnus" . emacs-lisp-mode)
   ("\\.idl$" . idl-mode)));一个简单的办法设置 auto-mode-alist, 免得写很多 add-to-list.

(setq user-full-name "Xiao (Cosmo) Zhang")
(setq user-mail-address "cosmozhang1988@gmail.com");设置有用的个人信息。这在很多地方有用。

;;comment
(defun comment-dwim-line (&optional arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)

;; GDB settings
(setq gdb-many-windows t)

(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

;; delete trailing space
;(add-hook 'before-save-hook 'delete-trailing-whitespace)

;aotupair
(autoload 'autopair-global-mode "autopair" nil t)
(autopair-global-mode)
(add-hook 'lisp-mode-hook #'(lambda () (setq autopair-dont-activate t)))

;Autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)


