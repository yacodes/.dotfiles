(menu-bar-mode -1) ; Remove menubar
(toggle-scroll-bar -1) ; Remove scrollbar
(tool-bar-mode -1) ; Remove toolbar
(global-visual-line-mode) ; Wrap lines in a smart way
(setq ring-bell-function 'ignore) ; Disable beeping and flashing
(global-display-line-numbers-mode) ; Show line numbers always
(setq-default mode-line-format nil) ; Hide status line
(set-frame-font "Iosevka-18" nil t)
