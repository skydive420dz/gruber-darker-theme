# Gruber Darker

This is a personal extension of Gruber Darker for Emacs, built on the original
creators' design and implementation.

## Credits and inspiration

- **John Gruber** created the [Gruber Dark palette for BBEdit](https://daringfireball.net/projects/bbcolors/schemes/), the inspiration for this theme family.
- **Jason R. Blevins** created the [Gruber Darker Emacs theme](https://jblevins.org/projects/emacs-color-themes/color-theme-gruber-darker.el.html), providing the initial Emacs work and darker variation.
- **Alexey Kutepov (rexim)** adapted the theme to `deftheme` and extended it in the [upstream repository](https://github.com/rexim/gruber-darker-theme), which this repository forks.

Thank you to the original creators for the palette, inspiration, and initial
work. This fork builds on that foundation; it does not claim authorship of it.
The original copyright and MIT license notices remain in
[`gruber-darker-theme.el`](gruber-darker-theme.el).

## This fork

This fork extends Gruber Darker's palette with the owner's highlighting colors
and adds faces for Solaire, Vertico, Corfu, Org, Markdown, Treemacs, current
Magit, Doom Modeline, REPL/debugger feedback, Which-key, icons, and structural
editing. See [coverage.md](coverage.md) for the audited package map. It also
fixes the missing lexical-binding header and malformed settings in the
original source.
Requires Emacs 27.1 or newer. Packages are optional: the theme defines their
faces without installing or enabling their modes. Optional helper libraries
are activated explicitly by the installation example below.

## Helper credits

The optional bell, Org, and Treemacs helpers are adapted from **Henrik
Lissner's [Doom Themes](https://github.com/doomemacs/themes)**, revision
`a59202912ad55014e53a685eee6cd94130bdd4fd`. Original copyright and MIT license
notices are preserved in each adapted file and in [LICENSE.doom-themes](LICENSE.doom-themes).
See [integrations.md](integrations.md) for provenance, activation, and tests.

## Install with Elpaca

Use this complete theme section instead of another theme-loading block:

```elisp
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
```

Solaire recognizes `solaire-default-face` in the theme automatically. No
`solaire-mode-supported-themes` override or face swapping is needed. File
buffers use `#181818`; Solaire buffers use `#101010`. Current lines use
`#303e48`, and completion selections use `#40586b` with white text.

If Elpaca already installed the upstream repository, changing the recipe alone
may leave that existing checkout in place. Reinstall the package through
Elpaca after saving the fork recipe; verify the resulting repository's origin
points to this fork.

Remove old `custom-set-faces` overrides for `hl-line`, `solaire-*`,
`vertico-current`, and `corfu-current` if you want this theme to own those
colors. User face customizations take priority over themes. Disable old
terminal-frame hooks that reload a different theme.

To load a local checkout without Elpaca:

```elisp
(add-to-list 'custom-theme-load-path "/path/to/gruber-darker-theme/")
(load-theme 'gruber-darker t)
```

The theme does not set fonts, start a server, install frame hooks, or enable
editor modes. A theme is enabled for the Emacs session, including GUI and
terminal frames; exact terminal colors depend on terminal capabilities.

## Optional helpers

- `gruber-darker-bell-mode`: the Doom-style 150ms mode-line flash, including
  Solaire faces, with safe cleanup if the originating buffer closes. Disabling
  it restores the previous bell settings if it still owns the callback.
- `gruber-darker-org-config`: the adapted TODO/statistics/checkbox/bullet
  fontification and `#hashtag`/`@tag` highlighting, excluding source blocks,
  links, and citation references from special-tag highlighting.
- `gruber-darker-treemacs-config`: `gruber-atom` and `gruber-colors` icon sets,
  variable-pitch tree labels, spacing, tab and fringe handling. It uses your
  existing Treemacs and nerd-icons installations; it does not install fonts.

The theme itself remains independent of these helpers and of `doom-themes`.
Doom Modeline stays a separate package. Do not activate old Doom helper calls
alongside the replacements. Removing an init block does not unload its
already-installed hooks/advice; validate migration in a fresh standalone Emacs.

## Fonts and companion settings

[examples/appearance.el](examples/appearance.el) is one complete proposed
replacement section containing the font settings observed on X230T, the fork
recipe, Solaire, optional helpers, and global current-line highlighting. It is not loaded by the
theme. Font-lock comments and keywords are italicized by the theme itself.

## Validate changes

From the repository root:

```sh
emacs -Q --batch -l test-theme.el -f ert-run-tests-batch-and-exit
```

The tests check loading, all face-spec branches, distinct buffer and selection
backgrounds, and faces defined after theme loading. The Solaire integration
test skips unless its library is available. To include an installed Solaire:

```sh
emacs -Q --batch -L /path/to/solaire-mode \
  -l test-theme.el -f ert-run-tests-batch-and-exit
```

For byte compilation, without writing build products next to the source:

```sh
mkdir -p .test-work
cp gruber-darker-theme.el .test-work/
emacs -Q --batch --eval '(setq byte-compile-error-on-warn t)' \
  -f batch-byte-compile .test-work/gruber-darker-theme.el
GRUBER_THEME_DIR="$PWD/.test-work" emacs -Q --batch \
  -l test-theme.el -f ert-run-tests-batch-and-exit
```

For an independent terminal frame, use `emacs -Q -nw` with the local theme
path, without `emacsclient`. Check an Org or Markdown buffer, a completion
selection, and a Solaire buffer; exit that process with `C-x C-c`. Repeat in a
fresh graphical Emacs. Automated tests do not establish visual acceptance in
your SSH terminal or GUI.

The same regression suite can run in a disposable terminal Emacs and exit:

```sh
emacs -Q -nw -L /path/to/solaire-mode -l test-theme.el \
  --eval '(let ((noninteractive t)) (ert-run-tests-batch-and-exit))'
```

Validated locally with Emacs 30.2: all 12 theme/helper tests passed with the
copied source dependencies, in batch and a fresh `xterm-256color` terminal
frame. The theme, bell, and Org modules byte-compiled with warnings treated as
errors and native-compiled/loaded successfully. The optional Treemacs helper
is intentionally source-only.

Isolated validation on X230T FreeBSD 15.1-RELEASE-p3 with Emacs 31.1 also
passed: all 12 tests in batch and a standalone `xterm-256color` frame, plus
strict byte compilation and native compilation/loading of theme/bell/Org.
See [the validation record](validation-freebsd.md). GUI rendering, the visible
bell animation, and visual acceptance in the user's SSH terminal remain
untested. The active configuration and daemon were not used for these tests.

## Upstream

Original project: <https://github.com/rexim/gruber-darker-theme>.
Original author and license notices remain in `gruber-darker-theme.el`.
