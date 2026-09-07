;;; gruber-darker-org.el --- fix fontification issues in org-mode -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2017-2024 Henrik Lissner
;;
;; Author: Henrik Lissner <contact@henrik.io>
;; Maintainer: Henrik Lissner <contact@henrik.io>
;; Created: August 3, 2017
;;
;; This file is not part of GNU Emacs.
;;
;; Adapted from doomemacs/themes at a59202912ad55014e53a685eee6cd94130bdd4fd.
;; SPDX-License-Identifier: MIT
;; See LICENSE.doom-themes for the original license.
;;
;; The MIT License (MIT)
;;
;; Copyright (c) 2016-2026 Henrik Lissner.
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
;; Fork changes: explicit activation and isolated, repeatable setup.
;;
;;; Commentary:
;;
;; Fixes a few fontification issues in org-mode and adds special fontification
;; for @-tags and #hashtags. Call `gruber-darker-org-config' to enable it.
;;
;;   (with-eval-after-load 'org
;;     (require 'gruber-darker-org)
;;     (gruber-darker-org-config))
;;
;;; Code:

(require 'org)
(require 'org-element)

(defgroup gruber-darker-org nil
  "Options for doom's org customizations."
  :group 'gruber-darker)

(defcustom gruber-darker-org-fontify-special-tags t
  "If non-nil, fontify #hashtags and @attags.
Uses `gruber-darker-org-at-tag' and `gruber-darker-org-hash-tag' faces."
  :type 'boolean
  :group 'gruber-darker-org)

(defcustom gruber-darker-org-fontify-exclude-types
  '(src-block
    link
    citation-reference)
  "A list of org elements not to highlight special tags in.
See `gruber-darker-org-fontify-special-tags'."
  :type '(repeat symbol)
  :group 'gruber-darker-org)

(defface gruber-darker-org-at-tag '((t :inherit org-formula))
  "Face used to fontify @-tags in org-mode."
  :group 'gruber-darker-org)

(defface gruber-darker-org-hash-tag '((t :inherit org-tag))
  "Face used to fontify #hashtags in org-mode."
  :group 'gruber-darker-org)


(defvar org-done-keywords)
(defvar org-font-lock-extra-keywords)
(defvar org-heading-keyword-regexp-format)
(defvar org-todo-regexp)
(defvar org-fontify-done-headline)
(defvar org-activate-links)
(declare-function org-delete-all "ext:org-macs" (elts list))
(declare-function org-element-type "ext:org-element" (element))
(declare-function org-element-context "ext:org-element" (&optional element))

;;
(defun gruber-darker--org-tag-face (n)
  "Return the face to use for the currently matched tag.
N is the match index."
  (declare (pure t) (side-effect-free t))
  (let ((context (save-match-data (org-element-context))))
    (unless (memq (org-element-type context) gruber-darker-org-fontify-exclude-types)
      (pcase (match-string n)
        ("#" 'gruber-darker-org-hash-tag)
        ("@" 'gruber-darker-org-at-tag)))))

(defun gruber-darker-enable-org-fontification ()
  "Correct (and improve) org-mode's font-lock keywords.

  1. Re-set `org-todo' & `org-headline-done' faces, to make them respect
     (inherit) underlying faces.
  2. Make statistic cookies respect (inherit) underlying faces.
  3. Fontify item bullets (make them stand out)
  4. Fontify item checkboxes (and when they're marked done), like TODOs that are
     marked done.
  5. Fontify #hashtags and @at-tags, for personal convenience; see
     `gruber-darker-org-fontify-special-tags' to disable this."
  (let ((org-todo (format org-heading-keyword-regexp-format
                          org-todo-regexp))
        (org-done (format org-heading-keyword-regexp-format
                          (concat "\\(?:" (mapconcat #'regexp-quote org-done-keywords
                                                     "\\|")
                                  "\\)")))
        (org-indent? (featurep 'org-indent)))
    (setq
     org-font-lock-extra-keywords
     (append (org-delete-all
              (append `(("\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]"
                         (0 (org-get-checkbox-statistics-face) t))
                        (,org-todo (2 (org-get-todo-face 2) t)))
                      (when org-fontify-done-headline
                        `((,org-done (2 'org-headline-done t))))
                      (when (memq 'date org-activate-links)
                        '((org-activate-dates (0 'org-date t)))))
              org-font-lock-extra-keywords)
             ;; respsect underlying faces!
             `((,org-todo (2 (org-get-todo-face 2) prepend)))
             (when org-fontify-done-headline
               `((,org-done (2 'org-headline-done prepend))))
             (when (memq 'date org-activate-links)
               '((org-activate-dates (0 'org-date prepend))))
             ;; Make checkbox statistic cookies respect underlying faces
             `(("\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]"
                (0 (org-get-checkbox-statistics-face) prepend))
               ;; make plain list bullets stand out.
               ;; give spaces before and after list bullet org-indent face to
               ;; keep correct indentation on mixed-pitch-mode
               ("^\\( *\\)\\([-+]\\(?:[ \t].*[ \t]::\\)?\\|\\(?:[0-9]+\\|[a-zA-Z]\\)[).]\\)\\([ \t]\\)"
                ,@(if org-indent? '((1 'org-indent append)))
                (2 'org-list-dt append)
                ,@(if org-indent? '((3 'org-indent append)))))
             ;; I like how org-mode fontifies checked TODOs and want this to
             ;; extend to checked checkbox items:
             (when org-fontify-done-headline
               '(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)"
                  1 'org-headline-done prepend)))
             ;; custom #hashtags & @at-tags for another level of organization
             (when gruber-darker-org-fontify-special-tags
               '(("\\(?:\\s-\\|^\\)\\(\\([#@]\\)[A-Za-z0-9_.-]+\\)"
                  1 (gruber-darker--org-tag-face 2) prepend)))))))


;;;###autoload
(defun gruber-darker-org-config ()
  "Enable the adapted Doom Org fontification helpers."
  (add-hook 'org-font-lock-set-keywords-hook
            #'gruber-darker-enable-org-fontification))

(provide 'gruber-darker-org)
;;; gruber-darker-org.el ends here
