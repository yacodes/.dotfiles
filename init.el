(setq gc-cons-threshold (* 50 1000 1000))

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Install use-package if not yet
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (require 'use-package-ensure)
  ;; (setq use-package-verbose t)
  (setq use-package-expand-minimally t)
  (setq use-package-always-ensure t))

;; Backup configuration
(setq-default make-backup-files nil) ; Do not make backup files
(setq-default create-lockfiles nil)  ; Do not create lockfiles

;; Coding system
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)

;; Personal information
(setq-default user-full-name "Aleksandr Yakunichev")
(setq-default user-mail-address "hi@ya.codes")

(setq-default inhibit-startup-screen t) ; Configure startup screen
;; (setq-default truncate-lines t)      ; Truncate lines
(setq-default word-wrap t)              ; Wrap words
(setq-default split-height-threshold 1) ; Windows default splitting

(setq-default tab-width 2)                              ; Set tab-width
(setq-default indent-tabs-mode nil)                     ; Disable tabs?
(defalias 'yes-or-no-p 'y-or-n-p)                       ; Map yes & no to y & n
(global-display-line-numbers-mode 1)                    ; Show line numbers
(global-hl-line-mode)                                   ; Highlight line under the cursor
(setq-default ring-bell-function 'ignore)               ; Turn off the alarm
(setq backup-directory-alist `((".*" . ,temporary-file-directory))) ; Store backups in /tmp directory
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))) ; Store autosave files in /tmp directory

(defun switch-to-previous-buffer ()
  "Switch to previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) t)))

(defun string-replace-spaces-to-non-breaking (string)
  "Replace all spaces in STRING to non-breaking ones."
  (string-replace " " " " string))

(defun string-replace-vowels-with-underline (string)
  "Replace all vowels in STRING with underlines."
  (replace-regexp-in-string "[aáeéyuúiíoó]" "_" string))

(defun string-split-by-spaces (string)
  "Split all letters in STRING by spaces."
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
(setq-default show-paren-style 'parenthesis) ; Highlighting style (parenthesis | expression | mixed)
(show-paren-mode t)                          ; Highlight matching brackets
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

(use-package elec-pair
  :defer t
  :init (electric-pair-mode t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ligature
  :config
  ;; Enable all Iosevka ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
                                       "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                                       "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                                       ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
  ;; Enables ligature checks globally in all buffers. You can also do it per mode with `ligature-mode'.
  (global-ligature-mode t))

(use-package undo-tree
  :custom
  (undo-tree-auto-save-history nil)

  :config
  (global-undo-tree-mode))

(use-package evil
  :after (undo-tree)

  :custom
  (evil-want-keybinding nil)

  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-tree)
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line))

(use-package evil-collection
  :after (evil)
  :config
  (evil-collection-init))

;; @todo move the keys to 'use-package' calls
(use-package general
  :after (evil)

  :config
  (general-evil-setup t)
  (general-auto-unbind-keys)
  
  (general-define-key
   :states 'normal
   :keymaps 'override
   :prefix "SPC"
   :non-normal-prefix "SPC"
   "t" 'toggle-truncate-lines
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
    "i" 'insert-file)

  (nmap
    :keymaps 'emacs-lisp-mode-map
    "RET" 'eir-eval-in-ielm)

  (nmap
    :keymaps 'org-mode-map
    "t" 'org-todo
    "RET" 'org-open-at-point)

  (nmap
    :keymaps 'org-mode-map
    :prefix ","
    "a" 'org-archive-subtree-default
    "^" 'org-sort
    "l" 'org-insert-link
    "o" 'org-open-at-point
    "r r" 'org-reveal-export-to-html
    "r b" 'org-reveal-export-to-html-and-browse))

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
  (set-face-attribute 'default nil :family "Iosevka" :height 178))

(use-package visual-fill-column
  :defer t
  :custom
  (visual-fill-column-width 90)
  (fill-column 90)
  (comment-column 90))

(use-package writeroom-mode
  :general
  (general-nmap "SPC c" 'writeroom-mode)

  :custom
  (writeroom-width 80)

  :config
  (add-hook 'writeroom-mode-enable-hook (lambda ()
                                          (display-line-numbers-mode -1)
                                          (setf (cdr (assq 'continuation fringe-indicator-alist)) '(nil nil))))
  (add-hook 'writeroom-mode-disable-hook (lambda ()
                                           (display-line-numbers-mode 1)
                                           (setf (cdr (assq 'continuation fringe-indicator-alist)) '(left-curly-arrow right-curly-arrow)))))

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
     ("\\.x?html?\\'" . "librewolf %s")
     ("\\.pdf\\(::[0-9]+\\)?\\'" . "librewolf %s")
     ("\\.mp4\\'" . "vlc \"%s\"")
     ("\\.mkv" . "vlc \"%s\"")))

  :custom
  ;; Project management
  (org-directory "~/Org/")
  (org-agenda-files (list "~/Org/Tasks.org"))
  (org-log-done 'time)
  (org-tags-column -77)
  (org-startup-folded t)
  (org-hide-leading-stars t)
  (org-hide-emphasis-markers t)
  (org-archive-reversed-order t)
  (org-ellipsis "…")

  ;; HTML export configuration
  (org-html-doctype "html5")
  (org-html-html5-fancy t)

  :config
  (add-to-list 'org-link-frame-setup '(file . find-file))
  (add-hook 'org-mode-hook #'(lambda () (toggle-truncate-lines nil)))
  (add-hook 'org-mode-hook #'visual-fill-column-mode)
  (add-hook 'org-mode-hook #'writeroom-mode)
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
  :after (org)

  :custom
  (org-roam-directory (file-truename "~/Org/Roam/"))
  (org-roam-completion-everywhere t)

  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture))

  :config
  (org-roam-db-autosync-mode))

;; (use-package ox-reveal
;;   :after (org))

;; Matches parens
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %.
ARG: I do not know what this is."
  (interactive "p")
  (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; Wrap isearch
(defadvice isearch-repeat (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-repeat 'after 'isearch-no-fail)
    (ad-activate 'isearch-repeat)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-repeat 'after 'isearch-no-fail)
    (ad-activate 'isearch-repeat)))

(setq-default initial-buffer-choice "~/Org/Tasks.org")

;; Remove UI elements
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
  :after (vertico)
  :ensure nil
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word)))

(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))

  :init
  (marginalia-mode))

(use-package consult
  :general
  (general-nmap "SPC / /" 'consult-git-grep)
  (general-nmap "SPC / f" 'consult-flymake)

  :custom
  (register-preview-delay 0)
  (register-preview-function #'consult-register-format)

  :init
  (advice-add #'register-preview :override #'consult-register-window))

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

(use-package markdown-mode
  :custom (markdown-command "multimarkdown")
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :custom-face
  (markdown-inline-code-face ((t (:family "Iosevka"))))
  (markdown-code-face ((t (:family "Iosevka")))))

(use-package flymake
  :custom
  (flymake-fringe-indicator-position nil)
  (flymake-indicator-type nil))

(use-package apheleia
  :config
  (apheleia-global-mode +1))

(use-package eglot
  :hook (
         ;; (typescript-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)
         (css-mode . eglot-ensure)
         ))

(use-package elfeed
  :general
  (general-nmap "SPC e" 'elfeed)

  :custom
  (shr-use-fonts nil) ; Fixes selecting monospace font for elfeed articles.

  (elfeed-feeds
   '(("https://100r.co/links/rss.xml" art)
     ("https://pluralistic.net/feed/" politics)
     ("http://blog.fogus.me/feed/" clojure)
     ("https://evanp.me/rss" fediverse)
     ("https://jvns.ca/atom.xml")
     ("https://silly.business/index.xml" emacs)
     ("https://buttondown.com/perfectsentences/rss")
     ("https://andregarzia.com/feeds/all.atom.xml" foss)
     ("https://technomancy.us/atom.xml" scheme)
     ("https://solar.lowtechmagazine.com/posts/index.xml" art)
     ("https://sachachua.com/blog/feed/" emacs)
     ("https://protesilaos.com/master.xml" emacs philosophy)
     ("https://www.geoffreylitt.com/feed.xml" foss)
     ("https://danluu.com/atom.xml" philosophy)
     ("https://alexschroeder.ch/view/index.rss" foss emacs)
     ("https://emacsredux.com/atom.xml" foss emacs)
     ("https://indieweb.org/this-week/feed.xml" foss)
     ("https://sizeof.cat/atom.xml" foss)
     ("https://dthompson.us/feed.xml" scheme)
     ("https://www.fosskers.ca/en/rss" linux emacs lisp)
     ("https://www.donostitik.com/rss" euskadi castellano)
     ("https://systemcrafters.net/rss/news.xml" foss linux scheme emacs)
     ("https://axolot.cat/rss" toplap)
     ("https://monthlyreview.org/rss" politics socialism)
     ("https://thebaffler.com/rss" politics)
     ("https://aartaka.me/rss.xml" linux scheme))))

(use-package emacs
  :mode (("\\.tsx\\'" . tsx-ts-mode)
         ("\\.jsx\\'" . tsx-ts-mode)
         ("\\.ts\\'"  . typescript-ts-mode)
         ("\\.js\\'"  . typescript-ts-mode)
         ("\\.mjs\\'" . typescript-ts-mode)

         ("\\.json\\'" .  json-ts-mode)
         ("\\.yml\\'" . yaml-ts-mode)

         ("\\.yuck\\'" . scheme-mode))

  :custom
  (css-indent-offset 2)
  (js-indent-level 2)
  (completion-cycle-threshold 1)
  (enable-recursive-minibuffers t)
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (completion-ignore-case t)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  (read-extended-command-predicate #'command-completion-default-include-p)

  ;; Never save auth data.
  (auth-source-save-behavior nil)

  ;; Remap major modes to the treesit ones.
  (major-mode-remap-alist
   '((css-mode . css-ts-mode)
     (typescript-mode . typescript-ts-mode)
     (js-mode . typescript-ts-mode)
     (js2-mode . typescript-ts-mode)
     (bash-mode . bash-ts-mode)
     (css-mode . css-ts-mode)
     (json-mode . json-ts-mode)
     (js-json-mode . json-ts-mode)
     (yaml-mode . yaml-ts-mode)
     (sh-mode . bash-ts-mode)))

  ;; Maximize tree-sitter decorations 
  (treesit-font-lock-level 4)

  :general
  (general-nmap "SPC b b" 'switch-to-buffer)
  (general-nmap "SPC b k" 'kill-current-buffer)
  (general-nmap "SPC f f" 'find-file)

  :init
  (setq treesit-language-source-alist
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
          (yaml "https://github.com/ikatyang/tree-sitter-yaml"))))

;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))

(use-package magit
  :general (general-nmap "SPC g" 'magit))

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

  :hook ((org-mode . ya-enable-aggressive-corfu-mode)
         (css-ts-mode . ya-enable-css-corfu-mode)
         (yaml-ts-mode . ya-enable-yaml-corfu-mode))

  :init
  (global-corfu-mode))

(use-package cape
  :after (corfu)

  :bind (("C-M-i" . completion-at-point)
         ("M-/" . cape-dabbrev))

  :custom
  (dabbrev-case-fold-search t) ;; Search regardless of the case
  (dabbrev-case-replace nil)   ;; Insert respecting the initial case

  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

(use-package jinx
  :general
  (general-nmap "SPC j t" 'jinx-mode)
  (general-nmap "SPC j j" 'jinx-correct))

(setq gc-cons-threshold (* 2 1000 1000))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(apheleia base16-theme cape consult corfu dracula-theme elfeed evil-collection general
              jinx ligature magit marginalia markdown-mode nano-theme orderless org-roam
              rainbow-delimiters typescript-mode undo-tree vertico writeroom-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-ellipsis ((t :foreground unspecified))))
