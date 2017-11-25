;; 支持org文件SRC语句块中语法高亮
(require 'org)
(setq org-src-fontify-natively t)
;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/org"))

(provide 'init-org)
