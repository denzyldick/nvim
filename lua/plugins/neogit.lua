-- Neogit: full Git UI inside Neovim (like Magit)
-- Diffview: side-by-side diffs and merge conflict resolution
--
-- Keymaps:
--   <leader>gs  Open Neogit status
--   <leader>ga  Git add current file
--   <leader>gd  Open Diffview (diffs, merge conflicts)
--
-- Merge conflict resolution:
--   1. After `git pull` with conflicts, run <leader>gd
--   2. Navigate conflicted files in the diff panel
--   3. Use :DiffviewFocusLeft / :DiffviewFocusRight to choose ours/theirs
--   4. Save resolved files and run :DiffviewClose

return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    keys = {
      { '<leader>gs', function() require('neogit').open() end, desc = '[G]it [S]tatus (Neogit)' },
      { '<leader>ga', function() require('neogit').action('stage_all') end, desc = '[G]it [A]dd all' },
    },
    opts = {
      integrations = {
        diffview = true,
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
