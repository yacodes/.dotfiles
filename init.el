;;; package --- Init file
;; User details

;;; Commentary:
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; packages
;;; Code:
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Install use-package if not yet
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Sync user shell and Emacs shell
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; Backup configuration
(setq-default make-backup-files nil) ;; Do not make backup files
(setq-default create-lockfiles nil)  ;; Do not create lockfiles

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
(setq-default user-full-name "Aleksandr Yakunichev")
(setq-default user-mail-address "hi@ya.codes")

(setq-default inhibit-startup-screen t) ;; Configure startup screen
;; (setq-default truncate-lines t)         ;; Truncate lines
(setq-default word-wrap t)              ;; Wrap words
(setq-default split-height-threshold 1) ;; Windows default splitting

(setq-default tab-width 2)                              ;; Set tab-width
(setq-default indent-tabs-mode nil)                     ;; Disable tabs?
(defalias 'yes-or-no-p 'y-or-n-p)                       ;; Map yes & no to y & n
(global-display-line-numbers-mode 1)                    ;; Show line numbers
(global-hl-line-mode)                                   ;; Highlight line under the cursor
(setq-default ring-bell-function 'ignore)                       ;; Turn off the alarm
(setq-default backup-directory-alist '(("~/.emacs.d/backups"))) ;; Set backup directories

;; Smart buffer switching
(defun switch-to-previous-buffer ()
  "Switch to previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) t)))

;; Text scaling key bindings
;; @TODO Move to general.el
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(setq-default echo-keystrokes 0.1)
(setq-default use-dialog-box nil)
(setq-default visible-bell t)
(setq-default show-paren-style 'parenthesis) ;; Highlighting style (parenthesis | expression | mixed)
(show-paren-mode t)                          ;; Highlight matching brackets
(electric-pair-mode)                         ;; Auto close bracket insertion (Emacs 24+)

(defun delete-current-file ()
  "Delete the file associated with the current buffer.
Delete the current buffer too.
If no file is associated, just close buffer without prompt for save."
  (interactive)
  (let ((currentFile (buffer-file-name)))
    (when (yes-or-no-p (concat "Delete file?: " currentFile))
      (kill-buffer (current-buffer))
      (when currentFile
        (delete-file currentFile)))))

;; Emojis support
(use-package emojify
  :hook (after-init . global-emojify-mode))

;; Lisps
(defun setup-lisp-repl ()
  "Set up Lisp repl config."
  (display-line-numbers-mode -1) ;; Remove line-numbers from REPL
  (minimize-window (selected-window)) ;; Minimize and then adjust window height as desired
  (window-resize (selected-window) 6))

;; CIDER for Clojure development
(use-package cider
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode-enable) ;; Emacs lisp rainbow
  (add-hook 'cider-repl-mode-hook (lambda () (display-line-numbers-mode -1))))

;; Geiser for Scheme-related stuff
(use-package geiser)
(use-package geiser-guile
  :after geiser
  :config
  (setq-default geiser-guile-binary "/usr/bin/guile3")
  (add-hook 'geiser-repl-mode-hook 'setup-lisp-repl)
  (add-hook 'ielm-mode-hook 'setup-lisp-repl))

;; Evil-in-REPL instead of the minibuffer
(use-package eval-in-repl
  :config
  (load "./eval-in-repl-geiser.el")
  (load "./eval-in-repl-ielm.el")
  (load "./eval-in-repl-cider.el")
  (require 'eval-in-repl-geiser)
  (require 'eval-in-repl-ielm)
  (require 'eval-in-repl-cider)
  (setq-default eir-jump-after-eval nil)
  (setq-default eir-repl-placement 'below))

;; Elfeed RSS Reader
(use-package elfeed
  :config
  (setq-default elfeed-db-directory "~/Org/.elfeed"))
(use-package elfeed-org
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
  (ligature-set-ligatures '(geiser-mode clojure-mode elisp-mode web-mode lilypond-mode typescript-mode go-mode)
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

;; Undo-redo
(use-package undo-tree
  :config
  (global-undo-tree-mode))

;; Evil mode
(setq-default evil-want-keybinding nil)
(use-package evil
  :after undo-tree
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-tree)
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line))

;; Writegood-mode
(use-package writegood-mode
  :load-path "~/.sources/writegood-mode")

;; Helm
(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1))

(use-package helm-projectile
  :after helm
  :config
  (helm-projectile-on))

(use-package magit)
(use-package which-key
  :config
  (which-key-mode))

(use-package company ;; Autocompletion popup
  :config
  (global-company-mode)                             ;; Initialize globally
  (company-tng-mode)                                ;; Use TAB to cycle through suggestions
  (setq-default company-minimum-prefix-length 1)    ;; Show suggestions after 1 character
  (setq-default company-selection-wrap-around t)    ;; Cycle through variants
  (setq-default company-dabbrev-downcase nil)       ;; Be aware of the case
  (setq-default company-format-margin-function nil) ;; Remove icons
  (setq-default company-idle-delay 0))              ;; Show suggestions immediately

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package hideshow
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
   '(yaml-mode "\\s-*\\_<\\(?:[^:]+\\)\\_>" "" "#" +data-hideshow-forward-sexp nil)))

(use-package evil-indent-plus)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode-enable) ;; Emacs lisp rainbow

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-hook 'yaml-mode-hook (lambda () (toggle-truncate-lines t)))
  (add-hook 'yaml-mode-hook 'hs-minor-mode))

;; Web development modules
(use-package lsp-mode
  :config (setq-default lsp-headerline-breadcrumb-enable nil)
  :hook ((go-mode . lsp-deferred)
         (web-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config (setq-default lsp-ui-doc-show-with-cursor t))
(use-package helm-lsp
  :after lsp-mode
  :commands helm-lsp-workspace-symbol)

;; Golang
(defun lsp-go-install-save-hooks ()
  "Install lsp hooks for golang."
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(use-package go-mode
  :config
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks))

;; TypeScript
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
  :after web-mode
  :config
  ;; (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode)))))

(defun web-mode-init-hook ()
  "Hooks for Web mode.  Adjust indent."
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-css-indent-offset 2)
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-attr-indent-offset 2)
  (setq-default web-mode-attr-value-indent-offset 2)
  (setq-default web-mode-indentless-elements 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-sql-indent-offset 2)
  (setq-default web-mode-block-padding 2)
  (setq-default web-mode-style-padding 2)
  (setq-default web-mode-script-padding 2))

(use-package web-mode
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
  :config
  (add-hook 'flycheck-mode-hook 'add-node-modules-path))

;; Distraction-free writing
(use-package writeroom-mode
  :config
  (setq-default writeroom-width 90)
  (add-hook 'writeroom-mode-enable-hook (lambda ()
                                          (display-line-numbers-mode -1)
                                          (setf (cdr (assq 'continuation fringe-indicator-alist)) '(nil nil))))
  (add-hook 'writeroom-mode-disable-hook (lambda ()
                                           (display-line-numbers-mode 1)
                                           (setf (cdr (assq 'continuation fringe-indicator-alist)) '(left-curly-arrow right-curly-arrow)))))

;; Prettier JS
(use-package prettier-js
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode)
  (add-hook 'typescript-mode-hook 'prettier-js-mode))

(use-package winum
  :config
  (winum-mode)
  (winum-set-keymap-prefix (kbd "C-w")))

;; ;; General keybindings
(use-package general
  :config
  (general-evil-setup t)
  (general-auto-unbind-keys)
    
  ;; General execute
  (general-define-key
   :states 'normal
   :keymaps 'override
   :prefix "SPC"
   :non-normal-prefix "SPC"
   "t" 'toggle-truncate-lines
   "c" 'writeroom-mode
   "TAB" 'switch-to-previous-buffer)
  (general-define-key
   :states 'normal
   :keymaps 'override
   :prefix "SPC"
   "w" (general-key "C-w")
   "w u" 'winner-undo
   "w z" 'winner-redo
   "x" (general-key "C-x")
   "b b" 'helm-buffers-list
   "w g" 'writegood-mode
   "e" 'elfeed
   "/" 'helm-projectile-ag)
  (general-define-key
   :keymaps '(normal emacs)
   "%" 'match-paren)
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
    "d" 'delete-current-file
    "s" 'save-buffer
    "S" 'save-some-buffers
    "i" 'insert-file
    "f" 'helm-find-files)

  ;; CIDER keybindings
  (nmap
    :keymaps 'clojure-mode-map
    "RET" 'eir-eval-in-cider)

  ;; Elisp keybindings
  (nmap
    :keymaps 'emacs-lisp-mode-map
    "RET" 'eir-eval-in-ielm)

  ;; Geiser keybindings
  (nmap
    :keymaps 'geiser-mode-map
    "RET" 'eir-eval-in-geiser)

  ;; Org-mode keybindings
  (nmap
   :keymaps 'org-mode-map
   "t" 'org-todo
   "RET" 'org-open-at-point)

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
  :config
  (evil-collection-init))

;; Theme
(use-package base16-theme
  :config
  (load-theme 'base16-tomorrow-night t)
  (set-background-color "#151515")
  (setq default-frame-alist '((background-color . "#151515")))
  (set-face-attribute 'default nil :family "Iosevka" :height 178)
  (set-face-attribute 'fringe nil :background nil))

;; Beautiful text wrapping
(use-package visual-fill-column
  :config
  (setq-default visual-fill-column-width 90))

(setq-default fill-column 90)
(setq-default comment-column 90)

;; Org mode
(use-package org
  :config
  (setq-default org-log-done 'time)
  (setq-default org-startup-folded t)
  (setq-default org-hide-leading-stars t)
  (setq-default org-hide-emphasis-markers t)
  (setq-default org-archive-reversed-order t)
  (add-to-list 'org-link-frame-setup '(file . find-file))
  (add-hook 'org-mode-hook '(lambda () (setq truncate-lines nil)))
  (add-hook 'org-mode-hook #'visual-fill-column-mode)
  (add-hook 'org-mode-hook #'writeroom-mode)
  (setq-default org-html-doctype "html5")
  (setq-default org-html-html5-fancy t)
  (setq-default org-directory "~/Org/")
  (setq-default org-tag-faces )
  (setq-default org-agenda-files (list "~/Org/Tasks.org"))
  (setq-default org-confirm-babel-evaluate nil)
  (setq-default org-plantuml-jar-path (expand-file-name "~/.sources/plantuml.jar"))
  (set-face-attribute 'org-tag nil :weight 'regular)
  (set-face-attribute 'org-document-title nil :height 290 :weight 'regular)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (org . t)
     (sql . t)
     (lilypond . t)
     (plantuml . t))))

(use-package org-roam
  :ensure t
  :after org
  :custom
  (org-roam-directory (file-truename "~/Org/Roam/"))
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode))

(use-package ox-reveal
  :after org)

(use-package htmlize
  :after org)

(use-package org-ql
  :after org)
(defun tiny/weekly ()
  "Insert formatted weekly report in the current buffer."
  (interactive)
  (insert
   (replace-regexp-in-string
    "\\]\\]" "`"
    (replace-regexp-in-string "\\[\\[.*\\]\\[" "`"
                              (concat
                               (format "*Last week:*\n%s."
                                       (mapconcat (lambda (x) (format "• %s" x))
                                                  (org-ql-select "~/Org/Tasks.org_archive"
                                                    '(and (and (ts :from -7 :to today) (done)) (tags "tiny"))
                                                    :sort '(date)
                                                    :action '(org-get-heading t t)) ";\n"))
                               (format "\n\n*This week:*\n%s."
                                       (mapconcat (lambda (x) (format "• %s" x))
                                                  (org-ql-select "~/Org/Tasks.org"
                                                    '(and (todo) (tags "tiny"))
                                                    :sort '(date)
                                                    :action '(org-get-heading t t)) ";\n")))))))

(use-package pdf-tools
  :after general
  :config
  (pdf-tools-install)
  (add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1))))

(use-package rainbow-delimiters
  :config
  (rainbow-delimiters-mode))

;; Matches parens
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %.
ARG: I do not know what this is."
  (interactive "p")
  (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; Projectile
(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

;; TidalCycles
(use-package tidal
  ;; Music pattern live-coding language syntax and environment
  :config
  ;; Global config
  (setq-default tidal-boot-script-path "/home/ya/Workspace/Audio/TidalCycles/Sandbox/2020-09-07/Boot.hs")
  (setq-default tidal-interpreter "stack")
  (setq-default tidal-interpreter-arguments (list "exec" "--package" "tidal" "--" "ghci"))
  ;; Evil keybindings
  (evil-define-key 'normal tidal-mode-map (kbd "<RET>") 'tidal-run-multiple-lines))

;; Wrap isearch
(defadvice isearch-repeat (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-repeat 'after 'isearch-no-fail)
    (ad-activate 'isearch-repeat)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-repeat 'after 'isearch-no-fail)
    (ad-activate 'isearch-repeat)))

(setq-default initial-buffer-choice "~/Org/Tasks.org") ;; Initial buffer

;; Remove bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(fringe-mode 0)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-feeds nil)
 '(helm-minibuffer-history-key "M-p")
 '(helm-mode t)
 '(org-agenda-files '("~/Org/Tasks.org"))
 '(package-selected-packages
   '(org-roam cider eval-in-repl evil-in-repl undo-tree emojify exec-path-from-shell writegood-mode ox-reveal go-mode writeroom-mode evil-indent-plus bicycle yafolding highlight-indentation highlight-indentation-mode origami flycheck unicode-fonts htmlize helm-ag pdf-tools org-ql visual-fill-column yaml-mode prettier-js prettier-js-mode add-node-modules-path web-mode winum ace-window magit helm-projectile evil-collection company which-key helm general gnu-elpa-keyring-update evil tidal rainbow-delimiters markdown-mode use-package base16-theme projectile glsl-mode))
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
