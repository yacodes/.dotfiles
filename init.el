;; User details

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; packages
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/")))

(require 'use-package)

(setq user-full-name "Aleksandr Yakunichev")
(setq user-mail-address "hi@ya.codes")

;; Remove bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Backup files
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; Remove startup screen
(setq inhibit-startup-screen t)

;; Indentation
(setq tab-width 2
      indent-tabs-mode nil) 

;; Remove backup files
(setq make-backup-files nil)

;; Map yes & no to y & n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Line numbers
(global-display-line-numbers-mode)

;; Turn off the alarm
(setq ring-bell-function 'ignore)

;; Key bindings
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Turn down the time to echo keystrokes so I don't have to wait around for things to happen. Dialog boxes are also a bit annoying, so just have Emacs use the echo area for everything. Beeping is for robots, and I am not a robot. Use a visual indicator instead of making horrible noises. Oh, and always highlight parentheses. A person could go insane without that.
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)

;; Theme
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-tomorrow-night t))

;; Font settings
;; Set default font
(set-face-attribute 'default nil
		    :family "Iosevka"
		    :height 180
		    :weight 'normal
		    :width 'normal)

;; Subtree view for dired
(use-package dired-subtree
  :config
  (bind-keys :map dired-mode-map
             ("i" . dired-subtree-insert)
             (";" . dired-subtree-remove)))

;; Org mode
(use-package org)

;; Projectile
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

;; GLSL
(use-package glsl-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode dired-subtree use-package base16-theme projectile glsl-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
