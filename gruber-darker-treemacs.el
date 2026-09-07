;;; gruber-darker-treemacs.el --- ... -*- lexical-binding: t; no-byte-compile: t -*-
;;
;; Copyright (C) 2018-2024 Henrik Lissner
;;
;; Author: Henrik Lissner <contact@henrik.io>
;; Maintainer: Henrik Lissner <contact@henrik.io>
;; Created: July 10, 2018
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
;;; Code:

(require 'treemacs)
(require 'nerd-icons)
(require 'face-remap)
(defvar treemacs-icons-dired-mode)

(defgroup gruber-darker-treemacs nil
  "Options for Gruber's treemacs theme."
  :group 'gruber-darker)


;;
;;; Variables

(defcustom gruber-darker-treemacs-enable-variable-pitch t
  "If non-nil, remap file, folder & project labels to `variable-pitch'.

See `gruber-darker-treemacs-variable-pitch-face'."
  :type 'boolean
  :group 'gruber-darker-treemacs)

(defcustom gruber-darker-treemacs-line-spacing 1
  "Line-spacing for treemacs buffer."
  :type 'integer
  :group 'gruber-darker-treemacs)

(defcustom gruber-darker-treemacs-theme "gruber-atom"
  "Default treemacs theme."
  :type '(radio (const :doc "A minimalistic atom-inspired icon theme" "gruber-atom")
                (const :doc "A colorful icon theme leveraging nerd-icons" "gruber-colors"))
  :group 'gruber-darker-treemacs)

(defcustom gruber-darker-treemacs-bitmap-indicator-width 3
  "Default treemacs bitmap indicators width."
  :type 'integer
  :group 'gruber-darker-treemacs)

(defcustom gruber-darker-treemacs-variable-pitch-face 'variable-pitch
  "The face to remap file/directory labels to.

Only takes effect if `gruber-darker-treemacs-enable-variable-pitch' is non-nil."
  :type 'face
  :group 'gruber-darker-treemacs)


;;
;;; Faces
(defface gruber-darker-treemacs-root-face
  '((t (:inherit font-lock-string-face)))
  "Face used for the root icon in doom themes' treemacs theme."
  :group 'gruber-darker-treemacs)

(defface gruber-darker-treemacs-file-face
  '((t (:inherit font-lock-doc-face :slant normal)))
  "Face used for the directory and file icons in doom themes' treemacs theme."
  :group 'gruber-darker-treemacs)

;;
;;; Library

(defun gruber-darker-hide-fringes-maybe (&rest _)
  "Remove fringes in current window if `treemacs-fringe-indicator-mode' is nil"
  (when (display-graphic-p)
    (if treemacs-fringe-indicator-mode
        (set-window-fringes nil gruber-darker-treemacs-bitmap-indicator-width 0)
      (set-window-fringes nil 0 0))))

(defun gruber-darker-setup-tab-width (&rest _)
  "Set `tab-width' to 1, so tab characters don't ruin formatting."
  (setq-local tab-width 1))

(defun gruber-darker-define-treemacs-fringe-indicator-bitmap ()
  "Defines `treemacs--fringe-indicator-bitmap'"
  (if (fboundp 'define-fringe-bitmap)
      (define-fringe-bitmap 'treemacs--fringe-indicator-bitmap
        (make-vector 26 #b111) nil gruber-darker-treemacs-bitmap-indicator-width)))

(defun gruber-darker-setup-line-spacing ()
  "Set `line-spacing' in treemacs buffers."
  (setq-local line-spacing gruber-darker-treemacs-line-spacing))

(defvar-local gruber-darker-treemacs--label-remaps nil)

(defun gruber-darker-enable-treemacs-variable-pitch-labels ()
  "Remap tree labels in the current buffer without changing global faces."
  (mapc #'face-remap-remove-relative gruber-darker-treemacs--label-remaps)
  (setq gruber-darker-treemacs--label-remaps nil)
  (when gruber-darker-treemacs-enable-variable-pitch
    (dolist (face '(treemacs-root-face treemacs-git-unmodified-face
                    treemacs-git-modified-face treemacs-git-renamed-face
                    treemacs-git-ignored-face treemacs-git-untracked-face
                    treemacs-git-added-face treemacs-git-conflict-face
                    treemacs-directory-face treemacs-directory-collapsed-face
                    treemacs-file-face treemacs-tags-face))
      (push (face-remap-add-relative face gruber-darker-treemacs-variable-pitch-face)
            gruber-darker-treemacs--label-remaps))))

(defvar-local gruber-darker-treemacs--dired-tab-width nil)

(defun gruber-darker-fix-treemacs-icons-dired-mode ()
  "Use narrow icon tabs only in the affected Dired buffer."
  (if treemacs-icons-dired-mode
      (progn
        (unless gruber-darker-treemacs--dired-tab-width
          (setq gruber-darker-treemacs--dired-tab-width
                (cons (local-variable-p 'tab-width) tab-width)))
        (setq-local tab-width 1))
    (when gruber-darker-treemacs--dired-tab-width
      (if (car gruber-darker-treemacs--dired-tab-width)
          (setq-local tab-width (cdr gruber-darker-treemacs--dired-tab-width))
        (kill-local-variable 'tab-width))
      (setq gruber-darker-treemacs--dired-tab-width nil))))

;;
;;; Bootstrap

(defvar gruber-darker-treemacs--icons-created nil)

;;;###autoload
(defun gruber-darker-treemacs-config ()
  "Enable Gruber tree icons and the adapted Doom tree layout."
  (add-hook 'treemacs-mode-hook #'gruber-darker-setup-tab-width)
  (add-hook 'treemacs-mode-hook #'gruber-darker-setup-line-spacing)
  (add-hook 'treemacs-mode-hook #'gruber-darker-define-treemacs-fringe-indicator-bitmap)
  (add-hook 'treemacs-mode-hook #'gruber-darker-hide-fringes-maybe)
  (add-hook 'treemacs-mode-hook #'gruber-darker-enable-treemacs-variable-pitch-labels)
  (add-hook 'treemacs-icons-dired-mode-hook #'gruber-darker-fix-treemacs-icons-dired-mode)
  (advice-add #'treemacs-select-window :after #'gruber-darker-hide-fringes-maybe)
  (unless gruber-darker-treemacs--icons-created
  ;; minimalistic atom-inspired icon theme
  (let ((face-spec 'gruber-darker-treemacs-file-face))
    (treemacs-create-theme "gruber-atom"
      :config
      (progn
        (treemacs-create-icon
         :icon (format " %s\t" (nerd-icons-octicon "nf-oct-repo" :height 1.2 :v-adjust -0.1 :face 'gruber-darker-treemacs-root-face))
         :extensions (root-open))
        (treemacs-create-icon
         :icon (format " %s\t" (nerd-icons-octicon "nf-oct-repo" :height 1.2 :v-adjust -0.1 :face 'gruber-darker-treemacs-root-face))
         :extensions (root-closed))
        (treemacs-create-icon
         :icon (format "%s\t%s\t"
                       (nerd-icons-octicon "nf-oct-chevron_down" :height 0.75 :v-adjust 0.1 :face face-spec)
                       (nerd-icons-octicon "nf-oct-file_directory" :v-adjust 0 :face face-spec))
         :extensions (dir-open))
        (treemacs-create-icon
         :icon (format "%s\t%s\t"
                       (nerd-icons-octicon "nf-oct-chevron_right" :height 0.75 :v-adjust 0.1 :face face-spec)
                       (nerd-icons-octicon "nf-oct-file_directory" :v-adjust 0 :face face-spec))
         :extensions (dir-closed))
        (treemacs-create-icon
         :icon (format "%s\t%s\t"
                       (nerd-icons-octicon "nf-oct-chevron_down" :height 0.75 :v-adjust 0.1 :face face-spec)
                       (nerd-icons-octicon "nf-oct-package" :v-adjust 0 :face face-spec)) :extensions (tag-open))
        (treemacs-create-icon
         :icon (format "%s\t%s\t"
                       (nerd-icons-octicon "nf-oct-chevron_right" :height 0.75 :v-adjust 0.1 :face face-spec)
                       (nerd-icons-octicon "nf-oct-package" :v-adjust 0 :face face-spec))
         :extensions (tag-closed))
        (treemacs-create-icon
         :icon (format "%s\t" (nerd-icons-octicon "nf-oct-tag" :height 0.9 :v-adjust 0 :face face-spec))
         :extensions (tag-leaf))
        (treemacs-create-icon
         :icon (format "%s\t" (nerd-icons-octicon "nf-oct-flame" :v-adjust 0 :face face-spec))
         :extensions (error))
        (treemacs-create-icon
         :icon (format "%s\t" (nerd-icons-octicon "nf-oct-stop" :v-adjust 0 :face face-spec))
         :extensions (warning))
        (treemacs-create-icon
         :icon (format "%s\t" (nerd-icons-octicon "nf-oct-info" :height 0.75 :v-adjust 0.1 :face face-spec))
         :extensions (info))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-octicon "nf-oct-file_media" :v-adjust 0 :face face-spec))
         :extensions ("ai" "aiff" "avi" "bmp" "eps" "flac" "gif" "ico" "indd"
                      "jpeg" "jpg" "midi" "mkv" "mov" "mp3" "mp4" "ogg" "png"
                      "psd" "svg" "tif" "tiff" "wav" "webm" "webp"))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-octicon "nf-oct-file_code" :v-adjust 0 :face face-spec))
         :extensions ("accdb" "accdt" "actionscript" "adoc" "adoc" "ansible"
                      "antlr" "applescript" "asciidoc" "asm" "c" "cask" "cc"
                      "cc" "clj" "cljc" "cljs" "cmake" "coffee" "cpp" "css"
                      "cxx" "cython" "d" "dart" "diet" "diff" "dml"
                      "docker-compose.yml" "dockerfile" "dscript" "edn" "eex"
                      "el" "elm" "ex" "exs" "fennel" "fish" "fortran"
                      "fortran-modern" "fortranfreeform" "fsharp" "gdscript"
                      "go" "gradle" "graphql" "h" "hh" "hpp" "hs" "htm" "html"
                      "hy" "iced" "inc" "ino" "j2" "j2" "java" "jinja" "jinja2"
                      "jl" "js" "jsx" "kt" "kts" "ledger" "less" "lhs" "lisp"
                      "lua" "makefile" "matlab" "merlin" "mips" "ml" "mli"
                      "moonscript" "nim" "nims" "nix" "objectpascal" "ocaml"
                      "pascal" "patch" "pde" "perl" "pgsql" "php" "php4" "php5"
                      "phps" "pl" "plt" "pm" "pm6" "pony" "pp" "pp" "pro"
                      "prolog" "ps1" "purs" "py" "pyc" "r" "racket" "rb" "rd"
                      "rdx" "re" "rei" "rkt" "rktd" "rktl" "rs" "rsx" "sass"
                      "sbt" "scala" "scm" "scpt" "scrbl" "scribble" "scss" "sh"
                      "sql" "styles" "sv" "tex" "tpp" "ts" "tsx" "v"
                      "vagrantfile" "vh" "vhd" "vhdl" "vhms" "vim" "vue" "xsl"
                      "zsh" "zshrc"))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-octicon "nf-oct-book" :v-adjust 0 :face face-spec))
         :extensions ("azw" "azw3" "cb7" "cba" "cbr" "cbt" "cbz" "ceb" "chm"
                      "djvu" "doc" "docx" "exe" "fb2" "inf" "kf8" "kfx" "lit"
                      "lrf" "lrx" "mobi" "opf" "or" "oxps" "pdb" "pdb" "pdb"
                      "pdg" "pkg" "prc" "ps" "rtf" "tr2" "tr3" "txt" "xeb" "xps"
                      "pot" "potx" "potm" "pps" "ppsx" "ppsm" "ppt" "pptx"
                      "pptm" "pa" "ppa" "ppam" "sldm" "sldx" ))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-faicon "nf-fa-cogs" :height 0.85 :v-adjust 0 :face face-spec))
         :extensions ("Vagrantfile" "babel.config.js" "babelignore" "babelrc"
                      "babelrc.js" "babelrc.json" "bashrc" "bazel" "bazelrc"
                      "bower.json" "bowerrc" "cabal" "cfg" "conf" "config"
                      "cson" "csv" "editorconfig" "envrc" "eslintignore"
                      "eslintrc" "feature" "gemfile" "git" "gitattributes"
                      "gitconfig" "gitignore" "gitmodules" "ideavimrc" "iml"
                      "ini" "inputrc" "json" "ledgerrc" "lock" "nginx"
                      "npm-shrinkwrap.json" "npmignore" "npmrc"
                      "package-lock.json" "package.json" "phpunit" "pkg" "plist"
                      "pom.xml" "properties" "terminalrc" "toml" "tridactylrc"
                      "vimperatorrc" "vimrc" "vrapperrc" "xdefaults" "xml"
                      "xresources" "yaml" "yarn-integrity" "yarnclean"
                      "yarnignore" "yarnrc" "yml"))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-octicon "nf-oct-file" :v-adjust 0 :face face-spec))
         :extensions ("md" "markdown" "rst" "org" "log" "txt" "contribute"
                      "license" "readme" "changelog"))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-octicon "nf-oct-file_binary" :v-adjust 0 :face face-spec))
         :extensions ("exe" "dll" "obj" "so" "o" "out" "elc" "cmake-cache" "csr"
                      "eslintcache" "crt" "cer" "der" "pfx" "p12" "p7b" "p7r"
                      "DS_STORE" "key" "pem" "src" "crl" "sst" "stl" "ipynb"))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-faicon "nf-fa-file_pdf" :v-adjust 0 :face face-spec))
         :extensions ("pdf"))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-octicon "nf-oct-file_zip" :v-adjust 0 :face face-spec))
         :extensions ("zip" "xz" "7z" "tar" "gz" "rar" "tgz" "jar"))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-octicon "nf-oct-file" :v-adjust 0 :face face-spec))
         :extensions (fallback))))

    (treemacs-create-theme "gruber-colors"
      :extends "gruber-atom"
      :config
      (progn
        (treemacs-create-icon
         :icon (format " %s\t" (nerd-icons-octicon "nf-oct-repo" :height 1.2 :v-adjust -0.1 :face 'gruber-darker-treemacs-root-face))
         :extensions (root-open))
        (treemacs-create-icon
         :icon (format " %s\t" (nerd-icons-octicon "nf-oct-repo" :height 1.2 :v-adjust -0.1 :face 'gruber-darker-treemacs-root-face))
         :extensions (root-closed))
        (treemacs-create-icon
         :icon (format "%s\t" (nerd-icons-octicon "nf-oct-flame" :height 0.8 :v-adjust 0 :face 'nerd-icons-red))
         :extensions (error))
        (treemacs-create-icon
         :icon (format "%s\t" (nerd-icons-octicon "nf-oct-stop" :height 0.8 :v-adjust 0 :face 'nerd-icons-yellow))
         :extensions (warning))
        (treemacs-create-icon
         :icon (format "%s\t" (nerd-icons-octicon "nf-oct-info" :height 0.75 :v-adjust 0.1 :face 'nerd-icons-green))
         :extensions (info))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-faicon "nf-fa-git_alt" :height 0.85 :v-adjust 0.0 :face 'nerd-icons-red))
         :extensions ("gitignore" "git" "gitattributes" "gitconfig" "gitmodules"))
        (treemacs-create-icon
         :icon (format "%s\t" (nerd-icons-octicon "nf-oct-book" :height 1.0 :v-adjust 0.0 :face 'nerd-icons-blue))
         :extensions (license))

        (dolist (item nerd-icons-extension-icon-alist)
          (let* ((extension (car item))
                 (func (cadr item))
                 (args (append (list (cadr (cdr item))) '(:v-adjust -0.05 :height 0.85) (cdr (cddr item))))
                 (icon (apply func args)))
            (let* ((icon-pair (cons (format "  %s\t" icon) " "))
                   (gui-icons (treemacs-theme->gui-icons treemacs--current-theme))
                   (tui-icons (treemacs-theme->tui-icons treemacs--current-theme))
                   (gui-icon  (car icon-pair))
                   (tui-icon  (cdr icon-pair)))
              (ht-set! gui-icons extension gui-icon)
              (ht-set! tui-icons extension tui-icon))))

        ;; File extensions for whom the above did not work (likely because their
        ;; regexp is too complicated to be reversed with
        ;; `gruber-darker--get-treemacs-extensions' -- which is too naive)
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-faicon "nf-fa-r_project" :v-adjust 0 :face 'nerd-icons-dblue))
         :extensions ("r"))
        (treemacs-create-icon
         :icon (format "  %s\t" (nerd-icons-octicon "nf-oct-file_code" :v-adjust 0 :face face-spec))
         :extensions ("elc")))))

    (setq gruber-darker-treemacs--icons-created t))
  (treemacs-load-theme gruber-darker-treemacs-theme))

(provide 'gruber-darker-treemacs)
;;; gruber-darker-treemacs.el ends here
