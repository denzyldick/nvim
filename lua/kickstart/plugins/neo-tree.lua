-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>e', ':Neotree position=left reveal<CR>', desc = '[E]xplorer', silent = true },
  },
  opts = {
    default_component_configs = {
      icon_padding = ' ',
    },
    filesystem = {
      window = {
        mappings = {
          ['<leader>e'] = 'close_window',
        },
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('neo-tree-autopen', { clear = true }),
      desc = 'Open neo-tree on the left on startup',
      once = true,
      callback = function()
        if #vim.fn.argv() == 0 then
          vim.cmd('Neotree position=left')
        end
      end,
    })
  end,
}
