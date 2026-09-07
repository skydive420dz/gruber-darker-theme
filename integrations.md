# Optional integrations

These are opt-in adaptations of the helpers found in the saved X230T Doom
configuration. Loading `gruber-darker-theme` alone does not activate them.
The complete [appearance example](examples/appearance.el) activates the
approved helpers after their respective packages load.

## Provenance and attribution

Original author: Henrik Lissner and the Doom Themes project.
Source repository: <https://github.com/doomemacs/themes>.
Inspected source revision: `a59202912ad55014e53a685eee6cd94130bdd4fd`, read from
X230T's installed checkout on 2026-09-07.

| Original source | Adapted file |
| --- | --- |
| `extensions/doom-themes-ext-visual-bell.el` | [gruber-darker-bell.el](gruber-darker-bell.el) |
| `extensions/doom-themes-ext-org.el` | [gruber-darker-org.el](gruber-darker-org.el) |
| `extensions/doom-themes-ext-treemacs.el` | [gruber-darker-treemacs.el](gruber-darker-treemacs.el) |

The MIT text is retained in every adapted file and in
[LICENSE.doom-themes](LICENSE.doom-themes). Treemacs, nerd-icons, and their
assets are external dependencies; their sources/assets are not vendored in
tracked files. Local copied dependencies under `.test-work/` are ignored.

## Behavior and activation

- **Bell:** `(require 'gruber-darker-bell)` followed by
  `(gruber-darker-bell-mode 1)` installs the mode-line/Solaire flash callback.
  `-1` restores previous bell settings if the helper still owns the callback.
  Each flash removes only its own remaps; cleanup tolerates a killed buffer.
- **Org:** after Org loads, require `gruber-darker-org` and call
  `gruber-darker-org-config`. It registers the adapted fontification hook for
  new/refontified Org buffers. Repeated setup does not duplicate the hook.
  `gruber-darker-org-fontify-special-tags` controls hashtag/at-tag highlighting;
  the original source/link/citation exclusion list is preserved.
- **Treemacs:** after Treemacs loads, require `gruber-darker-treemacs` and call
  `gruber-darker-treemacs-config`. Existing nerd-icons is required. The
  `gruber-darker-treemacs-theme` option selects `gruber-atom` (default) or
  `gruber-colors`. Both preserve the adapted icon mappings and terminal
  fallbacks; missing glyphs still depend on the terminal/GUI icon font.
  Layout options retain the upstream defaults: variable-pitch labels, line
  spacing 1, narrow tabs, and a 3-pixel fringe indicator. Label remaps and Dired
  tab changes are buffer-local; Dired tab width is restored on mode disable.
  Repeated setup does not duplicate theme registrations or remaps.

All public names are fork-specific. The deprecated `doom-org-special-tags`
alias and global tree-label face mutation are not carried into the fork.
No Neotree module is added because no active Neotree declaration was found in
the audited config. This integration does not change keybindings, start REPLs,
activate daemons, or install new packages/fonts.

The Treemacs helper retains upstream's `no-byte-compile` setting: its icon
macros need the optional Treemacs dependency at expansion time. It is loaded
from lexical-binding source only when explicitly enabled. The theme, bell,
and Org modules can be byte/native compiled without Treemacs installed.

## Regression checks

Built-in dependencies only:

```sh
emacs -Q --batch -l test-theme.el -l test-integrations.el \
  -f ert-run-tests-batch-and-exit
```

Solaire and Treemacs checks skip unless dependencies are available. To test
against an existing dependency snapshot, set `GRUBER_TEST_DEPS` to a directory
containing package subdirectories (Treemacs, nerd-icons, Solaire and their
usual dependencies):

```sh
GRUBER_TEST_DEPS="$PWD/.test-work/deps" emacs -Q --batch \
  --eval '(setq user-emacs-directory (expand-file-name ".test-work/user/") native-comp-jit-compilation nil)' \
  -l test-theme.el -l test-integrations.el -f ert-run-tests-batch-and-exit
```

Use sources built for the current Emacs version, not another machine's
bytecode. Tests cover timer cleanup, repeatable activation, Org tag matching
and source exclusion, icon registration in both tables, and local tree/Dired
layout, in addition to the theme's face/contrast tests. They do not establish
GUI rendering, the actual bell animation, or SSH terminal acceptance.

Validation on local Emacs 30.2: all 12 combined tests passed in batch and a
fresh `xterm-256color` frame. Theme/bell/Org byte compilation passed with
warnings treated as errors, and native compilation/loading passed. All source
files and the appearance example passed reader/parentheses checks. Treemacs
helper source was exercised against the copied installed dependency sources.

The same checks subsequently passed on FreeBSD Emacs 31.1 against the
installed dependency builds, using isolated batch and standalone terminal
processes. See [the validation record](validation-freebsd.md) for scope and
remaining visual checks.

Validation involved no init changes, daemon access, commit, or publication.
Publishing this fork does not install or activate it in the user's Emacs.
