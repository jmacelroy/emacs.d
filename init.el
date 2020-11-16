(setq inhibit-startup-message t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Package configuration
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap use-package https://github.com/jwiegley/use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Write backup files to their own directory.
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Minimal UI
;; (scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

;; Change alt-x to c-x c-m
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; keyboard shortcuts
(global-set-key (kbd "<f1>") 'goto-line)
(global-set-key (kbd "<f2>") 'font-lock-mode)
(global-set-key (kbd "<f3>") 'comment-box)
(global-set-key (kbd "<f4>") 'delete-trailing-whitespace)
(global-set-key (kbd "<f12>") 'comment-region)
(global-set-key (kbd "<f11>") 'uncomment-region)
(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; show whitespace configured to show tabs.
;; (require 'whitespace)
;; (setq whitespace-style '(tabs tab-mark))
;; (global-whitespace-mode t)

;; Enable ido mode
(require 'ido)
(ido-mode t)

;; Enable electric pair mode
(electric-pair-mode +1)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Never insert tabs
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)

;; NeoTree
(use-package neotree
  :ensure t
  :bind (([f8] . neotree-toggle))
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))


;; Magit
(use-package magit
  :ensure t
  :bind
  (("C-x g" . magit-status)
   ("C-x M-g" . magit-dispatch-popup)))


;; Helm
;; (use-package helm
;;   :ensure t
;;   :init
;;   (setq helm-M-x-fuzzy-match t
;;         helm-mode-fuzzy-match t
;;         helm-buffers-fuzzy-matching t
;;         helm-recentf-fuzzy-match t
;;         helm-locate-fuzzy-match t
;;         helm-semantic-fuzzy-match t
;;         helm-imenu-fuzzy-match t
;;         helm-completion-in-region-fuzzy-match t
;;         helm-candidate-number-list 150
;;         helm-split-window-in-side-p t
;;         helm-move-to-line-cycle-in-source t
;;         helm-echo-input-in-header-line t
;;         helm-autoresize-max-height 0
;;         helm-autoresize-min-height 20)
;;   :config
;;   (helm-mode 1))

;; Font and Frame Size
(add-to-list 'default-frame-alist '(font . "mononoki-12"))
(add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(width . 80))

;; Theme
(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t))

;; Go support
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :ensure t
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(defun my-go-setup ()
  (setq tab-width 4))

(add-hook 'go-mode-hook 'my-go-setup)
