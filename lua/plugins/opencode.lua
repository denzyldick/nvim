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

return {
  'nickjvandyke/opencode.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>oa', function() require('opencode').ask('@this: ') end, desc = '[O]pencode [A]sk', mode = { 'n', 'x' }, icon = '󰚩' },
    { '<leader>os', function() require('opencode').select() end, desc = '[O]pencode [S]elect', mode = { 'n', 'x' }, icon = '󰚩' },
  },
  -- no setup() needed — plugin is configured via keymaps and opencode.json
}
