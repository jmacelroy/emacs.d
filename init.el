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
(scroll-bar-mode -1)
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
(require 'whitespace)
(setq whitespace-style '(tabs tab-mark))
(global-whitespace-mode t)

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
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
        helm-mode-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-locate-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-completion-in-region-fuzzy-match t
        helm-candidate-number-list 150
        helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t
        helm-echo-input-in-header-line t
        helm-autoresize-max-height 0
        helm-autoresize-min-height 20)
  :config
  (helm-mode 1))

;; Font and Frame Size
;;(add-to-list 'default-frame-alist '(font . "mononoki-12"))
;;(add-to-list 'default-frame-alist '(height . 24))
;;(add-to-list 'default-frame-alist '(width . 80))

;; Theme
(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t))

;; flycheck
(use-package flycheck :ensure t)
(use-package flycheck-gometalinter :ensure t)

;; go lang setup
(use-package go-mode :ensure t)
(use-package go-autocomplete :ensure t)

(setenv "GOPATH" "/home/jdm")
(add-to-list 'exec-path "/home/jdm/go/bin")

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
  (require 'go-autocomplete))

(setq flycheck-gometalinter-vendor t)
(setq flycheck-gometalinter-disable-all t)
(setq flycheck-gometalinter-enable-linters '("vet", "goimports", "vetshadow", "ineffassign", "golint", "inefassign", "goconst"))

(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark))
(add-hook 'go-mode-hook 'my-go-mode-hook)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (monokai use-package neotree magit helm doom-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
