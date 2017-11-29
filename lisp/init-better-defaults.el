;;文件移动至顶部或底部时不发出声音
(setq ring-bell-function 'ignore)
;; 显示行号
(global-linum-mode t)
;; 自动加载已修改的文件
(global-auto-revert-mode t)
;; 禁止备份文件
(setq make-backup-files nil)
;; 禁止自动生成临时文件
(setq auto-save-default nil)
;; 配置打开最近文件
(recentf-mode 1)
(setq recentf-max-menu-item 25)
;; 定义当光标在括号中间时也高亮显示匹配括号
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))
;; 为emacs-lisp添加显示括号匹配钩子
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 全局缩写
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ("we" "wxzove")
					    ))

;; 输入字符串替换选中区域字符串
(delete-selection-mode 1)

;; 定义全局缩进
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))
;; hippie补全
(setq hippie-expand-try-function-list '(try-expand-debbrev
					try-expand-debbrev-all-buffers
					try-expand-debbrev-from-kill
					try-complete-file-name-partially
					try-complete-file-name
					try-expand-all-abbrevs
					try-expand-list
					try-expand-line
					try-complete-lisp-symbol-partially
					try-complete-lisp-symbol))
;; 定义简写yes和no
(fset 'yes-or-no-p 'y-or-n-p)
;; 设置总是递归删除
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
;; 设置始终只创建一个buffer
(put 'dired-find-alternate-file 'disabled nil)
;; 通过C-x C-j打开当前文件所在目录
(require 'dired-x)
;; 当使用"S+c"时.默认从一个窗口复制到另外一个窗口.
(setq dired-dwim-target t)
;; 删除DOS下的换行符
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))
;; 增强occur-mode搜索功能
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)
;; 设置默认编码
(set-language-environment "UTF-8")
;; 获取chrome打开的当前页面
(defun wxzove/retrieve-chrome-current-tab-url()
  "Get the URL of the active tab of the first window"
  (interactive)
  (let ((result (do-applescript
		 (concat
		  "set frontmostApplication to path to frontmost application\n"
		  "tell application \"Google Chrome\"\n"
		  " set theUrl to get URL of active tab of first window\n"
		  " set theResult to (get theUrl) \n"
		  "end tell\n"
		  "activate application (frontmostApplication as text)\n"
		  "set links to {}\n"
		  "copy theResult to the end of links\n"
		  "return links as string\n"))))
    (format "%s" (s-chop-suffix "\"" (s-chop-prefix "\"" result)))))

(provide 'init-better-defaults)
