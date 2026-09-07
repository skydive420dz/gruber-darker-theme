;;; appearance.el --- Optional X230T appearance section -*- lexical-binding: t; -*-

;; Example only: this file is not loaded by the theme.
;; Requires the existing Elpaca/use-package setup.  Replace old theme and font
;; blocks when approved; do not append this alongside another load-theme block.

;; Machine-owned fonts, as observed in the saved X230T configuration.
(set-face-attribute 'default nil
                    :font "VictorMono Nerd Font Mono" :height 100 :weight 'medium)
(set-face-attribute 'fixed-pitch nil
                    :font "VictorMono Nerd Font Mono" :height 100 :weight 'medium)
(set-face-attribute 'variable-pitch nil
                    :font "MesloLGS Nerd Font" :height 110 :weight 'medium)
(add-to-list 'default-frame-alist '(font . "VictorMono Nerd Font Mono-10"))
(setq-default line-spacing 0.12)

(use-package solaire-mode
  :ensure t
  :demand t)

(use-package gruber-darker-theme
  :ensure (:host github :repo "skydive420dz/gruber-darker-theme"
           :files (:defaults "LICENSE.doom-themes"
                   (:exclude "test-*.el" "examples")))
  :after solaire-mode
  :demand t
  :config
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'gruber-darker t)
  (solaire-global-mode 1)
  (require 'gruber-darker-bell)
  (gruber-darker-bell-mode 1)
  (with-eval-after-load 'org
    (require 'gruber-darker-org)
    (gruber-darker-org-config))
  (with-eval-after-load 'treemacs
    (require 'gruber-darker-treemacs)
    (gruber-darker-treemacs-config)))

(use-package hl-line
  :ensure nil
  :config
  (global-hl-line-mode 1))

;; Keep doom-modeline, spacious-padding, icon packages, and editor behavior
;; in their existing blocks.  Their activation is independent of this theme.
;; The optional helpers above replace the corresponding Doom helper calls.
;; Do not enable both sets of helpers in the same fresh configuration.

;;; appearance.el ends here
