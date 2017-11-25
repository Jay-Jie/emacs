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

(provide 'init-keybindings)
