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
      --   Run :Mason to see available linters
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },

        -- PHP
        php = { 'phpstan' },

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
