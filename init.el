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
(eval-and-compile
  (setq use-package-always-ensure t)
  (setq use-package-expand-minimally t))

;; Backup configuration
(setq-default make-backup-files nil) ;; Do not make backup files
(setq-default create-lockfiles nil)  ;; Do not create lockfiles

;; Coding system
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)

;; Personal information
(setq-default user-full-name "Aleksandr Yakunichev")
(setq-default user-mail-address "hi@ya.codes")

(setq-default inhibit-startup-screen t) ;; Configure startup screen
;; (setq-default truncate-lines t)      ;; Truncate lines
(setq-default word-wrap t)              ;; Wrap words
(setq-default split-height-threshold 1) ;; Windows default splitting

(setq-default tab-width 2)                              ;; Set tab-width
(setq-default indent-tabs-mode nil)                     ;; Disable tabs?
(defalias 'yes-or-no-p 'y-or-n-p)                       ;; Map yes & no to y & n
(global-display-line-numbers-mode 1)                    ;; Show line numbers
(global-hl-line-mode)                                   ;; Highlight line under the cursor
(setq-default ring-bell-function 'ignore)               ;; Turn off the alarm
(setq backup-directory-alist `((".*" . ,temporary-file-directory))) ;; Store backups in /tmp directory
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))) ;; Store autosave files in /tmp directory

;; Smart buffer switching
(defun switch-to-previous-buffer ()
  "Switch to previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) t)))

(defun string-replace-spaces-to-non-breaking (string)
  "Replace all spaces in STRING to non-breaking ones."
  (string-replace " " " " string))

(defun string-replace-vowels-with-underline (string)
  "Replace all vowels in a STRING with underlines."
  (replace-regexp-in-string "[aáeéyuúiíoó]" "_" string))

(defun string-split-by-spaces (string)
  "Split all letters in a STRING by spaces."
  (string-trim
   (mapconcat (lambda (x) (format "%c " x)) string "")))

(defun ankify-region (begin end)
  "Prepare a region from BEGIN to END for Anki's card."
  (interactive "r")
  (save-excursion
    (let ((contents (buffer-substring-no-properties begin end)))
      (kill-region begin end)
      (insert
       (string-replace-spaces-to-non-breaking
        (string-split-by-spaces
         (string-replace-vowels-with-underline contents)))))))

;; Text scaling key bindings
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(setq-default echo-keystrokes 0.1)
(setq-default use-dialog-box nil)
(setq-default visible-bell t)
(setq-default show-paren-style 'parenthesis) ;; Highlighting style (parenthesis | expression | mixed)
(show-paren-mode t)                          ;; Highlight matching brackets
(electric-pair-mode)                         ;; Auto close bracket insertion (Emacs 24+)
(blink-cursor-mode 0)

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

;; Lisps
(defun setup-lisp-repl ()
  "Set up Lisp repl config."
  (display-line-numbers-mode -1) ;; Remove line-numbers from REPL
  (minimize-window (selected-window)) ;; Minimize and then adjust window height as desired
  (window-resize (selected-window) 6))

(use-package exec-path-from-shell
  :ensure t

  :config
  (exec-path-from-shell-initialize))

;; Geiser for Scheme-related stuff
;; (use-package geiser)
;; (use-package geiser-guile
;;   :mode ("\\.scm\\'" . geiser-mode)
;;   :init (setq geiser-guile-binary "/usr/bin/guile3")
;;   :config
;;   (add-hook 'geiser-repl-mode-hook 'setup-lisp-repl)
;;   (add-hook 'ielm-mode-hook 'setup-lisp-repl))

;; Eval-in-REPL instead of the minibuffer
;; (use-package eval-in-repl
;;   :mode ("\\.scm\\'" . geiser-mode)
;;   :config
;;   (load "./eval-in-repl-geiser.el")
;;   (load "./eval-in-repl-ielm.el")
;;   ;; (load "./eval-in-repl-javascript.el")
;;   (require 'eval-in-repl-geiser)
;;   (require 'eval-in-repl-ielm)
;;   (setq-default eir-jump-after-eval nil)
;;   (setq-default eir-repl-placement 'below))

(use-package posframe
  :ensure t)

(use-package transient
  :ensure t)

(use-package screenshot
  :load-path "~/.sources/screenshot")

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
  (ligature-set-ligatures '(elisp-mode typescript-mode)
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
  :init (setq undo-tree-auto-save-history nil)
  :config (global-undo-tree-mode))

;; Evil mode
(use-package evil
  :init (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-tree)
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line))

(use-package evil-indent-plus)
;; (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode-enable) ;; Emacs lisp rainbow

(use-package hideshow
  :after yaml-mode
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
   "v l" 'set-light-theme
   "v d" 'set-dark-theme
   "TAB" 'switch-to-previous-buffer)
  (general-define-key
   :states 'normal
   :keymaps 'override
   :prefix "SPC"
   "w" (general-key "C-w")
   "x" (general-key "C-x"))
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
    ";" 'comment-line)
  (nmap
    :prefix "SPC f"
    "d" 'delete-current-file
    "s" 'save-buffer
    "S" 'save-some-buffers
    "i" 'insert-file
    ;; "f" 'find-file
    )

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
  )

(use-package evil-collection
  :config
  (evil-collection-init))

;; Theme
(defun set-dark-theme ()
  "Set dark theme for the editor globally."
  (interactive)
  (load-theme 'base16-tomorrow-night t)
  (set-background-color "#151515")
  (setq default-frame-alist '((background-color . "#151515"))))
(defun set-light-theme ()
  "Set light theme for the editor globally."
  (interactive)
  (load-theme 'base16-google-light t))
(use-package base16-theme
  :config
  (set-dark-theme)
  (set-face-attribute 'default nil :family "Iosevka" :height 178)
  (set-face-attribute 'fringe nil :background nil))

;; Beautiful text wrapping
(use-package visual-fill-column
  :init
  (setq visual-fill-column-width 90))

(setq-default fill-column 90)
(setq-default comment-column 90)

;; Org mode
(use-package org
  :custom
  ;; Color palette:
  ;; https://github.com/tinted-theming/base16-emacs/blob/main/build/base16-tomorrow-night-theme.el#L14-L30
  (org-todo-keyword-faces
   '(("APPLIED" . "#b294bb")
     ("INTERVIEW" . "#b294bb")
     ("REJECTED" . "#a3685a")
     ("NO_REPLY" . "#a3685a")))

  (org-file-apps
   '((auto-mode . emacs)
     ("\\.x?html?\\'" . "firefox %s")
     ("\\.pdf\\(::[0-9]+\\)?\\'" . "firefox %s")
     ("\\.mp4\\'" . "vlc \"%s\"")
     ("\\.mkv" . "vlc \"%s\"")))

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
     (plantuml . t))))

(use-package org-roam
  :after org

  :custom
  (org-roam-directory (file-truename "~/Org/Roam/"))
  (org-roam-completion-everywhere t)

  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture))

  :config
  (org-roam-db-autosync-mode))

(use-package ox-reveal
  :after org)

;; (use-package rainbow-delimiters
;;   :config
;;   (rainbow-delimiters-mode))

;; Matches parens
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %.
ARG: I do not know what this is."
  (interactive "p")
  (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; TidalCycles
;; (use-package tidal
;;   ;; Music pattern live-coding language syntax and environment
;;   :config
;;   ;; Global config
;;   (setq-default tidal-boot-script-path "/home/ya/Workspace/Audio/TidalCycles/Sandbox/2020-09-07/Boot.hs")
;;   (setq-default tidal-interpreter "stack")
;;   (setq-default tidal-interpreter-arguments (list "exec" "--package" "tidal" "--" "ghci"))
;;   ;; Evil keybindings
;;   (evil-define-key 'normal tidal-mode-map (kbd "<RET>") 'tidal-run-multiple-lines))

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

(use-package vertico
  :custom
  (vertico-cycle t)

  :init
  (vertico-mode))

(use-package vertico-directory
  :after vertico
  :ensure nil

  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))

  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package consult
  :custom
  (register-preview-delay 0)
  (register-preview-function #'consult-register-format)

  :general
  (general-nmap "SPC / /" 'consult-git-grep)
  (general-nmap "SPC / f" 'consult-flymake)

  :init
  (advice-add #'register-preview :override #'consult-register-window))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((eglot (styles basic))
                                   (file (styles partial-completion)))))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Distraction-free writing
(use-package writeroom-mode
  :custom
  (writeroom-width 100)
  :config
  (add-hook 'writeroom-mode-enable-hook (lambda ()
                                          (display-line-numbers-mode -1)
                                          (setf (cdr (assq 'continuation fringe-indicator-alist)) '(nil nil))))
  (add-hook 'writeroom-mode-disable-hook (lambda ()
                                           (display-line-numbers-mode 1)
                                           (setf (cdr (assq 'continuation fringe-indicator-alist)) '(left-curly-arrow right-curly-arrow)))))

(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode))
  :hook ((yaml-mode-hook . (lambda () (toggle-truncate-lines t)))
         (yaml-mode-hook . hs-minor-mode)))

(use-package markdown-mode
  :custom (markdown-command "multimarkdown")
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :custom-face
  (markdown-inline-code-face ((t (:family "Iosevka"))))
  (markdown-code-face ((t (:family "Iosevka")))))

;; (use-package js-mode
;;   :custom
;;   (js-indent-level 2)
;;   (js-switch-indent-offset 2)

;;   :mode (("\\.js\\'" . js-mode)
;;          ("\\.jsx\\." . js-mode)))

(setq-default treesit-language-source-alist
              '((bash "https://github.com/tree-sitter/tree-sitter-bash")
                (cmake "https://github.com/uyha/tree-sitter-cmake")
                (css "https://github.com/tree-sitter/tree-sitter-css")
                (elisp "https://github.com/Wilfred/tree-sitter-elisp")
                (go "https://github.com/tree-sitter/tree-sitter-go")
                (html "https://github.com/tree-sitter/tree-sitter-html")
                (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
                (json "https://github.com/tree-sitter/tree-sitter-json")
                (make "https://github.com/alemuller/tree-sitter-make")
                (markdown "https://github.com/ikatyang/tree-sitter-markdown")
                (python "https://github.com/tree-sitter/tree-sitter-python")
                (toml "https://github.com/tree-sitter/tree-sitter-toml")
                (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
                (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
                (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter)

(use-package typescript-mode
  :after tree-sitter

  :mode (("\\.tsx\\'" . typescriptreact-mode)
         ("\\.ts\\'" . typescript-mode))
  :interpreter ("typescript" . typescript-mode)

  :custom
  (typescript-indent-level 2)

  :config
  (define-derived-mode typescriptreact-mode typescript-mode "TypeScript TSX")
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescriptreact-mode))
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx)))

(use-package flymake
  :custom
  (flymake-fringe-indicator-position nil))

(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1))

(use-package eglot
  :hook ((typescript-mode . eglot-ensure)
         (typescriptreact-mode . eglot-ensure)
         (css-mode . eglot-ensure)))

(use-package json-mode
  :mode (("\\.json\\'" . json-mode))
  :interpreter ("json" . json-mode)
  :hook ((json-mode . (lambda () (add-hook 'before-save-hook 'json-pretty-print-buffer nil 'local)))))

(use-package elfeed
  :general (general-nmap "SPC e" 'elfeed)
  :custom
  (elfeed-feeds
   '(("https://100r.co/links/rss.xml" tech blog)
     ("http://blog.fogus.me/feed/" tech blog clojure)
     ("https://solar.lowtechmagazine.com/feeds/all-en.atom.xml" tech blog lowtech)
     ("https://sachachua.com/blog/feed/" emacs)
     ("https://protesilaos.com/master.xml" emacs tech philosophy)
     ("https://danluu.com/atom.xml" tech philosophy)
     ("https://solarpunks.net/rss" politics solarpunk))))

(use-package emacs
  :custom
  (css-indent-offset 2)
  (js-indent-level 2)
  (completion-cycle-threshold 1)
  (enable-recursive-minibuffers t)
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (completion-ignore-case t)

  :general
  (general-nmap "SPC b b" 'switch-to-buffer)
  (general-nmap "SPC b k" 'kill-current-buffer)
  (general-nmap "SPC f f" 'find-file)

  :init
  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  (setq read-extended-command-predicate
        #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package magit
  :general (general-nmap "SPC g" 'magit))

(use-package which-key
  :general (general-nmap "SPC ?" 'which-key-show-full-major-mode))

;; Open find-file minibuffer instantly instead of the default menu
(use-package project
  :general
  (general-nmap "SPC p p" 'project-switch-project)
  (general-nmap "SPC p f" 'project-find-file)

  :custom
  (project-switch-commands 'project-find-file))

(defun ya-enable-aggressive-corfu-mode ()
  "Enable agressive autocompletion corfu-mode."
  (setq-local corfu-auto nil ;; t
              corfu-auto-delay 0
              corfu-auto-prefix 2
              corfu-quit-no-match nil
              completion-styles '(basic)
              org-roam-completion-functions nil)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

(defun ya-enable-css-corfu-mode ()
  "Enable agressive autocompletion corfu-mode."
  (setq-local corfu-auto t
              corfu-auto-delay 0
              corfu-auto-prefix 1
              corfu-quit-no-match nil
              completion-styles '(basic)))

(defun ya-enable-yaml-corfu-mode ()
  "Enable agressive autocompletion corfu-mode."
  (setq-local corfu-auto nil ;; t
              corfu-auto-delay 0
              corfu-auto-prefix 1
              corfu-quit-no-match nil
              completion-styles '(basic))
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

;; @todo configure less aggressive corfu mode
(use-package corfu
  :after org

  :custom
  (corfu-cycle t)
  (corfu-preview-current nil) 

  :bind
  (:map corfu-map
        ("C-n" . corfu-next)
        ("C-S-n" . corfu-previous))

  :hook ((org-mode . ya-enable-aggressive-corfu-mode)
         (css-mode . ya-enable-css-corfu-mode)
         (yaml-mode . ya-enable-yaml-corfu-mode))

  :init
  (global-corfu-mode))

(use-package cape
  :after corfu

  :bind (("C-M-i" . completion-at-point)
         ("M-/" . cape-dabbrev))

  :custom
  (dabbrev-case-fold-search t) ;; Search regardless of the case
  (dabbrev-case-replace nil)   ;; Insert respecting the initial case

  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/Org/Tasks.org"))
 '(package-selected-packages
   '(exec-path-from-shell prettier-js cape json-mode typescript-mode consult vertico org-roam eval-in-repl ox-reveal writeroom-mode evil-indent-plus unicode-fonts visual-fill-column yaml-mode magit evil-collection which-key general evil markdown-mode use-package base16-theme))
 '(screenshot-border-width 0)
 '(screenshot-font-family "Iosevka")
 '(screenshot-font-size 20)
 '(screenshot-line-numbers-p nil)
 '(screenshot-min-width 100)
 '(screenshot-remove-indent-p nil)
 '(screenshot-shadow-offset-horizontal 0)
 '(screenshot-shadow-offset-vertical 0)
 '(screenshot-text-only-p nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
