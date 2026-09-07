;;; gruber-darker-theme.el --- Gruber Darker color theme -*- lexical-binding: t; -*-

;; Copyright (C) 2013-2016 Alexey Kutepov a.k.a rexim
;; Copyright (C) 2009-2010 Jason R. Blevins

;; Author: Alexey Kutepov <reximkut@gmail.com>
;; URL: https://github.com/skydive420dz/gruber-darker-theme
;; Version: 0.8.0
;; Package-Requires: ((emacs "27.1"))

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:
;;
;; Gruber Darker color theme for Emacs by Jason Blevins. A darker
;; variant of the Gruber Dark theme for BBEdit by John Gruber. Adapted
;; for deftheme and extended by Alexey Kutepov a.k.a. rexim.


;;; Code:

(deftheme gruber-darker
  "Gruber Darker color theme")

;; Colors with +x are lighter. Colors with -x are darker.
(let ((gruber-darker-fg        "#e4e4ef")
      (gruber-darker-fg+1      "#f4f4ff")
      (gruber-darker-fg+2      "#f5f5f5")
      (gruber-darker-white     "#ffffff")
      (gruber-darker-black     "#000000")
      (gruber-darker-bg-1      "#101010")
      (gruber-darker-bg        "#181818")
      (gruber-darker-bg+1      "#282828")
      (gruber-darker-bg+2      "#453d41")
      (gruber-darker-bg+3      "#484848")
      (gruber-darker-bg+4      "#52494e")
      (gruber-darker-line       "#303e48")
      (gruber-darker-selection  "#40586b")
      (gruber-darker-red-1     "#c73c3f")
      (gruber-darker-red       "#f43841")
      (gruber-darker-red+1     "#ff4f58")
      (gruber-darker-green     "#73c936")
      (gruber-darker-yellow    "#ffdd33")
      (gruber-darker-brown     "#cc8c3c")
      (gruber-darker-quartz    "#95a99f")
      (gruber-darker-niagara-2 "#303540")
      (gruber-darker-niagara-1 "#565f73")
      (gruber-darker-niagara   "#96a6c8")
      (gruber-darker-wisteria  "#9e95c7")
      )
  (custom-theme-set-variables
   'gruber-darker
   '(frame-background-mode (quote dark)))

  (custom-theme-set-faces
   'gruber-darker

   ;; Agda2
   `(agda2-highlight-datatype-face ((t (:foreground ,gruber-darker-quartz))))
   `(agda2-highlight-primitive-type-face ((t (:foreground ,gruber-darker-quartz))))
   `(agda2-highlight-function-face ((t (:foreground ,gruber-darker-niagara))))
   `(agda2-highlight-keyword-face ((t ,(list :foreground gruber-darker-yellow
                                             :bold t))))
   `(agda2-highlight-inductive-constructor-face ((t (:foreground ,gruber-darker-green))))
   `(agda2-highlight-number-face ((t (:foreground ,gruber-darker-wisteria))))

   ;; AUCTeX
   `(font-latex-bold-face ((t (:foreground ,gruber-darker-quartz :bold t))))
   `(font-latex-italic-face ((t (:foreground ,gruber-darker-quartz :italic t))))
   `(font-latex-math-face ((t (:foreground ,gruber-darker-green))))
   `(font-latex-sectioning-5-face ((t ,(list :foreground gruber-darker-niagara
                                             :bold t))))
   `(font-latex-slide-title-face ((t (:foreground ,gruber-darker-niagara))))
   `(font-latex-string-face ((t (:foreground ,gruber-darker-green))))
   `(font-latex-warning-face ((t (:foreground ,gruber-darker-red))))

   ;; Basic Coloring (or Uncategorized)
   `(border ((t ,(list :background gruber-darker-bg-1
                       :foreground gruber-darker-bg+2))))
   `(cursor ((t (:background ,gruber-darker-yellow))))
   `(default ((t ,(list :foreground gruber-darker-fg
                        :background gruber-darker-bg))))
   `(fringe ((t ,(list :background nil
                       :foreground gruber-darker-bg+2))))
   `(vertical-border ((t ,(list :foreground gruber-darker-bg+2))))
   `(link ((t (:foreground ,gruber-darker-niagara :underline t))))
   `(link-visited ((t (:foreground ,gruber-darker-wisteria :underline t))))
   `(shadow ((t (:foreground ,gruber-darker-niagara-1))))
   `(minibuffer-prompt ((t (:foreground ,gruber-darker-niagara))))
   `(region ((t (:background ,gruber-darker-bg+3 :foreground nil))))
   `(secondary-selection ((t ,(list :background gruber-darker-bg+3
                                    :foreground nil))))
   `(trailing-whitespace ((t ,(list :foreground gruber-darker-black
                                    :background gruber-darker-red))))
   `(tooltip ((t ,(list :background gruber-darker-bg+4
                        :foreground gruber-darker-white))))

   ;; Calendar
   `(holiday-face ((t (:foreground ,gruber-darker-red))))

   ;; Compilation
   `(compilation-info ((t ,(list :foreground gruber-darker-green
                                 :inherit 'unspecified))))
   `(compilation-warning ((t ,(list :foreground gruber-darker-brown
                                    :bold t
                                    :inherit 'unspecified))))
   `(compilation-error ((t (:foreground ,gruber-darker-red+1))))
   `(compilation-mode-line-fail ((t ,(list :foreground gruber-darker-red
                                           :weight 'bold
                                           :inherit 'unspecified))))
   `(compilation-mode-line-exit ((t ,(list :foreground gruber-darker-green
                                           :weight 'bold
                                           :inherit 'unspecified))))

   ;; Completion
   `(completions-annotations ((t (:inherit shadow))))

   ;; Custom
   `(custom-state ((t (:foreground ,gruber-darker-green))))

   ;; Diff
   `(diff-removed ((t ,(list :foreground gruber-darker-red+1
                             :background nil))))
   `(diff-added ((t ,(list :foreground gruber-darker-green
                           :background nil))))

   ;; Dired
   `(dired-directory ((t (:foreground ,gruber-darker-niagara :weight bold))))
   `(dired-ignored ((t ,(list :foreground gruber-darker-quartz
                              :inherit 'unspecified))))

   ;; Ebrowse
   `(ebrowse-root-class ((t (:foreground ,gruber-darker-niagara :weight bold))))
   `(ebrowse-progress ((t (:background ,gruber-darker-niagara))))

   ;; Egg
   `(egg-branch ((t (:foreground ,gruber-darker-yellow))))
   `(egg-branch-mono ((t (:foreground ,gruber-darker-yellow))))
   `(egg-diff-add ((t (:foreground ,gruber-darker-green))))
   `(egg-diff-del ((t (:foreground ,gruber-darker-red))))
   `(egg-diff-file-header ((t (:foreground ,gruber-darker-wisteria))))
   `(egg-help-header-1 ((t (:foreground ,gruber-darker-yellow))))
   `(egg-help-header-2 ((t (:foreground ,gruber-darker-niagara))))
   `(egg-log-HEAD-name ((t (:box (:color ,gruber-darker-fg)))))
   `(egg-reflog-mono ((t (:foreground ,gruber-darker-niagara-1))))
   `(egg-section-title ((t (:foreground ,gruber-darker-yellow))))
   `(egg-text-base ((t (:foreground ,gruber-darker-fg))))
   `(egg-term ((t (:foreground ,gruber-darker-yellow))))

   ;; ERC
   `(erc-notice-face ((t (:foreground ,gruber-darker-wisteria))))
   `(erc-timestamp-face ((t (:foreground ,gruber-darker-green))))
   `(erc-input-face ((t (:foreground ,gruber-darker-red+1))))
   `(erc-my-nick-face ((t (:foreground ,gruber-darker-red+1))))

   ;; EShell
   `(eshell-ls-backup ((t (:foreground ,gruber-darker-quartz))))
   `(eshell-ls-directory ((t (:foreground ,gruber-darker-niagara))))
   `(eshell-ls-executable ((t (:foreground ,gruber-darker-green))))
   `(eshell-ls-symlink ((t (:foreground ,gruber-darker-yellow))))

   ;; Font Lock
   `(font-lock-builtin-face ((t (:foreground ,gruber-darker-yellow))))
   `(font-lock-comment-face ((t (:foreground ,gruber-darker-brown :slant italic))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,gruber-darker-brown :slant italic))))
   `(font-lock-constant-face ((t (:foreground ,gruber-darker-quartz))))
   `(font-lock-doc-face ((t (:foreground ,gruber-darker-green))))
   `(font-lock-doc-string-face ((t (:foreground ,gruber-darker-green))))
   `(font-lock-function-name-face ((t (:foreground ,gruber-darker-niagara))))
   `(font-lock-keyword-face ((t (:foreground ,gruber-darker-yellow :bold t :slant italic))))
   `(font-lock-preprocessor-face ((t (:foreground ,gruber-darker-quartz))))
   `(font-lock-reference-face ((t (:foreground ,gruber-darker-quartz))))
   `(font-lock-string-face ((t (:foreground ,gruber-darker-green))))
   `(font-lock-type-face ((t (:foreground ,gruber-darker-quartz))))
   `(font-lock-variable-name-face ((t (:foreground ,gruber-darker-fg+1))))
   `(font-lock-warning-face ((t (:foreground ,gruber-darker-red))))

   ;; Flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-darker-red)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:foreground ,gruber-darker-red :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-darker-yellow)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:foreground ,gruber-darker-yellow :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-darker-green)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:foreground ,gruber-darker-green :weight bold :underline t))))

   ;; Flyspell
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-darker-red) :inherit unspecified))
      (t (:foreground ,gruber-darker-red :weight bold :underline t))))
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-darker-yellow) :inherit unspecified))
      (t (:foreground ,gruber-darker-yellow :weight bold :underline t))))

   ;; Helm
   `(helm-candidate-number ((t ,(list :background gruber-darker-bg+2
                                      :foreground gruber-darker-yellow
                                      :bold t))))
   `(helm-ff-directory ((t ,(list :foreground gruber-darker-niagara
                                  :background gruber-darker-bg
                                  :bold t))))
   `(helm-ff-executable ((t (:foreground ,gruber-darker-green))))
   `(helm-ff-file ((t (:foreground ,gruber-darker-fg :inherit unspecified))))
   `(helm-ff-invalid-symlink ((t ,(list :foreground gruber-darker-bg
                                        :background gruber-darker-red))))
   `(helm-ff-symlink ((t (:foreground ,gruber-darker-yellow :bold t))))
   `(helm-selection-line ((t (:background ,gruber-darker-bg+1))))
   `(helm-selection ((t (:background ,gruber-darker-bg+1 :underline nil))))
   `(helm-source-header ((t ,(list :foreground gruber-darker-yellow
                                   :background gruber-darker-bg
                                   :box (list :line-width -1
                                              :style 'released-button)))))

   ;; Ido
   `(ido-first-match ((t (:foreground ,gruber-darker-yellow :bold nil))))
   `(ido-only-match ((t (:foreground ,gruber-darker-brown :weight bold))))
   `(ido-subdir ((t (:foreground ,gruber-darker-niagara :weight bold))))

   ;; Info
   `(info-xref ((t (:foreground ,gruber-darker-niagara))))
   `(info-visited ((t (:foreground ,gruber-darker-wisteria))))

   ;; Jabber
   `(jabber-chat-prompt-foreign ((t ,(list :foreground gruber-darker-quartz
                                           :bold nil))))
   `(jabber-chat-prompt-local ((t (:foreground ,gruber-darker-yellow))))
   `(jabber-chat-prompt-system ((t (:foreground ,gruber-darker-green))))
   `(jabber-rare-time-face ((t (:foreground ,gruber-darker-green))))
   `(jabber-roster-user-online ((t (:foreground ,gruber-darker-green))))
   `(jabber-activity-face ((t (:foreground ,gruber-darker-red))))
   `(jabber-activity-personal-face ((t (:foreground ,gruber-darker-yellow :bold t))))

   ;; Line Highlighting
   `(highlight ((t (:background ,gruber-darker-bg+1 :foreground nil))))
   `(highlight-current-line-face ((t ,(list :background gruber-darker-bg+1
                                            :foreground nil))))

   ;; line numbers
   `(line-number ((t (:inherit default :foreground ,gruber-darker-bg+4))))
   `(line-number-current-line ((t (:inherit line-number :foreground ,gruber-darker-yellow))))

   ;; Linum
   `(linum ((t (:foreground ,gruber-darker-quartz
                :background ,gruber-darker-bg))))

   ;; Magit
   `(magit-branch ((t (:foreground ,gruber-darker-niagara))))
   `(magit-diff-hunk-header ((t (:background ,gruber-darker-bg+2))))
   `(magit-diff-file-header ((t (:background ,gruber-darker-bg+4))))
   `(magit-log-sha1 ((t (:foreground ,gruber-darker-red+1))))
   `(magit-log-author ((t (:foreground ,gruber-darker-brown))))
   `(magit-log-head-label-remote ((t ,(list :foreground gruber-darker-green
                                            :background gruber-darker-bg+1))))
   `(magit-log-head-label-local ((t ,(list :foreground gruber-darker-niagara
                                           :background gruber-darker-bg+1))))
   `(magit-log-head-label-tags ((t ,(list :foreground gruber-darker-yellow
                                          :background gruber-darker-bg+1))))
   `(magit-log-head-label-head ((t ,(list :foreground gruber-darker-fg
                                          :background gruber-darker-bg+1))))
   `(magit-item-highlight ((t (:background ,gruber-darker-bg+1))))
   `(magit-tag ((t ,(list :foreground gruber-darker-yellow
                          :background gruber-darker-bg))))
   `(magit-blame-heading ((t ,(list :background gruber-darker-bg+1
                                    :foreground gruber-darker-fg))))

   ;; Message
   `(message-header-name ((t (:foreground ,gruber-darker-green))))

   ;; Mode Line
   `(mode-line ((t ,(list :background gruber-darker-bg+1
                          :foreground gruber-darker-white))))
   `(mode-line-buffer-id ((t ,(list :background gruber-darker-bg+1
                                    :foreground gruber-darker-white))))
   `(mode-line-inactive ((t ,(list :background gruber-darker-bg+1
                                   :foreground gruber-darker-quartz))))

   ;; Neo Dir
   `(neo-dir-link-face ((t (:foreground ,gruber-darker-niagara))))

   ;; Org Mode
   `(org-agenda-structure ((t (:foreground ,gruber-darker-niagara))))
   `(org-column ((t (:background ,gruber-darker-bg-1))))
   `(org-column-title ((t (:background ,gruber-darker-bg-1 :underline t :weight bold))))
   `(org-done ((t (:foreground ,gruber-darker-green))))
   `(org-todo ((t (:foreground ,gruber-darker-red-1))))
   `(org-upcoming-deadline ((t (:foreground ,gruber-darker-yellow))))

   ;; Search
   `(isearch ((t ,(list :foreground gruber-darker-black
                        :background gruber-darker-fg+2))))
   `(isearch-fail ((t ,(list :foreground gruber-darker-black
                             :background gruber-darker-red))))
   `(isearch-lazy-highlight-face ((t ,(list
                                       :foreground gruber-darker-fg+1
                                       :background gruber-darker-niagara-1))))

   ;; Sh
   `(sh-quoted-exec ((t (:foreground ,gruber-darker-red+1))))

   ;; Show Paren
   `(show-paren-match-face ((t (:background ,gruber-darker-bg+4))))
   `(show-paren-mismatch-face ((t (:background ,gruber-darker-red-1))))

   ;; Slime
   `(slime-repl-inputed-output-face ((t (:foreground ,gruber-darker-red))))

   ;; Tuareg
   `(tuareg-font-lock-governing-face ((t (:foreground ,gruber-darker-yellow))))

   ;; Speedbar
   `(speedbar-directory-face ((t ,(list :foreground gruber-darker-niagara
                                        :weight 'bold))))
   `(speedbar-file-face ((t (:foreground ,gruber-darker-fg))))
   `(speedbar-highlight-face ((t (:background ,gruber-darker-bg+1))))
   `(speedbar-selected-face ((t (:foreground ,gruber-darker-red))))
   `(speedbar-tag-face ((t (:foreground ,gruber-darker-yellow))))

   ;; Which Function
   `(which-func ((t (:foreground ,gruber-darker-wisteria))))

   ;; Whitespace
   `(whitespace-space ((t ,(list :background gruber-darker-bg
                                 :foreground gruber-darker-bg+1))))
   `(whitespace-tab ((t ,(list :background gruber-darker-bg
                               :foreground gruber-darker-bg+1))))
   `(whitespace-hspace ((t ,(list :background gruber-darker-bg
                                  :foreground gruber-darker-bg+2))))
   `(whitespace-line ((t ,(list :background gruber-darker-bg+2
                                :foreground gruber-darker-red+1))))
   `(whitespace-newline ((t ,(list :background gruber-darker-bg
                                   :foreground gruber-darker-bg+2))))
   `(whitespace-trailing ((t ,(list :background gruber-darker-red
                                    :foreground gruber-darker-red))))
   `(whitespace-empty ((t ,(list :background gruber-darker-yellow
                                 :foreground gruber-darker-yellow))))
   `(whitespace-indentation ((t ,(list :background gruber-darker-yellow
                                       :foreground gruber-darker-red))))
   `(whitespace-space-after-tab ((t ,(list :background gruber-darker-yellow
                                           :foreground gruber-darker-yellow))))
   `(whitespace-space-before-tab ((t ,(list :background gruber-darker-brown
                                            :foreground gruber-darker-brown))))

   ;; tab-bar
   `(tab-bar ((t (:background ,gruber-darker-bg+1 :foreground ,gruber-darker-bg+4))))
   `(tab-bar-tab ((t (:background nil :foreground ,gruber-darker-yellow :weight bold))))
   `(tab-bar-tab-inactive ((t (:background nil))))

   ;; vterm / ansi-term
   `(term-color-black ((t (:foreground ,gruber-darker-bg+3 :background ,gruber-darker-bg+4))))
   `(term-color-red ((t (:foreground ,gruber-darker-red-1 :background ,gruber-darker-red-1))))
   `(term-color-green ((t (:foreground ,gruber-darker-green :background ,gruber-darker-green))))
   `(term-color-blue ((t (:foreground ,gruber-darker-niagara :background ,gruber-darker-niagara))))
   `(term-color-yellow ((t (:foreground ,gruber-darker-yellow :background ,gruber-darker-yellow))))
   `(term-color-magenta ((t (:foreground ,gruber-darker-wisteria :background ,gruber-darker-wisteria))))
   `(term-color-cyan ((t (:foreground ,gruber-darker-quartz :background ,gruber-darker-quartz))))
   `(term-color-white ((t (:foreground ,gruber-darker-fg :background ,gruber-darker-white))))

   ;; company-mode
   `(company-tooltip ((t (:foreground ,gruber-darker-fg :background ,gruber-darker-bg+1))))
   `(company-tooltip-annotation ((t (:foreground ,gruber-darker-brown :background ,gruber-darker-bg+1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,gruber-darker-brown :background ,gruber-darker-bg-1))))
   `(company-tooltip-selection ((t (:foreground ,gruber-darker-fg :background ,gruber-darker-bg-1))))
   `(company-tooltip-mouse ((t (:background ,gruber-darker-bg-1))))
   `(company-tooltip-common ((t (:foreground ,gruber-darker-green))))
   `(company-tooltip-common-selection ((t (:foreground ,gruber-darker-green))))
   `(company-scrollbar-fg ((t (:background ,gruber-darker-bg-1))))
   `(company-scrollbar-bg ((t (:background ,gruber-darker-bg+2))))
   `(company-preview ((t (:background ,gruber-darker-green))))
   `(company-preview-common ((t (:foreground ,gruber-darker-green :background ,gruber-darker-bg-1))))

   ;; Proof General
   `(proof-locked-face ((t (:background ,gruber-darker-niagara-2))))

   ;; Current line and completion
   `(hl-line ((t (:background ,gruber-darker-line :extend t))))
   `(vertico-current ((t (:background ,gruber-darker-selection :foreground ,gruber-darker-white :extend t))))
   `(corfu-default ((t (:background ,gruber-darker-bg-1 :foreground ,gruber-darker-fg))))
   `(corfu-current ((t (:inherit vertico-current))))
   `(corfu-border ((t (:background ,gruber-darker-bg+2))))
   `(corfu-bar ((t (:background ,gruber-darker-niagara-1))))
   `(completions-common-part ((t (:foreground ,gruber-darker-yellow :weight bold))))
   `(completions-first-difference ((t (:foreground ,gruber-darker-green))))

   ;; Optional helper faces.
   `(gruber-darker-visual-bell ((t (:inherit error))))
   `(gruber-darker-treemacs-root-face ((t (:foreground ,gruber-darker-yellow))))
   `(gruber-darker-treemacs-file-face ((t (:foreground ,gruber-darker-quartz :slant normal))))
   `(gruber-darker-org-at-tag ((t (:foreground ,gruber-darker-niagara))))
   `(gruber-darker-org-hash-tag ((t (:foreground ,gruber-darker-yellow))))

   ;; Solaire (native support, no face swapping required)
   `(solaire-default-face ((t (:inherit default :background ,gruber-darker-bg-1))))
   `(solaire-fringe-face ((t (:inherit solaire-default-face))))
   `(solaire-line-number-face ((t (:inherit line-number :background ,gruber-darker-bg-1))))
   `(solaire-hl-line-face ((t (:inherit hl-line :background ,gruber-darker-line :extend t))))
   `(solaire-org-hide-face ((t (:foreground ,gruber-darker-bg-1))))
   `(solaire-region-face ((t (:inherit region))))

   ;; Markdown
   `(markdown-header-face ((t (:foreground ,gruber-darker-yellow :weight bold))))
   `(markdown-header-face-1 ((t (:inherit markdown-header-face))))
   `(markdown-header-face-2 ((t (:inherit markdown-header-face :foreground ,gruber-darker-niagara))))
   `(markdown-header-face-3 ((t (:inherit markdown-header-face :foreground ,gruber-darker-green))))
   `(markdown-header-face-4 ((t (:inherit markdown-header-face :foreground ,gruber-darker-wisteria))))
   `(markdown-header-face-5 ((t (:inherit markdown-header-face :foreground ,gruber-darker-quartz))))
   `(markdown-header-face-6 ((t (:inherit markdown-header-face :foreground ,gruber-darker-brown))))
   `(markdown-markup-face ((t (:foreground ,gruber-darker-niagara-1))))
   `(markdown-code-face ((t (:inherit fixed-pitch :background ,gruber-darker-bg-1))))
   `(markdown-inline-code-face ((t (:inherit markdown-code-face :foreground ,gruber-darker-green))))
   `(markdown-pre-face ((t (:inherit markdown-code-face :extend t))))
   `(markdown-blockquote-face ((t (:foreground ,gruber-darker-quartz :slant italic))))
   `(markdown-link-face ((t (:inherit link))))
   `(markdown-url-face ((t (:foreground ,gruber-darker-niagara))))
   `(markdown-list-face ((t (:foreground ,gruber-darker-yellow))))
   `(markdown-table-face ((t (:foreground ,gruber-darker-niagara))))

   ;; Org headings, source blocks, and agenda
   `(org-level-1 ((t (:foreground ,gruber-darker-yellow :weight bold))))
   `(org-level-2 ((t (:foreground ,gruber-darker-niagara :weight bold))))
   `(org-level-3 ((t (:foreground ,gruber-darker-green :weight bold))))
   `(org-level-4 ((t (:foreground ,gruber-darker-wisteria :weight bold))))
   `(org-level-5 ((t (:foreground ,gruber-darker-quartz))))
   `(org-level-6 ((t (:foreground ,gruber-darker-brown))))
   `(org-level-7 ((t (:inherit org-level-3))))
   `(org-level-8 ((t (:inherit org-level-4))))
   `(org-document-title ((t (:inherit org-level-1))))
   `(org-hide ((t (:foreground ,gruber-darker-bg))))
   `(org-block ((t (:inherit fixed-pitch :background ,gruber-darker-bg-1 :extend t))))
   `(org-block-begin-line ((t (:foreground ,gruber-darker-niagara-1 :background ,gruber-darker-bg-1 :extend t))))
   `(org-block-end-line ((t (:inherit org-block-begin-line))))
   `(org-code ((t (:foreground ,gruber-darker-green :inherit fixed-pitch))))
   `(org-verbatim ((t (:foreground ,gruber-darker-quartz :inherit fixed-pitch))))
   `(org-table ((t (:foreground ,gruber-darker-niagara :inherit fixed-pitch))))
   `(org-link ((t (:inherit link))))
   `(org-date ((t (:foreground ,gruber-darker-wisteria))))
   `(org-agenda-date ((t (:foreground ,gruber-darker-niagara :weight bold))))
   `(org-agenda-date-today ((t (:inherit org-agenda-date :foreground ,gruber-darker-yellow))))
   `(org-scheduled ((t (:foreground ,gruber-darker-green))))
   `(org-scheduled-today ((t (:inherit org-scheduled :weight bold))))
   `(org-warning ((t (:foreground ,gruber-darker-red :weight bold))))

   ;; Treemacs
   `(treemacs-window-background-face ((t (:inherit default :background ,gruber-darker-bg-1))))
   `(treemacs-hl-line-face ((t (:inherit solaire-hl-line-face))))
   `(treemacs-directory-face ((t (:inherit dired-directory))))
   `(treemacs-directory-collapsed-face ((t (:foreground ,gruber-darker-quartz))))
   `(treemacs-file-face ((t (:foreground ,gruber-darker-fg))))
   `(treemacs-root-face ((t (:foreground ,gruber-darker-yellow :weight bold))))
   `(treemacs-git-modified-face ((t (:foreground ,gruber-darker-yellow))))
   `(treemacs-git-added-face ((t (:foreground ,gruber-darker-green))))
   `(treemacs-git-untracked-face ((t (:foreground ,gruber-darker-green))))
   `(treemacs-git-ignored-face ((t (:foreground ,gruber-darker-niagara-1))))
   `(treemacs-git-conflict-face ((t (:foreground ,gruber-darker-red :weight bold))))

   ;; Modern Magit
   `(magit-section-heading ((t (:foreground ,gruber-darker-yellow :weight bold))))
   `(magit-section-highlight ((t (:background ,gruber-darker-bg+1 :extend t))))
   `(magit-branch-local ((t (:foreground ,gruber-darker-niagara))))
   `(magit-branch-remote ((t (:foreground ,gruber-darker-green))))
   `(magit-hash ((t (:foreground ,gruber-darker-niagara-1))))
   `(magit-diff-context ((t (:foreground ,gruber-darker-quartz :extend t))))
   `(magit-diff-context-highlight ((t (:inherit magit-diff-context :background ,gruber-darker-bg+1))))
   `(magit-diff-added ((t (:foreground ,gruber-darker-green :extend t))))
   `(magit-diff-added-highlight ((t (:inherit magit-diff-added :background ,gruber-darker-bg+1))))
   `(magit-diff-removed ((t (:foreground ,gruber-darker-red :extend t))))
   `(magit-diff-removed-highlight ((t (:inherit magit-diff-removed :background ,gruber-darker-bg+1))))
   `(magit-diff-hunk-heading ((t (:background ,gruber-darker-bg+2 :foreground ,gruber-darker-fg :extend t))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,gruber-darker-bg+3 :foreground ,gruber-darker-fg+1 :extend t))))

   ;; Shared status, diagnostics, and modern syntax faces
   `(error ((t (:foreground ,gruber-darker-red :weight bold))))
   `(warning ((t (:foreground ,gruber-darker-yellow))))
   `(success ((t (:foreground ,gruber-darker-green))))
   `(font-lock-number-face ((t (:foreground ,gruber-darker-wisteria))))
   `(font-lock-operator-face ((t (:foreground ,gruber-darker-fg))))
   `(font-lock-property-name-face ((t (:foreground ,gruber-darker-quartz))))
   `(font-lock-property-use-face ((t (:inherit font-lock-property-name-face))))
   `(font-lock-function-call-face ((t (:inherit font-lock-function-name-face))))
   `(font-lock-variable-use-face ((t (:inherit font-lock-variable-name-face))))
   `(font-lock-punctuation-face ((t (:foreground ,gruber-darker-quartz))))
   `(font-lock-bracket-face ((t (:inherit font-lock-punctuation-face))))
   `(font-lock-escape-face ((t (:foreground ,gruber-darker-yellow))))
   `(flymake-error ((t (:underline (:style wave :color ,gruber-darker-red)))))
   `(flymake-warning ((t (:underline (:style wave :color ,gruber-darker-yellow)))))
   `(flymake-note ((t (:underline (:style wave :color ,gruber-darker-green)))))
   `(eglot-highlight-symbol-face ((t (:background ,gruber-darker-line :underline t))))
   `(eglot-inlay-hint-face ((t (:inherit shadow))))
   `(eglot-mode-line ((t (:inherit mode-line))))
   `(show-paren-match ((t (:background ,gruber-darker-selection :weight bold))))
   `(show-paren-mismatch ((t (:background ,gruber-darker-red-1 :foreground ,gruber-darker-white))))
   `(lazy-highlight ((t (:background ,gruber-darker-niagara-2 :foreground ,gruber-darker-fg+1))))
   `(match ((t (:background ,gruber-darker-selection :foreground ,gruber-darker-white))))
   `(header-line ((t (:background ,gruber-darker-bg-1 :foreground ,gruber-darker-quartz))))
   `(mode-line-active ((t (:inherit mode-line))))
   `(mode-line-emphasis ((t (:foreground ,gruber-darker-yellow :weight bold))))
   `(mode-line-highlight ((t (:background ,gruber-darker-selection :foreground ,gruber-darker-white))))
   `(dired-symlink ((t (:foreground ,gruber-darker-quartz))))
   `(dired-marked ((t (:foreground ,gruber-darker-yellow :weight bold))))
   `(dired-flagged ((t (:inherit error))))
   `(dired-perm-write ((t (:inherit warning))))

   ;; Doom Modeline and spacious-padding
   `(doom-modeline ((t (:foreground ,gruber-darker-fg))))
   `(doom-modeline-emphasis ((t (:inherit mode-line-emphasis))))
   `(doom-modeline-highlight ((t (:inherit mode-line-highlight))))
   `(doom-modeline-buffer-path ((t (:foreground ,gruber-darker-quartz))))
   `(doom-modeline-buffer-file ((t (:foreground ,gruber-darker-fg+1 :weight bold))))
   `(doom-modeline-buffer-modified ((t (:inherit warning :weight bold))))
   `(doom-modeline-info ((t (:inherit success))))
   `(doom-modeline-warning ((t (:inherit warning))))
   `(doom-modeline-urgent ((t (:inherit error))))
   `(doom-modeline-bar ((t (:background ,gruber-darker-yellow))))
   `(doom-modeline-bar-inactive ((t (:background ,gruber-darker-bg+1))))
   `(doom-modeline-debug-visual ((t (:foreground ,gruber-darker-wisteria))))
   `(spacious-padding-line-active ((t (:inherit mode-line-active))))
   `(spacious-padding-line-inactive ((t (:inherit mode-line-inactive))))

   ;; Completion annotations, previews, and actions
   `(vertico-group-title ((t (:inherit font-lock-keyword-face))))
   `(vertico-group-separator ((t (:inherit shadow))))
   `(marginalia-documentation ((t (:inherit font-lock-doc-face))))
   `(marginalia-key ((t (:inherit font-lock-keyword-face))))
   `(marginalia-file-name ((t (:inherit default))))
   `(marginalia-modified ((t (:inherit warning))))
   `(consult-preview-line ((t (:inherit hl-line))))
   `(consult-preview-match ((t (:inherit match))))
   `(consult-highlight-match ((t (:inherit match))))
   `(consult-highlight-mark ((t (:inherit region))))
   `(consult-preview-insertion ((t (:inherit region))))
   `(consult-async-running ((t (:inherit warning))))
   `(consult-async-finished ((t (:inherit success))))
   `(consult-async-failed ((t (:inherit error))))
   `(consult-narrow-indicator ((t (:inherit font-lock-keyword-face))))
   `(embark-target ((t (:inherit hl-line))))
   `(embark-selected ((t (:inherit match))))
   `(embark-keybinding ((t (:inherit font-lock-keyword-face))))
   `(embark-keybinding-repeat ((t (:inherit success))))
   `(embark-collect-group-title ((t (:inherit font-lock-keyword-face))))
   `(embark-collect-annotation ((t (:inherit completions-annotations))))
   `(which-key-key-face ((t (:inherit font-lock-keyword-face))))
   `(which-key-group-description-face ((t (:inherit font-lock-function-name-face))))
   `(which-key-command-description-face ((t (:inherit default))))
   `(which-key-separator-face ((t (:inherit shadow))))
   `(which-key-note-face ((t (:inherit font-lock-doc-face))))
   `(substitute-match ((t (:inherit match))))
   `(substitute-prompt-target-highlight ((t (:inherit warning))))

   ;; CIDER REPL, evaluation, tests, and debugging
   `(cider-repl-prompt-face ((t (:inherit font-lock-keyword-face))))
   `(cider-repl-input-face ((t (:inherit default))))
   `(cider-repl-stdout-face ((t (:inherit default))))
   `(cider-repl-result-face ((t (:inherit success))))
   `(cider-repl-stderr-face ((t (:inherit error))))
   `(cider-result-overlay-face ((t (:inherit success))))
   `(cider-error-overlay-face ((t (:inherit error))))
   `(cider-flash-face ((t (:inherit hl-line))))
   `(cider-test-success-face ((t (:inherit success))))
   `(cider-test-failure-face ((t (:inherit warning))))
   `(cider-test-error-face ((t (:inherit error))))
   `(cider-fringe-good-face ((t (:inherit success))))
   `(cider-fringe-stale-face ((t (:inherit warning))))
   `(cider-fringe-bad-face ((t (:inherit error))))
   `(cider-stacktrace-error-class-face ((t (:inherit error))))
   `(cider-stacktrace-error-message-face ((t (:inherit warning))))
   `(cider-stacktrace-ns-face ((t (:inherit font-lock-type-face))))
   `(cider-stacktrace-fn-face ((t (:inherit font-lock-function-name-face))))
   `(cider-stacktrace-filter-active-face ((t (:inherit success))))
   `(cider-stacktrace-filter-inactive-face ((t (:inherit shadow))))
   `(cider-debug-code-overlay-face ((t (:inherit hl-line))))
   `(cider-debug-prompt-face ((t (:inherit font-lock-keyword-face))))
   `(cider-enlightened-face ((t (:inherit success))))
   `(cider-enlightened-local-face ((t (:inherit font-lock-variable-name-face))))
   `(cider-error-highlight-face ((t (:inherit flymake-error))))
   `(cider-warning-highlight-face ((t (:inherit flymake-warning))))
   `(cider-docview-literal-face ((t (:inherit org-code))))

   ;; Geiser and Guile
   `(geiser-font-lock-repl-prompt ((t (:inherit font-lock-keyword-face))))
   `(geiser-font-lock-repl-input ((t (:inherit default))))
   `(geiser-font-lock-repl-output ((t (:inherit default))))
   `(geiser-font-lock-repl-output-success ((t (:inherit success))))
   `(geiser-font-lock-repl-output-warning ((t (:inherit warning))))
   `(geiser-font-lock-repl-output-error ((t (:inherit error))))
   `(geiser-font-lock-xref-link ((t (:inherit link))))
   `(geiser-font-lock-xref-header ((t (:inherit font-lock-function-name-face))))
   `(geiser-font-lock-doc-title ((t (:inherit org-document-title))))
   `(geiser-font-lock-doc-link ((t (:inherit link))))
   `(geiser-font-lock-doc-button ((t (:inherit link))))
   `(geiser-font-lock-image-button ((t (:inherit link))))
   `(geiser-font-lock-error-link ((t (:inherit error))))
   `(geiser-font-lock-autodoc-current-arg ((t (:inherit font-lock-keyword-face))))
   `(geiser-font-lock-autodoc-identifier ((t (:inherit font-lock-function-name-face))))

   ;; Racket XP and debugger
   `(racket-xp-def-face ((t (:inherit match))))
   `(racket-xp-use-face ((t (:inherit hl-line))))
   `(racket-xp-binding-lang-face ((t (:inherit font-lock-keyword-face))))
   `(racket-xp-binding-lang-use-face ((t (:inherit font-lock-keyword-face))))
   `(racket-xp-binding-import-face ((t (:inherit font-lock-type-face))))
   `(racket-xp-binding-import-use-face ((t (:inherit font-lock-type-face))))
   `(racket-xp-binding-local-face ((t (:inherit font-lock-variable-name-face))))
   `(racket-xp-binding-local-use-face ((t (:inherit font-lock-variable-name-face))))
   `(racket-xp-error-face ((t (:inherit flymake-error))))
   `(racket-xp-unused-face ((t (:inherit shadow))))
   `(racket-xp-tail-target-face ((t (:inherit match))))
   `(racket-xp-tail-position-face ((t (:inherit hl-line))))
   `(racket-keyword-argument-face ((t (:inherit font-lock-builtin-face))))
   `(racket-logger-fatal-face ((t (:inherit error))))
   `(racket-logger-error-face ((t (:inherit error))))
   `(racket-logger-warning-face ((t (:inherit warning))))
   `(racket-logger-info-face ((t (:inherit success))))
   `(racket-logger-debug-face ((t (:inherit shadow))))
   `(racket-debug-break-face ((t (:inherit warning))))
   `(racket-debug-break-span-face ((t (:inherit region))))
   `(racket-debug-break-expression-face ((t (:inherit match))))
   `(racket-debug-locals-face ((t (:inherit font-lock-variable-name-face))))

   ;; Combobulate refactoring and tree indicators
   `(combobulate-refactor-highlight-face ((t (:inherit hl-line))))
   `(combobulate-refactor-label-face ((t (:inherit font-lock-keyword-face))))
   `(combobulate-refactor-field-face ((t (:inherit match))))
   `(combobulate-refactor-inactive-field-face ((t (:inherit hl-line))))
   `(combobulate-refactor-disabled-field-face ((t (:inherit shadow))))
   `(combobulate-refactor-choice-face ((t (:inherit match))))
   `(combobulate-refactor-inactive-choice-face ((t (:inherit hl-line))))
   `(combobulate-refactor-cursor-face ((t (:inherit region))))
   `(combobulate-dimmed-indicator-face ((t (:inherit shadow))))
   `(combobulate-active-indicator-face ((t (:inherit success))))
   `(combobulate-error-indicator-face ((t (:inherit error))))
   `(combobulate-tree-branch-face ((t (:inherit shadow))))

   ;; Rainbow delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,gruber-darker-yellow))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,gruber-darker-niagara))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,gruber-darker-green))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,gruber-darker-wisteria))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,gruber-darker-quartz))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,gruber-darker-brown))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,gruber-darker-fg))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,gruber-darker-niagara))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,gruber-darker-green))))
   `(rainbow-delimiters-unmatched-face ((t (:inherit error))))
   `(rainbow-delimiters-mismatched-face ((t (:inherit error))))

   ;; Icon colors (font families and glyph selection remain package-owned)
   `(nerd-icons-red ((t (:foreground ,gruber-darker-red))))
   `(nerd-icons-lred ((t (:foreground ,gruber-darker-red))))
   `(nerd-icons-dred ((t (:foreground ,gruber-darker-red))))
   `(nerd-icons-green ((t (:foreground ,gruber-darker-green))))
   `(nerd-icons-lgreen ((t (:foreground ,gruber-darker-green))))
   `(nerd-icons-dgreen ((t (:foreground ,gruber-darker-green))))
   `(nerd-icons-yellow ((t (:foreground ,gruber-darker-yellow))))
   `(nerd-icons-lyellow ((t (:foreground ,gruber-darker-yellow))))
   `(nerd-icons-dyellow ((t (:foreground ,gruber-darker-yellow))))
   `(nerd-icons-blue ((t (:foreground ,gruber-darker-niagara))))
   `(nerd-icons-lblue ((t (:foreground ,gruber-darker-niagara))))
   `(nerd-icons-dblue ((t (:foreground ,gruber-darker-niagara))))
   `(nerd-icons-maroon ((t (:foreground ,gruber-darker-brown))))
   `(nerd-icons-lmaroon ((t (:foreground ,gruber-darker-brown))))
   `(nerd-icons-dmaroon ((t (:foreground ,gruber-darker-brown))))
   `(nerd-icons-purple ((t (:foreground ,gruber-darker-wisteria))))
   `(nerd-icons-lpurple ((t (:foreground ,gruber-darker-wisteria))))
   `(nerd-icons-dpurple ((t (:foreground ,gruber-darker-wisteria))))
   `(nerd-icons-orange ((t (:foreground ,gruber-darker-brown))))
   `(nerd-icons-lorange ((t (:foreground ,gruber-darker-brown))))
   `(nerd-icons-dorange ((t (:foreground ,gruber-darker-brown))))
   `(nerd-icons-cyan ((t (:foreground ,gruber-darker-quartz))))
   `(nerd-icons-lcyan ((t (:foreground ,gruber-darker-quartz))))
   `(nerd-icons-dcyan ((t (:foreground ,gruber-darker-quartz))))
   `(nerd-icons-pink ((t (:foreground ,gruber-darker-wisteria))))
   `(nerd-icons-lpink ((t (:foreground ,gruber-darker-wisteria))))
   `(nerd-icons-dpink ((t (:foreground ,gruber-darker-wisteria))))
   `(nerd-icons-silver ((t (:foreground ,gruber-darker-fg))))
   `(nerd-icons-lsilver ((t (:foreground ,gruber-darker-fg))))
   `(nerd-icons-dsilver ((t (:foreground ,gruber-darker-fg))))
   `(nerd-icons-red-alt ((t (:inherit nerd-icons-red))))
   `(nerd-icons-blue-alt ((t (:inherit nerd-icons-blue))))
   `(nerd-icons-purple-alt ((t (:inherit nerd-icons-purple))))
   `(nerd-icons-cyan-alt ((t (:inherit nerd-icons-cyan))))
   `(all-the-icons-red ((t (:foreground ,gruber-darker-red))))
   `(all-the-icons-lred ((t (:foreground ,gruber-darker-red))))
   `(all-the-icons-dred ((t (:foreground ,gruber-darker-red))))
   `(all-the-icons-green ((t (:foreground ,gruber-darker-green))))
   `(all-the-icons-lgreen ((t (:foreground ,gruber-darker-green))))
   `(all-the-icons-dgreen ((t (:foreground ,gruber-darker-green))))
   `(all-the-icons-yellow ((t (:foreground ,gruber-darker-yellow))))
   `(all-the-icons-lyellow ((t (:foreground ,gruber-darker-yellow))))
   `(all-the-icons-dyellow ((t (:foreground ,gruber-darker-yellow))))
   `(all-the-icons-blue ((t (:foreground ,gruber-darker-niagara))))
   `(all-the-icons-lblue ((t (:foreground ,gruber-darker-niagara))))
   `(all-the-icons-dblue ((t (:foreground ,gruber-darker-niagara))))
   `(all-the-icons-maroon ((t (:foreground ,gruber-darker-brown))))
   `(all-the-icons-lmaroon ((t (:foreground ,gruber-darker-brown))))
   `(all-the-icons-dmaroon ((t (:foreground ,gruber-darker-brown))))
   `(all-the-icons-purple ((t (:foreground ,gruber-darker-wisteria))))
   `(all-the-icons-lpurple ((t (:foreground ,gruber-darker-wisteria))))
   `(all-the-icons-dpurple ((t (:foreground ,gruber-darker-wisteria))))
   `(all-the-icons-orange ((t (:foreground ,gruber-darker-brown))))
   `(all-the-icons-lorange ((t (:foreground ,gruber-darker-brown))))
   `(all-the-icons-dorange ((t (:foreground ,gruber-darker-brown))))
   `(all-the-icons-cyan ((t (:foreground ,gruber-darker-quartz))))
   `(all-the-icons-lcyan ((t (:foreground ,gruber-darker-quartz))))
   `(all-the-icons-dcyan ((t (:foreground ,gruber-darker-quartz))))
   `(all-the-icons-pink ((t (:foreground ,gruber-darker-wisteria))))
   `(all-the-icons-lpink ((t (:foreground ,gruber-darker-wisteria))))
   `(all-the-icons-dpink ((t (:foreground ,gruber-darker-wisteria))))
   `(all-the-icons-silver ((t (:foreground ,gruber-darker-fg))))
   `(all-the-icons-lsilver ((t (:foreground ,gruber-darker-fg))))
   `(all-the-icons-dsilver ((t (:foreground ,gruber-darker-fg))))
   `(all-the-icons-red-alt ((t (:inherit all-the-icons-red))))
   `(all-the-icons-blue-alt ((t (:inherit all-the-icons-blue))))
   `(all-the-icons-purple-alt ((t (:inherit all-the-icons-purple))))
   `(all-the-icons-cyan-alt ((t (:inherit all-the-icons-cyan))))

   ;; Orderless
   `(orderless-match-face-0 ((t (:foreground ,gruber-darker-yellow))))
   `(orderless-match-face-1 ((t (:foreground ,gruber-darker-green))))
   `(orderless-match-face-2 ((t (:foreground ,gruber-darker-brown))))
   `(orderless-match-face-3 ((t (:foreground ,gruber-darker-quartz))))
   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'gruber-darker)
(provide 'gruber-darker-theme)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; gruber-darker-theme.el ends here.
