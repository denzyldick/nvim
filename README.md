# Neovim Configuration

Personal Neovim configuration for full-stack development with **PHP**, **Rust**, **JavaScript/TypeScript**, **Vue.js**, and **Go**.

## Features

| Feature | Tool |
|---------|------|
| **Plugin Manager** | lazy.nvim |
| **LSP** | nvim-lspconfig + mason (auto-install) |
| **Completion** | blink.cmp + LuaSnip + friendly-snippets |
| **Formatting** | conform.nvim (on save) |
| **Linting** | nvim-lint |
| **Debugging** | nvim-dap + nvim-dap-ui |
| **Fuzzy Finding** | telescope.nvim |
| **Syntax** | nvim-treesitter (auto-install) |
| **Git** | Neogit + gitsigns + diffview |
| **AI Assistant** | opencode.nvim (big-pickle model) |
| **Theme** | tokyonight (night/day toggle) |
| **Auto-reload** | Config auto-sources on save |
| **Pre-push hooks** | Lua syntax, formatting, keymap checks |

## Requirements

- Neovim >= 0.10
- `git`, `make`, `unzip`, C compiler (`gcc`)
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

### Opencode (AI)

| Key | Action |
|-----|--------|
| `<leader>oa` | Ask opencode |
| `<leader>os` | Select opencode action |
| `go` | Append range to opencode |

### File Explorer

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle neo-tree (left side) |

Neo-tree opens automatically on the left when Neovim starts without arguments.

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
- **LSP**: ts_ls
- **Formatter**: Prettier
- **Linter**: ESLint
- **Debug**: js-debug-adapter (pwa-node)

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
