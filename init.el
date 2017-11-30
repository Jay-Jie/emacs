(package-initialize)

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)    ; 类似于 package-initialize

(require 'pallet)
(pallet-mode t)      ; 激活 pallet, 在安装包时将 Cask 文件写入相应信息

(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'init-functions)
(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-org)
(require 'init-keybindings)
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))

(load-file custom-file)
