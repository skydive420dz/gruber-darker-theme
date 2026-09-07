# Coverage of the X230T configuration

Audited read-only on 2026-09-07 against
`x230t-bsd:~/.config/emacs/init.el` and installed Elpaca package sources.
The active config and daemon were not changed. This map describes face support,
not proof that every package UI has been visually tested.

| Configured tools | Theme coverage |
| --- | --- |
| Vertico, Orderless, Corfu | Current candidates, popup surfaces, match colors, groups and separators. |
| Consult, Marginalia, Embark, embark-consult | Preview/target/selection faces and annotation faces; remaining semantic faces inherit Font Lock, status, and completion faces. |
| Cape | Completion providers use Corfu/completion faces; no new UI added. |
| Doom Modeline | File/path/modified indicators, severity, emphasis, bar, and shared mode-line faces. Other segments inherit these and the shared semantic faces. |
| Solaire, hl-line | Alternate backgrounds, fringe/line numbers, hidden Org stars, region and current-line faces. Mode/header lines retain their shared theme inheritance. |
| Org, org-bullets, toc-org | Headings, agenda, TODO/DONE, links, tables and source blocks. Bullets and generated TOCs use Org/Markdown fontification. |
| Markdown | Headings, markup, code, links, lists and tables; other syntax inherits Font Lock. HTML output is styled separately by its renderer/CSS. |
| Treemacs, treemacs-projectile, treemacs-icons-dired, treemacs-magit, treemacs-persp, treemacs-tab-bar | Tree/file/Git/highlight faces, Dired and tab-bar. Optional helper supplies adapted Atom/color icon sets and tree layout; project/scope adapter behavior remains package-owned. |
| Magit | Section/branch/hash faces, diff content and highlighted variants; legacy faces remain for compatibility. |
| CIDER, Geiser, geiser-guile, Racket | REPL prompts/results/errors, evaluation highlights and debugger feedback; syntax uses Font Lock. REPL processes are not started by the theme. |
| Eglot, Lua/C/Python/Scheme/Clojure modes | Shared modern Font Lock, Flymake diagnostics and Eglot symbol/inlay-hint faces. Grammar and server setup remain editor configuration. |
| Paredit, rainbow-delimiters, Combobulate | Parenthesis matching/mismatches, depth colors and structural-refactoring fields/indicators. Paredit behavior is unchanged. |
| Which-key, Substitute | Key/help descriptions, match/target/status faces. Substitute highlighting remains disabled if configured that way. |
| all-the-icons, all-the-icons-dired, nerd-icons | Icon color families and Dired colors; glyph fonts, metrics and file-to-icon mappings remain package-owned. |
| spacious-padding | Active/inactive line faces. Widths, spacing and borders remain editor settings. |
| rainbow-mode | Literal color previews intentionally display the color written in the buffer, not the theme palette. |
| compat, Elpaca, session/history/backup settings | No custom color logic needed for these configuration roles; ordinary buffers inherit the base theme. Package-manager-specific status styling is not included. |

This is coverage of the configured workflows, not a promise to override every
face in every optional extension. For example, unused modal-editing segments
of Doom Modeline and specialized Combobulate query palettes keep their package
defaults. New tools and package-specific faces should be reviewed when adopted.

## Settings adopted from the saved configuration

- Current-line backgrounds: `#303e48` in ordinary and Solaire buffers.
- Vertico/Corfu selection: `#40586b`, with white text.
- Italic comments and keywords; Gruber keyword weight is retained.
- Code and tables inherit `fixed-pitch`; the theme does not replace fonts.
- The optional [appearance section](examples/appearance.el) preserves VictorMono
  Nerd Font Mono at 10pt, MesloLGS Nerd Font at 11pt, medium weights, and 0.12
  line spacing. Meslo is monospaced even when assigned to `variable-pitch`.
- Transparency, font availability, icon sizing, spacing and padding stay outside
  the theme. Terminal fonts are chosen by the terminal emulator.

## Removing Doom later: colors versus behavior

The fork does not require `doom-themes`. Keep `doom-modeline`; it is separate.
Remove the old color overrides only when switching to the fork, otherwise
Customize's overrides will continue to take precedence.

The saved Doom block also calls helpers that are not just face definitions:

| Existing helper | Migration implication |
| --- | --- |
| `doom-themes-visual-bell-config` | Replaced by `gruber-darker-bell-mode`, including Solaire remaps and a 150ms cleanup timer. |
| `doom-themes-treemacs-config` | Replaced by `gruber-darker-treemacs-config`: `gruber-atom`/`gruber-colors`, labels, tabs, spacing and fringes. |
| `doom-themes-org-config` | Replaced by `gruber-darker-org-config`: TODO/statistics inheritance, list/checkbox fontification and special tags. |
| `doom-themes-neotree-config` | Configures Neotree icons/filetype highlighting. No active Neotree declaration was found in this config; its helper can be omitted if Neotree is not used. |

The authorized helpers are now implemented as opt-in libraries. The complete
[appearance example](examples/appearance.el) enables them. End-to-end visual
parity is still a migration check; no active configuration is changed here.

## Acceptance boundary

Parsing, face-spec validation, compilation, and isolated integration checks
must pass before considering an init change. Passing them does not authorize
editing init or restarting a daemon. Visual checks should then cover a fresh
GUI and SSH terminal frame, completion selection, Org/Markdown, a REPL, Magit,
Treemacs and the modeline. The local terminal test is not an SSH acceptance test.
