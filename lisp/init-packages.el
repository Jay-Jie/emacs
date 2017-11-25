 (when (>= emacs-major-version 24)
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
		popwin ;; 光标移动至新buffer
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

;; 给emacs-lisp添加自动补全符号钩子
(smartparens-global-mode t)
;; 配置swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; 指定文件使用指定mode打开
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))
;; 自动补全
(global-company-mode t)
;; 加载主题
(load-theme 'zenburn t)
(require 'popwin)
(popwin-mode t)

(provide 'init-packages)
