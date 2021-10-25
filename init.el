;; User details

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; packages
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  ;; (setq load-path (append (list (expand-file-name "/usr/share/emacs/site-lisp")) load-path))
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

(require 'use-package)

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; Backup configuration
(setq make-backup-files nil)
(setq-default make-backup-files nil)
(setq create-lockfiles nil)
(setq-default create-lockfiles nil)

;; Coding system
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)

(autoload 'LilyPond-mode "lilypond-mode")
(setq auto-mode-alist (cons '("\\.ly$" . LilyPond-mode) auto-mode-alist))
(add-hook 'LilyPond-mode-hook (lambda () (turn-on-font-lock)))

;; Personal information
(setq user-full-name "Aleksandr Yakunichev"
      user-mail-address "hi@ya.codes")

;; Remove bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Configure startup screen
(setq inhibit-startup-screen t)

;; Truncate lines
;; (setq-default truncate-lines t)

;; Wrap words
(setq-default word-wrap t)

;; Indentation
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; Remove backup files
(setq make-backup-files nil)

;; Map yes & no to y & n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Line numbers
(global-display-line-numbers-mode 1)

;; Turn off the alarm
(setq ring-bell-function 'ignore)

;; Smart buffer switching
(defun switch-to-previous-buffer ()
  "Switch to previous buffer."
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

;; Emojis support
(use-package emojify
  :ensure t
  :hook (after-init . global-emojify-mode))

;; Elfeed RSS Reader
(use-package elfeed
  :ensure t
  :config
  (setq-default elfeed-db-directory "~/Org/.elfeed"))
(use-package elfeed-org
  :ensure t
  :after elfeed
  :config
  (elfeed-org)
  (setq-default rmh-elfeed-org-files (list "~/Org/RSS.org")))

;; @TODO Breaks sclang-start command in sclang-mode
(use-package ligature
  :load-path "~/.sources/ligature.el"
  :config
  (ligature-set-ligatures '(org-mode)
			  '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "||=" "||>"
                            ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                            "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                            "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                            "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                            "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                            "~>" "~-" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                            "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                            ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                            "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                            "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                            "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                            "\\" "://"))
  (ligature-set-ligatures '(web-mode lilypond-mode typescript-mode go-mode)
			  '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                            ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                            "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                            "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                            "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                            "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                            "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                            "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                            ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                            "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                            "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                            "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                            "\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

;; Evil mode
(setq-default evil-want-keybinding nil)
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line))

;; Writegood-mode
(use-package writegood-mode
  :load-path "~/.sources/writegood-mode"
  :ensure t)

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

;; ;; Company (auto-complete)
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

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package hideshow
  :ensure t
  :config
  (defun +data-hideshow-forward-sexp (arg)
    (let ((start (current-indentation)))
      (forward-line)
      (unless (= start (current-indentation))
        (require 'evil-indent-plus)
        (let ((range (evil-indent-plus--same-indent-range)))
          (goto-char (cadr range))
          (end-of-line)))))
  (add-to-list 'hs-special-modes-alist
   '(yaml-mode "\\s-*\\_<\\(?:[^:]+\\)\\_>" "" "#" +data-hideshow-forward-sexp nil))
  )

(use-package evil-indent-plus
  :ensure t)

(use-package yaml-mode
  :ensure t
  :mode (".yaml$")
  ;; :hook (yaml-mode . origami-mode)
  :init
  (add-hook 'yaml-mode-hook (lambda () (toggle-truncate-lines t)))
  (add-hook 'yaml-mode-hook 'hs-minor-mode))

;; Web development modules
(use-package lsp-mode
  :ensure t
  :init
  :hook ((go-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))
(use-package lsp-ui :commands lsp-ui-mode)
(use-package helm-lsp :commands helm-lsp-workspace-symbol)

;; Golang
(defun lsp-go-install-save-hooks ()
  "Install lsp hooks for golang."
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(use-package go-mode
  :ensure t
  :config
  ;; (add-hook 'go-mode-hook 'lsp-deferred)
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks))

;; Typescript
(defun setup-tide-mode ()
  "Configure tide-mode."
  (interactive)
  (tide-setup)
  ;;(flycheck-mode +1)
  ;;(setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-default typescript-indent-level 2)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(use-package tide
  :ensure t
  :after web-mode
  :config
  ;; (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode)))))

(defun web-mode-init-hook ()
  "Hooks for Web mode. Adjust indent."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  (setq web-mode-attr-value-indent-offset 2)
  (setq web-mode-indentless-elements 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-sql-indent-offset 2)
  (setq web-mode-block-padding 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-script-padding 2))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
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

;; Distraction-free writing
(use-package writeroom-mode
  :ensure t
  :config
  (setq-default writeroom-width 90)
  (add-hook 'writeroom-mode-enable-hook (lambda ()
                                          (display-line-numbers-mode -1)
                                          (setf (cdr (assq 'continuation fringe-indicator-alist)) '(nil nil))))
  (add-hook 'writeroom-mode-disable-hook (lambda ()
                                           (display-line-numbers-mode 1)
                                           (setf (cdr (assq 'continuation fringe-indicator-alist)) '(left-curly-arrow right-curly-arrow)))))

;; Concentration mode
;; (defun toggle-concentration-mode ()
;;   "Toggle concentration mode on and off."
;;   (interactive)
;;   (if (get 'toggle-concentration-mode 'state)
;;       (progn
;;         (display-line-numbers-mode 1)
;;         (writeroom-mode -1)
;;         (put 'toggle-concentration-mode 'state nil))
;;     (progn
;;       (display-line-numbers-mode -1)
;;       (writeroom-mode 1)
;;       (put 'toggle-concentration-mode 'state t))))

;; Prettier JS
(use-package prettier-js
  :ensure t
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode)
  (add-hook 'typescript-mode-hook 'prettier-js-mode))

(use-package winum
  :ensure t
  :config
  (winum-mode)
  (winum-set-keymap-prefix (kbd "C-w")))

;; ;; General keybindings
(use-package general
  :ensure t
  :config

  (general-evil-setup t)
    
  ;; General execute
  (general-define-key
   :keymaps '(normal hybrid iedit-insert emacs)
   :prefix "SPC"
   :non-normal-prefix "SPC"
   "t" 'toggle-truncate-lines
   "c" 'writeroom-mode
   ;; "c" 'toggle-concentration-mode
   ;; "c" 'toggle-concentration-mode
   "TAB" 'switch-to-previous-buffer)
  (general-define-key
   :keymaps '(normal emacs)
   :prefix "SPC"
   "w" (general-key "C-w")
   "w u" 'winner-undo
   "w z" 'winner-redo
   "x" (general-key "C-x")
   "b b" 'helm-buffers-list
   "w g" 'writegood-mode
   "e" 'elfeed
   "/" 'helm-projectile-ag)
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

  ;; Yaml keybindings
  (nmap
   :keymaps 'yaml-mode-map
   "TAB" 'hs-toggle-hiding)

  (nmap
    :keymaps 'org-mode-map
    :prefix ","
    "a" 'org-archive-subtree-default
    "^" 'org-sort
    "l" 'org-insert-link
    "o" 'org-open-at-point
    "i" 'org-clock-in
    "r r" 'org-reveal-export-to-html
    "r b" 'org-reveal-export-to-html-and-browse)

  ;; Which-key keybindings
  (nmap
   :prefix "SPC"
   "?" 'which-key-show-full-major-mode)

  ;; Projectile keybindings
  (nmap
    :prefix "SPC"
    "p" 'projectile-command-map))

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
		    :height 170
		    :weight 'normal
		    :width 'normal)

(set-face-attribute 'fringe nil :background nil)

;; Beautiful text wrapping
(use-package visual-fill-column
  :ensure t
  :config
  (setq-default visual-fill-column-width 90))

;; Org mode
(use-package org
  :ensure t
  :config
  (setq org-log-done 'time)
  (setq org-hide-leading-stars t)
  (add-hook 'org-mode-hook '(lambda () (setq truncate-lines nil)))
  (add-hook 'org-mode-hook #'visual-fill-column-mode)
  (setq-default org-html-doctype "html5")
  (setq-default org-html-html5-fancy t)
  (setq-default org-directory "~/Org/")
  (setq-default org-agenda-files (list "~/Org/Tasks.org"))
  (setq-default org-confirm-babel-evaluate nil)
  (setq-default org-plantuml-jar-path
                (expand-file-name "~/.sources/plantuml.jar"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (org . t)
     (sql . t)
     (lilypond . t)
     (plantuml . t))))

(use-package ox-reveal
  :ensure t
  :after org)

(use-package htmlize
  :ensure t
  :after org)

(use-package org-ql
  :ensure t
  :after org
  :config
  (defun org-review/tiny-last-week ()
    (interactive)
    (org-ql-search "~/Org/Tasks.org_archive"
      '(and (and (ts :from -7 :to today) (done)) (tags "tiny"))
      :title "Tiny: Last Week"
      :sort '(date)
      :super-groups '((:auto-ts t))))
  (defun org-review/tiny-yesterday ()
    (interactive)
    (org-ql-search "~/Org/Tasks.org_archive"
      '(and (and (ts :from -1 :to today) (done)) (tags "tiny"))
      :title "Tiny: Yesterday"
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

;; ;; GLSL
(use-package glsl-mode :ensure t)

;; ;; SCLang
;; (require 'sclang)
(use-package sclang-snippets
  :ensure t
  :config
  (setq-default sclang-indent-level 2))

;; TidalCycles
(use-package tidal
  ;; Music pattern live-coding language syntax and environment
  :ensure t
  :config
  ;; Global config
  (setq-default tidal-boot-script-path "/home/ya/Workspace/Audio/TidalCycles/Sandbox/2020-09-07/Boot.hs")
  (setq-default tidal-interpreter "stack")
  (setq-default tidal-interpreter-arguments (list "exec" "--package" "tidal" "--" "ghci"))
  ;; Evil keybindings
  (evil-define-key 'normal tidal-mode-map (kbd "<RET>") 'tidal-run-multiple-lines))

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
 '(elfeed-feeds nil)
 '(helm-mode t)
 '(org-agenda-files '("~/Org/Tasks.org"))
 '(package-selected-packages
   '(emojify exec-path-from-shell writegood-mode ox-reveal go-mode writeroom-mode evil-indent-plus bicycle yafolding highlight-indentation highlight-indentation-mode origami flycheck unicode-fonts htmlize helm-ag pdf-tools org-ql visual-fill-column yaml-mode prettier-js prettier-js-mode add-node-modules-path web-mode winum tide autopair ace-window evil-magit magit helm-projectile evil-collection company which-key helm general gnu-elpa-keyring-update evil tidal rainbow-delimiters markdown-mode use-package base16-theme projectile glsl-mode))
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
