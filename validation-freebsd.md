# Isolated FreeBSD validation

SUPPORTED by the captured process results on 2026-09-07:

- Target: `x230t-bsd`, FreeBSD 15.1-RELEASE-p3 amd64, GNU Emacs 31.1.
- Staging directory: `/tmp/gruber-validation.Fdqycp` on that host.
- All six root Lisp files and `examples/appearance.el` passed full-file
  `check-parens` and reader checks.
- Source regression suite: 12 passed, zero unexpected, none skipped.
- Theme, bell, and Org: byte compilation passed with warnings treated as
  errors; native compilation produced and successfully loaded all three
  `.eln` files.
- Regression runs with byte-compiled theme/bell/Org and with preloaded native
  modules each passed all 12 tests. The native run subsequently reloads the
  theme source through the test suite's `load-theme`; it tests native helper
  behavior and successful native theme loading, not exclusive native execution
  of the entire suite.
- Standalone `emacs -Q -nw` in an `xterm-256color` pseudo-terminal: 12 passed,
  zero unexpected, none skipped; process exited successfully.
- The optional Treemacs helper remains intentionally source-only. Its icon
  registration and buffer-local layout checks passed against installed
  Treemacs and Nerd Icons; Solaire detection/remapping passed as well.
- SHA-256 comparisons confirmed the six staged Lisp files match the local
  fork sources.

The tests used `-Q`, a temporary `user-emacs-directory`, temporary compilation
and cache paths, and disabled automatic native compilation. Installed package
build directories were read through temporary dependency symlinks. No init
was loaded, no package installation was performed, and no daemon/client
command was invoked. Only independent test processes were started and exited.

The following active config hashes matched before and after testing:

| File on X230T | SHA-256 |
| --- | --- |
| `~/.config/emacs/init.el` | `e62d359caa64240c5b4f4e5cc05a65fd8533751349e4005675446185c84d3da0` |
| `~/.config/emacs/early-init.el` | `e61cc5540d44e1c6b5c414cddce4d3ebbb17ad6fd60138f6c12caf6614b905be` |

Local raw evidence is retained in the ignored `.test-work/freebsd31/`:
`validate.py`, `metadata.json`, `results.json`, `identity.log`, `parse.log`,
`source-tests.log`, `compile.log`, `byte-tests.log`, `native-tests.log`, and
`terminal-tests.log`. The read-only `init.snapshot.el` records proposal line
numbers; it is not a replacement configuration and is not for publication.

INSUFFICIENT for visual acceptance: these checks do not establish GUI font
rendering, icon glyph availability, visible bell animation, or appearance in
the user's actual SSH terminal. Those require a separately authorized visual
check. The fork was uncommitted and unpublished at the validation checkpoint;
publication is a separate step and does not activate the theme.

## Proposed configuration alterations — not applied

Line numbers refer to the saved X230T `~/.config/emacs/init.el` snapshot:

- Lines 32–40: remove the four custom color overrides now supplied by the theme.
- Lines 63–68: remove duplicate comment/keyword italic face assignments.
- Lines 210–247: replace the commented Gruber block, Doom theme/helper block,
  and existing hl-line/Solaire blocks with lines 17–43 of
  `examples/appearance.el`. This loads Solaire first, activates Gruber and the
  global visual bell, registers the Org/Treemacs helpers, and retains global
  hl-line. It removes the unused Neotree helper call with the old Doom block.
- Retain machine-owned fonts at lines 46–61 and line spacing at lines 70–71;
  do not duplicate the example's font section.
- Retain icon packages at lines 318–327, Doom Modeline at lines 329–335,
  Treemacs behavior at lines 470–583, and Org behavior at lines 604–625.

First review and publish the fork so the GitHub recipe can retrieve these
changes. Configuration edits and session activation remain separate next
steps requiring authorization; none were performed during validation.
