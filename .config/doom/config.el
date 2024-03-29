;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq
 doom-theme 'doom-monokai-pro
 projectile-project-search-path '("~/Projects")
 display-line-numbers-type `relative
 prettier-js-args '("--double-quote")
 )

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(xterm-mouse-mode 1) ;; Enable mouse
(add-hook 'find-file-hook 'display-line-numbers-mode) ;; Display line numbers always

(map! :map evil-normal-state-map
      "<up>" #'previous-buffer
      "<down>" #'next-buffer
      "<mouse-4>" #'evil-scroll-line-up
      "<mouse-5>" #'evil-scroll-line-down
      )

(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-webkit nil
        lsp-ui-doc-delay 0.5
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'at-point
        )
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-show-diagnostics t)
  )

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t))
 )

(setq org-babel-python-command "python3")
(setq fancy-splash-image nil)

(setq ns-auto-hide-menu-bar t)
(add-to-list 'initial-frame-alist '(fullscreen . fullboth))

(set-frame-font "FantasqueSansM Nerd Font" nil t)

(custom-set-faces
'(org-level-1 ((t (:inherit outline-1 :height 1.5))))
'(org-level-2 ((t (:inherit outline-1 :height 1.4))))
'(org-level-3 ((t (:inherit outline-1 :height 1.3))))
'(org-level-2 ((t (:inherit outline-1 :height 1.2))))
 )

(defun open-my-org-file ()
  "Open my special org file."
  (interactive)
  (find-file "~/Library/Mobile Documents/com~apple~CloudDocs/notes/index.org"))

(global-set-key (kbd "C-c o") 'open-my-org-file)

(use-package org-roam
  :custom
  (org-roam-directory "~/Library/Mobile Documents/com~apple~CloudDocs/notes/")
  :bind (
         ("C-c n l" . org-roam)
         ("C-c n f" . org-roam-find-file)
         ("C-c n g" . org-roam-graph)
         )
  :config
  (org-roam-db-autosync-enable)
  )
