;;; gruber-darker-bell.el --- Optional mode-line bell -*- lexical-binding: t; -*-

;; Copyright (C) 2019-2024 Henrik Lissner
;; Author: Henrik Lissner <contact@henrik.io>
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
;; Fork changes: explicit reversible activation and safe buffer cleanup.

;;; Code:
(require 'face-remap)

(defface gruber-darker-visual-bell '((t :inherit error))
  "Face flashed by `gruber-darker-bell-mode'."
  :group 'faces)

(defvar gruber-darker-bell--saved-settings nil)

(defun gruber-darker-bell ()
  "Flash the current buffer's mode-line, including Solaire remaps."
  (let* ((buffer (current-buffer))
         (faces (if (facep 'mode-line-active)
                    '(mode-line-active solaire-mode-line-active-face)
                  '(mode-line solaire-mode-line-face)))
         (cookies (delq nil
                        (mapcar (lambda (face)
                                  (when (facep face)
                                    (face-remap-add-relative
                                     face 'gruber-darker-visual-bell)))
                                faces))))
    (force-mode-line-update)
    (run-with-timer
     0.15 nil
     (lambda ()
       (when (buffer-live-p buffer)
         (with-current-buffer buffer
           (mapc #'face-remap-remove-relative cookies)
           (force-mode-line-update)))))))

;;;###autoload
(define-minor-mode gruber-darker-bell-mode
  "Use the optional Gruber mode-line bell globally."
  :global t
  :group 'faces
  (if gruber-darker-bell-mode
      (progn
        (unless gruber-darker-bell--saved-settings
          (setq gruber-darker-bell--saved-settings
                (cons ring-bell-function visible-bell)))
        (setq ring-bell-function #'gruber-darker-bell
              visible-bell t))
    (when gruber-darker-bell--saved-settings
      (when (eq ring-bell-function #'gruber-darker-bell)
        (setq ring-bell-function (car gruber-darker-bell--saved-settings)
              visible-bell (cdr gruber-darker-bell--saved-settings)))
      (setq gruber-darker-bell--saved-settings nil))))

(provide 'gruber-darker-bell)
;;; gruber-darker-bell.el ends here
