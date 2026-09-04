# dotfiles

Personal machine configuration, tracked in git and symlinked into place.

## Layout

Each top-level directory is a "package" that mirrors its target location. Files are
symlinked from here into their real locations, so edits are version-controlled.

| Package    | Real location                     | Tracked file(s)                                  |
|------------|-----------------------------------|--------------------------------------------------|
| `herdr/`   | `~/.config/herdr/config.toml`     | `config.toml`                                    |
| `vscode/`  | machine-specific (manual copy)    | `settings-local.json`, `settings-server.json`    |
| `.vim/`    | `~/.vim/colors/`                  | `wombat256-{base,local,server}.vim`              |
| (root)     | `~/.bashrc`, `~/.vimrc`, `~/.tmux.conf` | `.bashrc`, `.vimrc`, `.tmux.conf`          |

## Fresh-machine setup

```sh
git clone <this-repo> ~/dotfiles
cd ~/dotfiles
./install.sh          # symlinks bash/vim/tmux + herdr config into place
```

`install.sh` creates `~/.config/herdr/` and symlinks `herdr/config.toml` into it. VSCode
settings are still copied manually (see `vscode/README.md`) — the script prints a reminder.

Verify herdr picked up the config:

```sh
herdr config check    # -> config: ok
```

If you later adopt [GNU Stow](https://www.gnu.org/software/stow/), this layout already
works as stow packages: `cd ~/dotfiles && stow herdr` recreates the symlink for you.

---

# herdr

[herdr](https://herdr.dev) is a terminal workspace manager for AI coding agents — a
mouse-first, agent-aware multiplexer. Panes, tabs, and workspaces are driven from a
clickable UI, with agent state surfaced in a sidebar. Config lives in a single TOML file.

- **Config path:** `~/.config/herdr/config.toml` (Linux/macOS) — overridable with
  `HERDR_CONFIG_PATH`. Herdr runs fine with no config file at all; every key below is
  optional and falls back to a built-in default.
- **Reference:** <https://herdr.dev/docs/config-reference/>
- **Agent guide:** <https://herdr.dev/agent-guide.md>

## Prerequisites that aren't obvious

1. **Use a true-color terminal (Ghostty / iTerm2).** macOS Terminal.app silently drops
   24-bit `[theme.custom]` color overrides — `config check` passes, reload says `applied`,
   but nothing renders. Verify truecolor:
   ```sh
   printf '\e[38;2;255;100;0mTRUECOLOR\e[0m\n'   # must print in orange
   echo "COLORTERM=$COLORTERM"                    # want: truecolor
   ```
2. **The teal theme recipe** = base `tokyo-night` + `[theme.custom] accent` (drives the
   active-tab indicator + side-nav accents). The active-tab indicator is driven by the
   theme `accent` token — confirmed via diagnostic probe in Ghostty: setting `accent`
   yellow turned the active tab yellow. Set it teal for a current-tab highlight that
   matches the side-nav aesthetic. This only renders in a true-color terminal.

## Config reference

Everything below is optional. Print the full built-in defaults any time with
`herdr --default-config`. What *this* repo actually sets is called out under each section.

### `[theme]`

| Key            | Values                                                                                                   | Default        |
|----------------|----------------------------------------------------------------------------------------------------------|----------------|
| `name`         | `catppuccin`, `terminal`, `tokyo-night`, `dracula`, `nord`, `gruvbox`, `one-dark`, `solarized`, `kanagawa`, `rose-pine`, `vesper` | `catppuccin`   |
| `auto_switch`  | `true` / `false` — follow the host terminal's light/dark appearance                                      | `false`        |
| `dark_name`    | theme used when `auto_switch` resolves to dark                                                            | —              |
| `light_name`   | theme used when `auto_switch` resolves to light                                                           | —              |

**This repo:** `name = "tokyo-night"` (gives the colored top tab bar).

### `[theme.custom]`

Override individual color tokens on top of the base theme. Values accept hex
(`#RRGGBB` / `#RGB`), named colors (`cyan`), `rgb(r,g,b)`, or reset aliases.

Overridable tokens: `accent`, `sidebar_bg`, `active_row_bg`, `selection_bg`, `panel_bg`,
`green`, `blue`, `red`, `yellow`, `teal`, `peach`, `mauve`, `text`, `subtext0`,
`surface0`, `surface1`, `surface_dim`, `overlay0`, `overlay1`.

**This repo:** `accent = "#7dcfff"` — tokyo-night's native teal/cyan, driving the
active-tab indicator. (Swap to `#94e2d5` for the old catppuccin teal.)

### `[ui]`

| Key                        | Values / notes                                              | Default   |
|----------------------------|-------------------------------------------------------------|-----------|
| `sidebar_width`            | columns                                                      | `26`      |
| `sidebar_min_width`        | columns                                                      | `18`      |
| `sidebar_max_width`        | columns                                                      | `36`      |
| `sidebar_start_collapsed`  | `true` / `false`                                            | `false`   |
| `sidebar_collapsed_mode`   | `compact` / `hidden`                                        | —         |
| `mouse_capture`            | `true` / `false`                                            | `true`    |
| `copy_on_select`           | auto-copy on drag                                          | `true`    |
| `pane_borders`             | draw pane borders                                          | `true`    |
| `pane_scrollbars`          | show pane scrollbars                                       | `true`    |
| `pane_gaps`                | visual separation between panes                           | `true`    |
| `tab_bar_position`         | `top` / `bottom`                                           | `top`     |
| `hide_tab_bar_when_single_tab` | `true` / `false`                                       | `false`   |
| `agent_panel_sort`         | `spaces` / `priority`                                     | `spaces`  |
| `status_indicators`        | `dots` / `symbols`                                        | `dots`    |
| `window_title`             | template: `{hostname}` `{workspace}` `{tab}` `{pane}` `{terminal_title}` | — |

**This repo:** `accent = "#94e2d5"` — explicit catppuccin teal (a true 24-bit hex, not the
named `cyan`, which resolves from the terminal's ANSI palette and can render dim) for the
active-row / indicator highlights.

Subsections: `[ui.sidebar.agents]` and `[ui.sidebar.spaces]` (row layout via `rows`,
`row_gap`, `rows_by_agent`), `[ui.toast]` (`delivery` = `herdr`/`terminal`/`system`/`off`,
`delay_seconds`), `[ui.sound]` (`enabled`, `path`, `done_path`, `request_path`, per-agent
overrides under `agents.<name>`).

### `[keys]`

`prefix` defaults to `ctrl+b`. Every action — including the prefix itself — is rebindable,
and a value can be a single string or an array of strings (multiple bindings for one
action). Punctuation is named by the character it produces (`double_quote`, `percent`,
`minus`, …) since a literal `"` would terminate the TOML string. `prefix+?` shows all
active bindings live; `herdr config reset-keys` restores defaults (backing up your config).

Common defaults: `split_vertical = prefix+v`, `split_horizontal = prefix+minus`,
`focus_pane_{left,down,up,right} = prefix+{h,j,k,l}`, `new_tab = prefix+c`,
`next_tab = prefix+n`, `previous_tab = prefix+p`, `switch_tab = prefix+1..9`,
`zoom = prefix+z`, `copy_mode = prefix+[`, `reload_config = prefix+shift+r`.

**This repo** remaps vim motions for a one-full-screen-pane-per-view workflow:

| Binding                    | Action                                    |
|----------------------------|-------------------------------------------|
| `prefix+h` / `prefix+l`    | previous / next **tab** (horizontal bar)  |
| `prefix+j` / `prefix+k`    | next / previous **workspace** (sidebar)   |
| `prefix+space` / `+shift+space` | next / previous **agent**            |
| `prefix+shift+{h,j,k,l}`   | focus pane left/down/up/right             |
| `prefix+"` (`double_quote`)| split horizontal (stacked)  [tmux `"`]    |
| `prefix+%` (`percent`)     | split vertical (side-by-side)  [tmux `%`] |

Defaults (`prefix+p/n`, `prefix+minus/v`, arrow keys) are kept as fallbacks. The shifted
pane motions rely on the Kitty keyboard protocol (Ghostty reports `shift+letter`
distinctly); arrows are the fallback where that disambiguation doesn't come through.

`[[keys.command]]` (array-of-tables) binds custom commands: `key`, `type`
(`popup`/`pane`/`shell`/`plugin_action`), `command`, `description`, and `width`/`height`
for popups. Command env: `HERDR_ACTIVE_{WORKSPACE,TAB,PANE}_ID`, `HERDR_ACTIVE_PANE_CWD`,
`HERDR_SOCKET_PATH`, `HERDR_BIN_PATH`.

### `[terminal]`

| Key             | Values                                              | Default            |
|-----------------|-----------------------------------------------------|--------------------|
| `default_shell` | executable or path                                  | `$SHELL` → `/bin/sh` |
| `shell_mode`    | `auto` / `login` / `non_login`                      | `auto`             |
| `new_cwd`       | `follow` / `home` / `current` / a fixed path        | `follow`           |

### Other sections

| Section          | Notable keys (defaults)                                                              |
|------------------|-------------------------------------------------------------------------------------|
| `[server]`       | `headless_cols` (`120`), `headless_rows` (`40`) — virtual size with no client attached |
| `[worktrees]`    | `directory` (`~/.herdr/worktrees`) — root for git worktree checkouts                 |
| `[remote]`       | `manage_ssh_config` (`true`) — temporary SSH keepalive/connection reuse              |
| `[session]`      | `resume_agents_on_restore` (`true`) — resume agent conversations after restart       |
| `[update]`       | `channel` (`stable`/`preview`), `version_check` (`true`), `manifest_check` (`true`)  |
| `[advanced]`     | `scrollback_limit_bytes` (`10000000`) — max scrollback buffer per pane               |
| `[experimental]` | `allow_nested`, `kitty_graphics`, `pane_history`, CJK-IME toggles — all `false`      |

## Applying changes

```sh
herdr --default-config          # print full built-in defaults (starting point for edits)
herdr config check              # validate the config file
herdr server reload-config      # apply edits to a running server (or prefix+shift+r)
```

Environment overrides: `HERDR_CONFIG_PATH` (config location), `HERDR_SESSION` (named
session for CLI), `HERDR_LOG` (e.g. `herdr=debug`), `HERDR_DISABLE_SOUND`. Logs land in
`~/.config/herdr/herdr{,-client,-server}.log`. Inside a herdr pane, `HERDR_ENV=1`.
