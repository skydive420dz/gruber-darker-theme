;;; test-theme.el --- Theme regression checks -*- lexical-binding: t; -*-

(require 'ert)
(require 'cl-lib)
(require 'hl-line)
(require 'org)

(add-to-list 'custom-theme-load-path
             (or (getenv "GRUBER_THEME_DIR")
                 (file-name-directory (or load-file-name buffer-file-name))))
(load-theme 'gruber-darker t)

(defun gruber-test-spec (face)
  "Return FACE's specification in the theme, independent of the display."
  (nth 3 (cl-find-if (lambda (setting)
                      (and (eq (car setting) 'theme-face)
                           (eq (nth 1 setting) face)))
                    (get 'gruber-darker 'theme-settings))))

(defun gruber-test-attributes (face)
  "Return FACE's unconditional attributes."
  (cadr (assq t (gruber-test-spec face))))

(ert-deftest gruber-loads-without-palette-leaks ()
  (should (featurep 'gruber-darker-theme))
  (should (custom-theme-enabled-p 'gruber-darker))
  (should (eq frame-background-mode 'dark))
  (should-not (boundp 'frame-brackground-mode))
  (should-not (boundp 'gruber-darker-bg)))

(ert-deftest gruber-face-specifications-are-valid ()
  ;; Validate every branch, including terminal fallbacks, even in batch mode.
  (make-empty-face 'gruber-test-face)
  (let ((attributes (append '(:bold :italic)
                            (mapcar #'car (face-all-attributes 'default)))))
    (dolist (setting (get 'gruber-darker 'theme-settings))
      (when (eq (car setting) 'theme-face)
        (dolist (branch (nth 3 setting))
          (let ((plist (cadr branch)))
            (should (zerop (% (length plist) 2)))
            (cl-loop for (key value) on plist by #'cddr
                     do (should (memq key attributes)))
            (face-spec-set 'gruber-test-face `((t ,plist)))))))))

(ert-deftest gruber-selection-and-buffer-backgrounds-differ ()
  (let ((background (plist-get (gruber-test-attributes 'default) :background))
        (alternate (plist-get (gruber-test-attributes 'solaire-default-face)
                              :background))
        (selection (plist-get (gruber-test-attributes 'vertico-current)
                              :background)))
    (should-not (equal background alternate))
    (dolist (face '(hl-line solaire-hl-line-face vertico-current))
      (let ((attrs (gruber-test-attributes face)))
        (should (plist-get attrs :extend))
        (should-not (equal background (plist-get attrs :background)))
        (should-not (equal alternate (plist-get attrs :background)))))
    (should-not (equal selection alternate))
    (should (eq (plist-get (gruber-test-attributes 'corfu-current) :inherit)
                'vertico-current))))

(ert-deftest gruber-supports-late-package-faces ()
  (dolist (face '(vertico-current corfu-current solaire-default-face
                 markdown-header-face-1 treemacs-root-face magit-section-heading
                 doom-modeline-buffer-modified cider-repl-prompt-face
                 geiser-font-lock-repl-prompt racket-xp-def-face
                 combobulate-refactor-field-face which-key-key-face
                 nerd-icons-blue all-the-icons-blue))
    (should (gruber-test-spec face))
    ;; Packages may define faces after the theme has already been enabled.
    (unless (facep face)
      (eval `(defface ,face '((t (:foreground "red"))) "Test package face.")))
    (should-not (equal (face-attribute face :foreground nil t) "red"))))

(ert-deftest gruber-preserves-font-ownership-and-italic-preferences ()
  (dolist (face '(font-lock-comment-face font-lock-keyword-face))
    (should (eq (plist-get (gruber-test-attributes face) :slant) 'italic)))
  ;; Loading a theme must not replace machine-specific text or icon fonts.
  (dolist (setting (get 'gruber-darker 'theme-settings))
    (when (eq (car setting) 'theme-face)
      (dolist (branch (nth 3 setting))
        (dolist (attribute '(:family :font :height))
          (should-not (plist-member (cadr branch) attribute)))))))

(ert-deftest gruber-status-faces-and-selected-text-are-distinct ()
  (should-not (equal (plist-get (gruber-test-attributes 'error) :foreground)
                     (plist-get (gruber-test-attributes 'success) :foreground)))
  (should-not (equal (plist-get (gruber-test-attributes 'warning) :foreground)
                     (plist-get (gruber-test-attributes 'success) :foreground)))
  (let* ((attrs (gruber-test-attributes 'vertico-current))
         (foreground (plist-get attrs :foreground))
         (background (plist-get attrs :background)))
    ;; Check sRGB text contrast independently of terminal approximation.
    (cl-labels ((luminance (hex)
                  (apply #'+
                         (cl-mapcar
                          (lambda (offset weight)
                            (let ((v (/ (string-to-number
                                         (substring hex offset (+ offset 2)) 16)
                                        255.0)))
                              (* weight (if (<= v 0.04045) (/ v 12.92)
                                          (expt (/ (+ v 0.055) 1.055) 2.4)))))
                          '(1 3 5) '(0.2126 0.7152 0.0722)))))
      (should (>= (/ (+ 0.05 (luminance foreground))
                     (+ 0.05 (luminance background)))
                  4.5)))))

(ert-deftest gruber-solaire-detects-native-support ()
  ;; Optional real-package check: put solaire-mode.el on load-path to run it.
  (skip-unless (locate-library "solaire-mode"))
  (require 'solaire-mode)
  (let ((solaire-mode-supported-themes nil))
    (load-theme 'gruber-darker t)
    (should solaire-mode--supported-p)
    (with-temp-buffer
      (solaire-mode 1)
      (should solaire-mode)
      (should (assq 'default face-remapping-alist))
      (solaire-mode -1))))

;;; test-theme.el ends here
