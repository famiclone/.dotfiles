(setq custom-file "~/.emacs.custom.el")
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Використовувати straight з use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'general)
  (package-refresh-contents)
  (package-install 'general))

(require 'general)

(load-theme 'gruvbox-light-soft t)

(setq inhibit-startup-message t)
(add-to-list 'default-frame-alist `(font . "FantasqueSansM Nerd Font-13"))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(general-define-key
 :states '(normal visual)
 :prefix "SPC"
 "o" '(lambda () (interactive) (find-file "~/Notes/index.org")))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'hl-line-mode)

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-project-root-files '(".git" "package.json" "tsconfig.json"))
  (setq projectile-enable-caching t)
)

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :hook (prog-mode . copilot-mode)
  :ensure t)

(define-key evil-insert-state-map (kbd "C-j") 'copilot-accept-completion) ;; Прийняти пропозицію
(define-key evil-insert-state-map (kbd "C-k") 'copilot-next-completion)  ;; Наступна пропозиція
(define-key evil-insert-state-map (kbd "C-c C-c") 'copilot-clear-overlay)   ;; Скасувати пропозицію

(define-key evil-normal-state-map (kbd "<up>") 'previous-buffer)
(define-key evil-normal-state-map (kbd "<down>") 'next-buffer)

;; Org mode
(unless (package-installed-p 'org)
  (package-install 'org))

(unless (package-installed-p 'org-roam-ui)
  (package-refresh-contents)
  (package-install 'org-roam-ui))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/Notes/")
  :bind (("C-c n l" . org-roam-buffer-toggle)
	("C-c n f" . org-roam-node-find)
	("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup)
)
	 
(setq org-startup-indented t)
(setq org-hide-leading-stars t)

(org-roam-db-autosync-mode)

(custom-set-faces
 '(org-default ((t (:family "SF Pro" :height 1.0))))
 '(org-level-1 ((t (:inherit default :weight bold :height 1.5))))
 '(org-level-2 ((t (:inherit default :weight bold :height 1.3))))
 '(org-level-3 ((t (:inherit default :weight bold :height 1.2))))
 '(org-level-4 ((t (:inherit default :weight bold :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :height 1.0))))
 '(org-level-6 ((t (:inherit default :weight bold :height 1.0))))
 '(org-level-7 ((t (:inherit default :weight bold :height 1.0))))
 '(org-level-8 ((t (:inherit default :weight bold :height 1.0)))))

;; Create new org file without timestamp in the filename
(setq org-roam-capture-templates
      '(("n" "no-timestamp" plain "%?"
         :target (file+head "${slug}.org" "#+title: ${title}\n")
         :unnarrowed t)))

(defun my-org-mode-font-setup ()
  ;; Використовуємо buffer-face-mode для зміни шрифту в поточному буфері
  (setq buffer-face-mode-face '(:family "SF Pro" :height 140))
  (buffer-face-mode 1))

(add-hook 'org-mode-hook 'my-org-mode-font-setup)
(setq org-enforce-todo-dependencies t)
(add-hook 'org-mode-hook 'visual-line-mode); wrap lines

;; Keybindings
