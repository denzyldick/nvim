# Neovim Configuration

Personal Neovim configuration for full-stack development with **PHP**, **Rust**, **JavaScript/TypeScript**, **Vue.js**, and **Go**.

## Features

| Feature | Tool |
|---------|------|
| **Plugin Manager** | lazy.nvim |
| **LSP** | nvim-lspconfig + mason (auto-install) + typescript-tools.nvim |
| **Completion** | blink.cmp + LuaSnip + friendly-snippets |
| **Formatting** | conform.nvim (on save) |
| **Linting** | nvim-lint |
| **Debugging** | nvim-dap + nvim-dap-ui |

| **Fuzzy Finding** | telescope.nvim |
| **Motion** | flash.nvim (f/t, treesitter jumps) |
| **Syntax** | nvim-treesitter + textobjects (auto-install) |
| **Git** | Neogit + gitsigns + diffview |
| **Diagnostics** | trouble.nvim (unified panel) |
| **Markdown Preview** | markdown-preview.nvim |
| **File System** | neo-tree + oil.nvim (buffer editing) |
| **Terminal** | toggleterm.nvim (floating/split) |
| **Session** | auto-session (auto-save/restore) |
| **Clipboard** | yanky.nvim (yank ring) |
| **Code Outline** | aerial.nvim (symbols sidebar) |
| **Color Preview** | nvim-colorizer.lua |
| **Bracketed Nav** | mini.bracketed ([b, [q, [a, etc.) |
| **AI Assistant** | opencode.nvim (big-pickle model) |
| **Theme** | tokyonight (night/day toggle) |
| **Auto-reload** | Config auto-sources on save |
| **Pre-push hooks** | Lua syntax, formatting, keymap checks |

## Requirements

- Neovim >= 0.10
- `git`, `make`, `unzip`, C compiler (`gcc`), `node`
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- A [Nerd Font](https://www.nerdfonts.com/) (recommended for icons)
- Language-specific tools:
  - **PHP**: PHP CLI + [Xdebug](https://xdebug.org/) (for debugging)
  - **Rust**: `rustup` + `rustc`
  - **JS/TS/Vue**: `node` + `npm`
  - **Go**: `go`

## Installation

```bash
git clone git@github.com:denzyldick/nvim.git ~/.config/nvim && nvim
```

### Optional: Opencode CLI

For AI features, install the opencode CLI:

```bash
curl -fsSL https://opencode.ai/install | bash
```

## Keymaps Reference

### General

| Key | Action |
|-----|--------|
| `<Esc>` | Clear search highlights |
| `<leader>q` | Open diagnostic quickfix list |
| `[d` / `]d` | Previous/next diagnostic |
| `[e` / `]e` | Previous/next error |
| `<C-h/j/k/l>` | Navigate windows |

**Leader key** is `<space>`. Press it to see all available commands via which-key.

### LSP

| Key | Action |
|-----|--------|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | Find references |
| `grd` | Go to definition |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |
| `<leader>f` | Format buffer |

### Search (Telescope)

| Key | Action |
|-----|--------|
| `<leader>sh` | Search help |
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Search current word |
| `<leader>sd` | Search diagnostics |
| `<leader><leader>` | Find buffers |
| `<leader>s.` | Recent files |
| `<leader>/` | Fuzzily search in buffer |

### Lazy (Plugin Manager)

| Key | Action |
|-----|--------|
| `<leader>ll` | Open lazy.nvim UI |
| `<leader>lc` | Check for updates |
| `<leader>lu` | Update plugins |
| `<leader>ls` | Sync plugins |
| `<leader>lC` | Clean unused plugins |
| `<leader>lr` | Reload config |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit (terminal UI) |
| `<leader>gs` | Neogit status |
| `<leader>ga` | Git add all |
| `<leader>gd` | Diffview (diffs/conflicts) |
| `<leader>gc` | Telescope git commits |
| `<leader>gb` | Telescope git branches |
| `]c` / `[c` | Next/prev git hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |

### Debug

| Key | Action |
|-----|--------|
| `<F5>` | Start/Continue |
| `<F1>` | Step into |
| `<F2>` | Step over |
| `<F3>` | Step out |
| `<F7>` | Toggle DAP UI |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Set conditional breakpoint |

### TypeScript

| Key | Action |
|-----|--------|
| `<leader>to` | Organize imports |
| `<leader>ti` | Add missing imports |
| `<leader>tr` | Rename file + update imports |
| `<leader>tf` | Fix all diagnostics |
| `<leader>tu` | Remove unused imports |
| `<leader>ts` | Sort imports |


### Diagnostics (Trouble)

| Key | Action |
|-----|--------|
| `<leader>xx` | Diagnostics (workspace) |
| `<leader>xb` | Diagnostics (buffer) |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xs` | Document symbols |

### Code Outline (Aerial)

| Key | Action |
|-----|--------|
| `<leader>ca` | Toggle code outline sidebar |
| `<leader>cs` | Toggle symbol navigation |

### Terminal

| Key | Action |
|-----|--------|
| `<leader>tt` | Toggle floating terminal |
| `<leader>th` | Toggle horizontal terminal |
| `<leader>tv` | Toggle vertical terminal |
| `<C-\>` | Toggle floating terminal (global) |

### Motions (Flash)

| Key | Action |
|-----|--------|
| `s` | Flash jump (anywhere on screen) |
| `S` | Flash treesitter (select node) |
| `r` | Flash remote (remote editing) |
| `R` | Flash treesitter search |

### Bracketed Navigation (mini.bracketed)

| Key | Action |
|-----|--------|
| `]b` / `[b` | Next/prev buffer |
| `]q` / `[q` | Next/prev quickfix |
| `]a` / `[a` | Next/prev argument |
| `]w` / `[w` | Next/prev window |
| `]d` / `[d` | Next/prev diagnostic |

### Filesystem (Oil)

| Key | Action |
|-----|--------|
| `-` | Open parent directory as editable buffer |

### File Explorer

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle neo-tree (left side) |

Neo-tree opens automatically on the left when Neovim starts without arguments.

### Markdown

| Key | Action |
|-----|--------|
| `<leader>mp` | Toggle markdown preview in browser |

Preview opens with live reload. Only available in markdown files.

### Opencode (AI)

| Key | Action |
|-----|--------|
| `<leader>oa` | Ask opencode |
| `<leader>os` | Select opencode action |
| `go` | Append range to opencode |

### UI

| Key | Action |
|-----|--------|
| `<leader>u` | Toggle theme (night/day) |

## Languages

### PHP
- **LSP**: PHPantom (Rust-based)
- **Formatter**: Mago
- **Linter**: Mago
- **Debug**: php-debug (Xdebug)

### Rust
- **LSP**: rust-analyzer
- **Formatter**: rustfmt
- **Debug**: codelldb

### JavaScript / TypeScript
- **LSP**: typescript-tools.nvim (wraps tsserver with advanced features)
- **Formatter**: Prettier (via conform.nvim)
- **Linter**: ESLint (via nvim-lint)
- **Debug**: js-debug-adapter (pwa-node)
- **Features**: Auto-imports, organize imports, rename file + update imports, inlay hints

### Vue.js
- **LSP**: Volar
- **Formatter**: Prettier
- **Linter**: ESLint
- **Debug**: js-debug-adapter (pwa-node)

### Go
- **LSP**: gopls
- **Formatter**: goimports + gofumpt
- **Debug**: delve

## Customizing

- **Add a language**: Add LSP server, formatter, linter, and treesitter parser in `init.lua`
- **Add plugins**: Create a file in `lua/plugins/` — it loads automatically
- **Change keymaps**: Find the relevant section in `init.lua` and edit the key
- **Toggle features**: Comment out plugin imports in the lazy setup block
