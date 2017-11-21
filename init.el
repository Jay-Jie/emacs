;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
 (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

 (require 'cl)

 (defvar my/packages '(
		company ;; 补全
		swiper ;; 搜索
		counsel  ;; swiper依赖包
		smartparens ;; 增强匹配
		zenburn-theme ;; 主题
		smartparens ;; 自动补全符号
		js2-mode ;; mojor-mode
		nodejs-repl ;; 运行js文件
		exec-path-from-shell ;; emacs运行命令行程序
		) "Default packages")

 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

;; 让emacs在mac平台能够找到命令行程序
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

;; 加载主题
(load-theme 'zenburn t)
;; 禁止菜单栏
(tool-bar-mode -1)
;; 禁止显示滚动条
(scroll-bar-mode -1)
;; 禁止启动指南
(setq inhibit-splash-screen t)
;; 显示行号
(global-linum-mode t)
;; 自动补全
(global-company-mode t)
;; 设置光标样式
(setq-default cursor-type 'bar)
;; 禁止备份文件
(setq make-backup-files nil)
;; 支持org文件SRC语句块中语法高亮
(require 'org)
(setq org-src-fontify-natively t)
;; 配置打开最近文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
;; 输入字符串替换选中区域字符串
(delete-selection-mode 1)
;; 为emacs-lisp添加显示括号匹配钩子
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;; 配置swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
;; 开启自动补全符号
(require 'smartparens-config)
;; 给emacs-lisp添加自动补全符号钩子
(smartparens-global-mode t)
;; 指定文件使用指定mode打开
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
