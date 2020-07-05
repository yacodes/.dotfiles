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

;; Personal information
(setq user-full-name "Aleksandr Yakunichev"
      user-mail-address "hi@ya.codes")

;; Remove bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Backup files
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; Configure startup screen
(setq inhibit-startup-screen t)

;; Truncate lines
;; (setq-default truncate-lines t)

;; Wrap words
(setq-default word-wrap t)

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

;; Smart buffer switching
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; key bindings
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Turn down the time to echo keystrokes so I don't have to wait around for things to happen. Dialog boxes are also a bit annoying, so just have Emacs use the echo area for everything. Beeping is for robots, and I am not a robot. Use a visual indicator instead of making horrible noises. Oh, and always highlight parentheses. A person could go insane without that.
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)

;; Evil mode
(setq-default evil-want-keybinding nil)
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line)
  )

;; Helm
(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  (helm-mode 1))

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

;; Magit
(use-package magit
  :ensure t
  :config
  (use-package evil-magit
    :ensure t))

;; Which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Company (auto-complete)
(use-package company
  :ensure t
  :config
  (global-company-mode)
  (setq company-idle-delay 0.1))

;; Autopairs
(use-package autopair
  :ensure t
  :config
  (autopair-global-mode))

(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

;; Web development modules
;; Typescript
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  ;;(flycheck-mode +1)
  ;;(setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(use-package tide
  :ensure t
  :config
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode))

(defun web-mode-init-hook ()
  "Hooks for Web mode. Adjust indent."
  (setq web-mode-markup-indent-offset 2))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  (add-hook 'web-mode-hook  'web-mode-init-hook)
  (setq-default js-indent-level 2
                web-mode-markup-indent-offset 2
                web-mode-css-indent-offset 2
                web-mode-code-indent-offset 2))

(use-package flycheck
  :ensure t
  :config
  (require 'flycheck)
  (global-flycheck-mode)
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint json-jsonlist)))
  ;; Enable eslint checker for web-mode
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  ;; Enable flycheck globally
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package add-node-modules-path
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook 'add-node-modules-path))


(use-package prettier-js
  :ensure t
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode))

(use-package winum
  :ensure t
  :config
  (winum-mode)
  (winum-set-keymap-prefix (kbd "C-w")))

;; General keybindings
(use-package general
  :ensure t
  :config

  (general-evil-setup t)
    
  ;; General execute
  (general-define-key
   :keymaps '(normal hybrid iedit-insert emacs)
   :prefix "SPC"
   :non-normal-prefix "SPC"
   "TAB" 'switch-to-previous-buffer)
  (general-define-key
   :keymaps '(normal emacs)
   :prefix "SPC"
   "w" (general-key "C-w")
   "w u" 'winner-undo
   "w z" 'winner-redo
   "x" (general-key "C-x")
   "b b" 'helm-buffers-list
   "/" 'helm-projectile-grep)
  (nmap
    :prefix ","
    ";" 'comment-line
    "," (general-key "C-c C-c"))
  (vmap
    :prefix "SPC"
    ";" 'comment-dwim
    "\\" 'indent-region)
  (nmap
    :prefix "SPC"
    ";" 'comment-line
    "g" 'magit)
  (nmap
    :prefix "SPC f"
    "s" 'save-buffer
    "S" 'save-some-buffers
    "i" 'insert-file
    "f" 'helm-find-files)
  
  ;; Org-mode keybindings
  (nmap
   :keymaps 'org-mode-map
   "t" 'org-todo)

  (nmap
    :keymaps 'org-mode-map
    :prefix ","
    "a" 'org-archive-subtree-default
    "^" 'org-sort
    "l" 'org-insert-link
    "o" 'org-open-at-point
    "i" 'org-clock-in)

  ;; Which-key keybindings
  (nmap
   :prefix "SPC"
   "?" 'which-key-show-full-major-mode)

  ;; Projectile keybindings
  (nmap
    :prefix "SPC"
    "p" 'projectile-command-map)
  )

(use-package evil-collection
  :ensure t
  :config
  (evil-collection-init))

;; Theme
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-tomorrow-night t)
  (set-background-color "#151515"))

;; Font settings
;; Set default font
(set-face-attribute 'default nil
		    :family "Iosevka"
		    :height 150
		    :weight 'normal
		    :width 'normal)

;; Beautiful text wrapping
(use-package visual-fill-column
  :ensure t)

;; Org mode
(use-package org
  :ensure t
  :config
  (add-hook 'org-mode-hook '(lambda () (setq visual-fill-column-width 100)))
  (add-hook 'org-mode-hook '(lambda () (setq truncate-lines nil)))
  (add-hook 'org-mode-hook #'visual-fill-column-mode)
  (setq-default org-directory "~/Org/")
  (setq-default org-agenda-files (list "~/Org/Tasks.org")))

(use-package org-ql
  :ensure t
  :after org
  :config
  (defun org-review/setka-last-week ()
    (interactive)
    (org-ql-search "~/Org/Tasks.org_archive"
      '(and (and (ts :from -7 :to today) (done)) (tags "setka"))
      :title "Setka: Last Week"
      :sort '(date)
      :super-groups '((:auto-ts t))))
  (defun org-review/setka-yesterday ()
    (interactive)
    (org-ql-search "~/Org/Tasks.org_archive"
      '(and (and (ts :from -1 :to today) (done)) (tags "setka"))
      :title "Setka: Yesterday"
      :sort '(date)
      :super-groups '((:auto-ts t)))))

;; PDF Tools
(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))

;; Rainbow
(use-package rainbow-delimiters
  :ensure t
  :config
  (rainbow-delimiters-mode))

;; Matches parens
(global-set-key (kbd "%") 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; Projectile
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

;; GLSL
(use-package glsl-mode
  :ensure t)

;; SCLang
(add-to-list 'load-path "~/.sources/supercollider/editors/sc-el/el")
(require 'sclang)
(setenv "PATH" (concat (getenv "PATH") ":/Applications/SuperCollider.app:/Applications/SuperCollider.app/Contents/MacOS"))
(setq exec-path (append exec-path '("/Applications/SuperCollider.app"  "/Applications/SuperCollider.app/Contents/MacOS" )))
(use-package sclang-snippets
  :ensure t)

;; TidalCycles
(use-package tidal
  ;; Music pattern live-coding language syntax and environment
  :ensure t
  :config
  ;; Global config
  (setq-default tidal-boot-script-path "/home/ya/Workspace/Audio/TidalCycles/performances/20200626-swgbbo/Boot.hs")
  (setq-default tidal-interpreter "stack")
  (setq-default tidal-interpreter-arguments
                (list "exec" "--package" "tidal" "--" "ghci"))
  ;; Evil keybindings
  (evil-define-key 'normal tidal-mode-map (kbd "<RET>") 'tidal-run-multiple-lines)
  )

;; Daemon mode
(require 'server)
(if (not (server-running-p)) (server-start))

;; Wrap isearch
(defadvice isearch-repeat (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-repeat 'after 'isearch-no-fail)
    (ad-activate 'isearch-repeat)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-repeat 'after 'isearch-no-fail)
    (ad-activate 'isearch-repeat)))

;; Initial buffer
(setq-default initial-buffer-choice "~/Org/Tasks.org")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-mode t)
 '(org-agenda-files (quote ("~/Org/Tasks.org")))
 '(package-selected-packages
   (quote
    (pdf-tools org-ql visual-fill-column yaml-mode prettier-js prettier-js-mode add-node-modules-path web-mode winum tide autopair ace-window evil-magit magit helm-projectile evil-collection company which-key helm general gnu-elpa-keyring-update evil tidal sclang-snippets sclang-extensions rainbow-delimiters markdown-mode use-package base16-theme projectile glsl-mode)))
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
