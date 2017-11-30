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
		      reveal-in-osx-finder ;; 通过finder打开当前buffer文件
		      web-mode ;; 可编写html.js.php.css...
		      js2-refactor ;; 重构js的库
		      expand-region ;; 快速选中
		      iedit ;; 同时修改
		      org-pomodoro ;;番茄工作法
		      helm-ag ;; 命令行快速搜索工具
		      flycheck ;; 代码检查
		      php-mode ;; PHP
		      window-numbering ;; 快速切换窗口
		      which-key ;; 快捷键提示
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
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
;; 配置swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; 指定文件使用指定mode打开
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
	 ("\\.html\\'" . web-mode)
         ("\\.php\\'" . php-mode))
       auto-mode-alist))
;; 自动补全
(global-company-mode t)
;; 加载主题
(load-theme 'zenburn t)
(require 'popwin)
(popwin-mode t)
;; 配置web-mode默认缩进
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)
;; 定义web-mode下两个空格和四个空格的切换
(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	     (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
	     (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))
;; 给js添加hook
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")
;; 增强imenu功能
(defun js2-imenu-make-index ()
      (interactive)
      (save-excursion
	;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
	(imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
				   ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
				   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
	      (lambda ()
		(setq imenu-create-index-function 'js2-imenu-make-index)))
;; 加载org-pomodoro
(require 'org-pomodoro)
;; 开始flycheck检查
(add-hook 'js2-mode-hook 'flycheck-mode)
(add-hook 'php-mode-hook 'flycheck-mode)
;; yasnippet代码补全
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
;; 开启快速切换窗口
(window-numbering-mode t)
;; 开启快捷键提示
(which-key-mode t)
;; 将which-key配置到右边
(setq which-key-side-window-location 'right)

(provide 'init-packages)
