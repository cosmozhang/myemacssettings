(let ((minver "24"))
  (when (version<= emacs-version minver)
    (message "Your Emacs is a little bit old, some functionalities might not work, please use the latest version")
  )
 )

(require 'cl)
;; Proxy server setting
;; (setq url-proxy-services '(("no_proxy" . "default_gateway")
;;                            ("http" . "HTTP_PROXY_SERVER:PORT")
;;                            ("https" . "HTTPS_PROXY_SERVER:PORT")))


; plist-to-alist
; to use color-theme
(defun plist-to-alist (the-plist)
  (defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))

  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
  alist))

(defun load-files-wildcards (wildcards)
  "Load all the files specified by wildcards"
  (let ((all-files (file-expand-wildcards wildcards t)))
    (while all-files
      (load (car all-files))
      (setq all-files (cdr all-files))
    )
  )
)

(let ((load-dir (file-name-directory load-file-name)))
  (load-files-wildcards (format "%s/*-init.el" load-dir))
  (load-files-wildcards (format "%s/**/dir-init.el" load-dir))
)

;;; package setup
;;; refer to http://emacswiki.org/emacs/ELPA

(require 'package)
;;; setup the archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t); Org-mode's repository

;;; org-trello's repository
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages") t)

(package-initialize)

(defvar my-packages-to-install
  '(ggtags company yasnippet ack org-trello helm org-octopress
	   undo-tree
	   cygwin-mount
	   magit
	   )
  "The packages Emacs will try to install when it starts up.")

(defun my-packages-installed-p ()
  (loop for p in my-packages-to-install
        when (not (package-installed-p p)) do (return nil)
        finally (return t))
)

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)

  (message "Emacs is checking whether the packages are installed...")
  (dolist (p my-packages-to-install)
    (when (not (package-installed-p p))
      (package-install p))
  )
  (message "Checking done"))


(let ((load-dir (file-name-directory load-file-name)))
  (load-files-wildcards (format "%s/**/*-init.el" load-dir))
)

(defun my-c-mode-common-hook()
  (whitespace-mode t)
  (linum-mode t)
  (c-set-style "python"))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; show the bookmarks in the welcome page
;; TODO: collect the directories the user
;; accesses frequently and show them
(setq inhibit-splash-screen t)
(require 'bookmark)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")


;; color theme setting
(require 'color-theme)
(load-file "~/.emacs.d/.emacs-color-theme")
(my-color-theme)

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
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
)
;full screen
(global-set-key [f11] 'toggle-fullscreen)


;autopair
(autoload 'autopair-global-mode "autopair" nil t)
(autopair-global-mode)
(add-hook 'lisp-mode-hook #'(lambda () (setq autopair-dont-activate t)))

;comment
(defun comment-dwim-line (&optional arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
;block comment "alt+;"
(global-set-key "\M-;" 'comment-dwim-line)


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

;设置光标为竖线
(setq-default cursor-type 'bar)

;external粘贴板
(setq x-select-enable-clipboard t)

;关闭烦人的出错时的提示声
(setq visible-bell t)

;隐藏工具栏
(tool-bar-mode -1)

;隐藏滚动条
(scroll-bar-mode -1)

;yes or no to y/n
(fset 'yes-or-no-p 'y-or-n-p)

; always show line numbers
(global-linum-mode 1)

;set format
(setq linum-format "%d| ")

;防止页面滚动时跳动， scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文
(setq scroll-margin 3
      scroll-conservatively 10000)

;可以递归的使用 minibuffer。我经常需要这么做。
(setq enable-recursive-minibuffers t)

;size of initial window
(setq initial-frame-alist '( (width . 120) (height . 40)))

;用一个很大的 kill ring. 这样防止我不小心删掉重要的东西
(setq kill-ring-max 200)

;Start a new line at the column 60.
(setq default-fill-column 60)

;光标在行尾时，上下行跳动保持在行尾
(setq track-eol t)

; Tab缩进设置
; 四个字符
(setq default-tab-width 4)
; 开启Tab缩进
(setq indent-tabs-mode t)

;show corresponding parenthesis
(show-paren-mode t)
;括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号
(setq show-paren-style 'parentheses)

;让 Emacs 可以直接打开和显示图片
(auto-image-file-mode)

;进行语法加亮
(global-font-lock-mode t)

;标题格式, "文件名  @  全路径文件名"
(setq frame-title-format '("%b @ " buffer-file-name))

;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线
(mouse-avoidance-mode 'animate)

;设置有用的个人信息。这在很多地方有用
(setq user-full-name "Xiao (Cosmo) Zhang")
(setq user-mail-address "cosmozhang1988@gmail.com")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
