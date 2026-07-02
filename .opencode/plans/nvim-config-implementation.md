# Nvim Config Implementation

## Step 1: Delete kickstart remnants
```bash
rm -rf doc/ .github/ LICENSE.md
```

## Step 2: init.lua — Full replacement
Replace the entire file with the content from the `init.lua` section below.

## Step 3: Update plugin files
Update `lua/kickstart/plugins/debug.lua` and `lua/kickstart/plugins/lint.lua`
Create new files in `lua/custom/plugins/`

## Step 4: Create opencode.json and README.md

---

## init.lua

```lua
--[[
  Neovim Configuration
  ====================

  Languages: PHP, Rust, JavaScript/TypeScript, Vue.js, Go
  Features:
    - LSP auto-install via mason
    - Formatting on save (conform.nvim)
    - Linting (nvim-lint)
    - Debugging (nvim-dap) for all languages
    - Completion (blink.cmp + LuaSnip snippets)
    - Fuzzy finding (telescope.nvim)
    - Git (Neogit + gitsigns + diffview)
    - Opencode AI assistant integration
    - Theme toggle (tokyonight night/day)
    - Auto-update packages on boot
    - which-key shows all keybindings on <space>

  How to customize:
    - LSP servers: edit the `servers` table in the LSP config section
    - Formatters: edit conform's `formatters_by_ft`
    - Treesitter: edit `ensure_installed` in the treesitter plugin spec
    - Keymaps: find the relevant section and change the key/action
    - Add plugins: create a file in `lua/custom/plugins/` (auto-loaded)
--]]

-- Leader key — must be set before plugins load
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed (recommended for icons)
vim.g.have_nerd_font = true

-- [[ Editor Options ]]
-- See `:help vim.o` for all available options

vim.o.number = true          -- Show line numbers
vim.o.mouse = 'a'            -- Enable mouse in all modes
vim.o.showmode = false        -- Don't show mode (already in statusline)
vim.o.breakindent = true      -- Preserve indent when wrapping lines
vim.o.undofile = true         -- Persistent undo history
vim.o.ignorecase = true      -- Case-insensitive search
vim.o.smartcase = true       -- Unless uppercase in search term
vim.o.signcolumn = 'yes'     -- Always show sign column (diagnostics, git)
vim.o.updatetime = 250        -- Faster update time for CursorHold etc.
vim.o.timeoutlen = 300       -- Time to wait for mapped sequence
vim.o.splitright = true      -- New vertical splits go right
vim.o.splitbelow = true      -- New horizontal splits go below
vim.o.list = true            -- Show whitespace characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'   -- Live preview of substitutions
vim.o.cursorline = true      -- Highlight current line
vim.o.scrolloff = 10         -- Keep 10 lines visible above/below cursor
vim.o.confirm = true         -- Ask to save before :q if unsaved changes

-- Sync clipboard with OS (scheduled after UiEnter for startup perf)
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- [[ Basic Keymaps ]]

-- Clear search highlights with Escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic quickfix list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Diagnostic navigation — jump between errors/warnings
-- ]d / [d  next/prev diagnostic
-- ]e / [e  next/prev error
-- ]w / [w  next/prev warning
vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = 1, float = true } end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = -1, float = true } end, { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']e', function() vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR, float = true } end, { desc = 'Next error' })
vim.keymap.set('n', '[e', function() vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR, float = true } end, { desc = 'Prev error' })

-- Exit terminal mode with double Escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation with Ctrl + hjkl
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })

-- [[ Autocommands ]]

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('nvim-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Auto-update plugins on boot — silently checks for updates and notifies
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Check for plugin updates on startup',
  group = vim.api.nvim_create_augroup('nvim-auto-update', { clear = true }),
  once = true,
  callback = function()
    -- Run :Lazy check in the background, notify if updates available
    vim.schedule(function()
      require('lazy').check()
    end)
  end,
})

-- [[ Plugin Manager: lazy.nvim ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require('lazy').setup({

  -- Detect tabstop and shiftwidth automatically
  'NMAC427/guess-indent.nvim',

  -- Git signs in the gutter (+, ~, _)
  -- Enhanced keymaps available when gitsigns plugin file is enabled
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- which-key: shows available keybindings when you press <space> (or any leader prefix)
  --   The popup appears after `delay` ms showing all possible completions
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ', Down = '<Down> ', Left = '<Left> ', Right = '<Right> ',
          C = '<C-…> ', M = '<M-…> ', D = '<D-…> ', S = '<S-…> ',
          CR = '<CR> ', Esc = '<Esc> ', ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ', NL = '<NL> ', BS = '<BS> ',
          Space = '<Space> ', Tab = '<Tab> ', F1 = '<F1>', F2 = '<F2>',
          F3 = '<F3>', F4 = '<F4>', F5 = '<F5>', F6 = '<F6>', F7 = '<F7>',
          F8 = '<F8>', F9 = '<F9>', F10 = '<F10>', F11 = '<F11>', F12 = '<F12>',
        },
      },
      -- Register key groups so which-key shows nice labels like "[S]earch", "[T]oggle"
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]it' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>o', group = '[O]pencode' },
        { '<leader>u', group = '[U]I' },
      },
    },
  },

  -- Telescope: fuzzy finder for files, grep, LSP, git, etc.
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'

      -- [S]earch group
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Git pickers
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [C]ommits' })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [B]ranches' })

      -- Fuzzy search in current buffer
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10, previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Live grep in open files
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Search Neovim config files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- [[ LSP Configuration ]]
  -- All LSP servers, formatters, and linters auto-install via mason on first boot
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason: portable package manager for LSP servers, formatters, linters, debuggers
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      -- This function runs whenever an LSP attaches to a buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('nvim-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename symbol under cursor
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          -- Code actions (e.g. auto-fix, refactor)
          --   Usage: place cursor on an error/warning and press gra
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          -- References: where is this symbol used?
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          -- Jump to implementation
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          -- Jump to definition
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          -- Jump to declaration (e.g. header file)
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          -- Document symbols (functions, classes, etc. in current file)
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          -- Workspace symbols (across the whole project)
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          -- Type definition
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Helper to check if client supports a method (works in 0.10 and 0.11)
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- Auto-highlight references when cursor rests
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local hl_group = vim.api.nvim_create_augroup('nvim-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf, group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf, group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('nvim-lsp-detach', { clear = true }),
              callback = function(e)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'nvim-lsp-highlight', buffer = e.buf }
              end,
            })
          end

          -- Toggle inlay hints (<leader>th)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic display configuration
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(d)
            return d.message
          end,
        },
      }

      -- blink.cmp LSP capabilities
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- [[ LSP Servers ]]
      -- To add a new language server:
      --   1. Find the server name in `:help lspconfig-server`
      --   2. Add an entry to the `servers` table below
      --   3. The server will auto-install and attach on file open
      --
      -- To remove a server, just delete (or comment out) its entry
      local servers = {
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        -- PHP: PHPantom — a fast Rust-based PHP LSP
        -- https://github.com/AJenbo/phpantom_lsp
        phpantom = {},

        -- Rust
        rust_analyzer = {},

        -- JavaScript / TypeScript
        ts_ls = {},

        -- Vue.js
        volar = {},

        -- Go
        gopls = {},
      }

      -- Auto-install all servers and tools listed here
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- Formatters (by language — add new ones here)
        'stylua',       -- Lua
        'mago',         -- PHP (formatter + linter)
        'rustfmt',      -- Rust
        'prettier',     -- JavaScript / TypeScript / Vue
        'eslint_d',     -- JavaScript / TypeScript / Vue (linter)
        'goimports',    -- Go (imports)
        'gofumpt',      -- Go (formatting)

        -- Additional linters
        -- 'phpstan',    -- PHP static analysis (optional, mago covers this)
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  -- [[ Autoformat on save (conform.nvim) ]]
  -- To add a formatter for a new language:
  --   1. Add the formatter name under the correct filetype in `formatters_by_ft`
  --   2. Ensure it's also in mason-tool-installer's `ensure_installed` (above)
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable format-on-save for languages without good formatters
        -- Change this list if needed
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        php = { 'mago' },
        rust = { 'rustfmt' },
        javascript = { { 'prettierd', 'prettier' }, stop_after_first = true },
        typescript = { { 'prettierd', 'prettier' }, stop_after_first = true },
        javascriptreact = { { 'prettierd', 'prettier' }, stop_after_first = true },
        typescriptreact = { { 'prettierd', 'prettier' }, stop_after_first = true },
        vue = { { 'prettierd', 'prettier' }, stop_after_first = true },
        go = { 'goimports', 'gofumpt' },
        -- Add new formatters here:
        -- python = { "isort", "black" },
        -- json = { "prettier" },
        -- css = { "prettier" },
        -- yaml = { "prettier" },
        -- markdown = { "prettier" },
      },
    },
  },

  -- [[ Autocompletion (blink.cmp) ]]
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- friendly-snippets: provides code snippets for all languages
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },

  -- [[ Colorscheme: tokyonight ]]
  -- Supports night (dark) and day (light) variants
  -- Toggle with <leader>u
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        styles = { comments = { italic = false } },
      }
      -- Default: dark theme
      vim.g.tokyonight_style = 'night'
      vim.cmd.colorscheme 'tokyonight-night'

      -- Theme toggle helper: press <leader>u to switch between night and day
      vim.keymap.set('n', '<leader>u', function()
        if vim.g.tokyonight_style == 'night' then
          vim.g.tokyonight_style = 'day'
          vim.cmd.colorscheme 'tokyonight-day'
          vim.notify('Theme: tokyonight-day (light)')
        else
          vim.g.tokyonight_style = 'night'
          vim.cmd.colorscheme 'tokyonight-night'
          vim.notify('Theme: tokyonight-night (dark)')
        end
      end, { desc = '[U]I Toggle theme (night/day)' })
    end,
  },

  -- Highlight TODO, FIXME, NOTE, etc. in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- mini.nvim: collection of small plugins
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }          -- Better text objects (va), yinq, ci', etc.
      require('mini.surround').setup()                     -- Add/delete/replace surroundings (sa, sd, sr)
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      statusline.section_location = function() return '%2l:%-2v' end
    end,
  },

  -- [[ Treesitter: syntax highlighting, indentation, and code navigation ]]
  --   ensure_installed: parsers to auto-install on first boot
  --   auto_install: auto-install any parser when you open a file with that type
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
        'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
        -- Languages you work with:
        'php', 'rust', 'typescript', 'javascript', 'vue', 'go',
        -- Add more parsers here:
        -- 'python', 'ruby', 'json', 'yaml', 'toml', 'css', 'scss',
      },
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = { 'ruby' } },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  -- [[ Optional Plugin Imports ]]
  -- These files are in lua/kickstart/plugins/ and can be customized there
  -- To disable any of these, comment out the line below
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns',

  -- Custom plugins — add files to lua/custom/plugins/ and they load automatically
  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘', config = '🛠', event = '📅', ft = '📂',
      init = '⚙', keys = '🗝', plugin = '🔌', runtime = '💻',
      require = '🌙', source = '📄', start = '🚀', task = '📌', lazy = '💤 ',
    },
  },
})
```

## lua/kickstart/plugins/debug.lua — Extended version

Replace the file with:

```lua
-- debug.lua
--
-- Debugging configuration for all supported languages:
--   Go:     delve (via nvim-dap-go)
--   Rust:   codelldb (via mason-nvim-dap)
--   JS/TS:  vscode-js-debug (via mason-nvim-dap)
--   PHP:    php-debug (via mason-nvim-dap)
--
-- Keymaps:
--   <F5>     Continue
--   <F1>     Step Into
--   <F2>     Step Over
--   <F3>     Step Out
--   <F7>     Toggle DAP UI
--   <leader>b  Toggle breakpoint
--   <leader>B  Set conditional breakpoint

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
  },
  keys = {
    { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
    { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
    { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Toggle DAP UI' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Mason DAP: auto-installs debug adapters
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'delve',              -- Go
        'codelldb',           -- Rust
        'js-debug-adapter',   -- JavaScript / TypeScript
        'php-debug',          -- PHP
      },
    }

    -- DAP UI setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸', play = '▶', step_into = '⏎', step_over = '⏭',
          step_out = '⏮', step_back = 'b', run_last = '▶▶',
          terminate = '⏹', disconnect = '⏏',
        },
      },
    }

    -- Auto-open/close DAP UI on debug events
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Go DAP configuration (delve)
    require('dap-go').setup {
      delve = { detached = vim.fn.has 'win32' == 0 },
    }

    -- JavaScript/TypeScript DAP configuration
    -- Requires js-debug-adapter installed via mason
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = '127.0.0.1',
      port = '${port}',
      executable = {
        command = 'js-debug-adapter',
        args = { '${port}' },
      },
    }
    -- JS/TS debug configurations
    --   To debug: set a breakpoint, then press F5 and select the config
    for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' } do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
    end

    -- Rust DAP configuration (codelldb)
    dap.adapters['codelldb'] = {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'codelldb',
        args = { '--port', '${port}' },
      },
    }
    dap.configurations.rust = {
      {
        name = 'Launch (codelldb)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to binary: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    -- PHP DAP configuration (php-debug)
    -- Requires Xdebug to be installed and configured in PHP
    dap.adapters.php = {
      type = 'executable',
      command = 'php-debug-adapter',
      args = {},
    }
    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003,
        pathMappings = {
          ['/var/www/html'] = '${workspaceFolder}',
        },
      },
    }
  end,
}
```

## lua/kickstart/plugins/lint.lua — Extended version

Replace the file with:

```lua
-- nvim-lint: run linters on save and when entering a buffer
--
-- To add a linter for a new language:
--   1. Add it to `linters_by_ft` below
--   2. Make sure it's installed (either via mason or system package)
--   3. Restart Neovim

return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Configure linters by filetype
      --   Format: filetype = { 'linter-name' }
      --   Run :Mason to see available linters, or :help lint for docs
      lint.linters_by_ft = {
        -- Default linters (kickstart defaults)
        markdown = { 'markdownlint' },

        -- PHP — mago acts as both formatter AND linter
        php = { 'mago' },

        -- JavaScript / TypeScript / Vue
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        javascriptreact = { 'eslint' },
        typescriptreact = { 'eslint' },
        vue = { 'eslint' },

        -- Add more linters here:
        -- python = { 'pylint' },
        -- ruby = { 'rubocop' },
        -- json = { 'jsonlint' },
        -- css = { 'stylelint' },
        -- go = { 'golangci-lint' },
        -- rust = { 'clippy' },
      }

      -- Run linter on BufEnter, BufWritePost, and InsertLeave
      local lint_augroup = vim.api.nvim_create_augroup('nvim-lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
```

## lua/custom/plugins/opencode.lua

```lua
-- opencode.nvim — AI assistant integration
--
-- Requires the opencode CLI (install separately):
--   curl -fsSL https://opencode.ai/install | bash
--
-- The AI model is configured in opencode.json in the project root
-- Currently using: opencode/big-pickle (free model via OpenCode Zen)
--
-- Keymaps:
--   <leader>oa  Ask opencode about current selection/buffer
--   <leader>os  Select opencode action from menu
--   go          Append visual range or current line to opencode context

return {
  'nickjvandyke/opencode.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>oa', function() require('opencode').ask('@this: ') end, desc = '[O]pencode [A]sk', mode = { 'n', 'x' } },
    { '<leader>os', function() require('opencode').select() end, desc = '[O]pencode [S]elect', mode = { 'n', 'x' } },
    { 'go', function() return require('opencode').operator('@this ') end, desc = 'Append range to opencode', expr = true, mode = { 'n', 'x' } },
  },
  opts = {},
}
```

## lua/custom/plugins/neogit.lua

```lua
-- Neogit: full Git UI inside Neovim (like Magit)
-- Diffview: side-by-side diffs and merge conflict resolution
--
-- Keymaps:
--   <leader>gg  Open Neogit status
--   <leader>ga  Git add current file
--   <leader>gd  Open Diffview (diffs, merge conflicts)
--
-- Merge conflicts:
--   1. After `git pull` with conflicts, run <leader>gd
--   2. Navigate conflicted files in the diff panel
--   3. Use :DiffviewFocusLeft / :DiffviewFocusRight to choose ours/theirs
--   4. Save and run :DiffviewClose

return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    keys = {
      { '<leader>gg', function() require('neogit').open() end, desc = '[G]it [G] status (Neogit)' },
      { '<leader>ga', function() require('neogit').action('stage_all') end, desc = '[G]it [A]dd all' },
    },
    opts = {
      -- Integrations
      integrations = {
        diffview = true,  -- Use diffview for diffs instead of neogit's built-in
      },
    },
  },
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>gd', function() require('diffview').open() end, desc = '[G]it [D]iff (Diffview)' },
    },
    opts = {},
  },
}
```

## opencode.json (project root)

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "opencode/big-pickle"
}
```

## README.md

Replace with a README that documents YOUR configuration, not kickstart's.
