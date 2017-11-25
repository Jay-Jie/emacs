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
;; 为emacs-lisp添加显示括号匹配钩子
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;; 全局缩写
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ("we" "wxzove")
					    ))

;; 输入字符串替换选中区域字符串
(delete-selection-mode 1)

(provide 'init-better-defaults)
