;; 配置swiper
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
;; 打开最近文件
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
;; 查找定义
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)
;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)
;; 查找版本控制文件
(global-set-key (kbd "C-c p f") 'counsel-git)
;; 全局缩进
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)
;; 补全(弥补company)
(global-set-key (kbd "s-/") 'hippie-expand)
;; 避免创建新的buffer
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
;; 定义两个空格和四个空格的切换
(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)
;; 函数搜索
(global-set-key (kbd "M-s i") 'counsel-imenu)
;; 快速选中
(global-set-key (kbd "C-=") 'er/expand-region)
;; 同时修改
(global-set-key (kbd "M-s e") 'iedit-mode)
;; 快速创建TODO事项
(global-set-key (kbd "C-c r") 'org-capture)
;; 覆盖company下的快捷键
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))
;; ag命令行搜索
(global-set-key (kbd "C-c p s") 'helm-do-ag-project-root)


(provide 'init-keybindings)
