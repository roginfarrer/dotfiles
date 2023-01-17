return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    signs = {
      add = { hl = 'GitGutterAdd', text = '▋' },
      change = { hl = 'GitGutterChange', text = '▋' },
      delete = { hl = 'GitGutterDelete', text = '▋' },
      topdelete = { hl = 'GitGutterDeleteChange', text = '▔' },
      changedelete = { hl = 'GitGutterChange', text = '▎' },
    },
    keymaps = {},
  },
  keys = {
    { '<leader>gj', "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = 'Next Hunk' },
    { '<leader>gk', "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = 'Prev Hunk' },
    { '<leader>gl', "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = 'Blame' },
    { '<leader>gp', "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = 'Preview Hunk' },
    { '<leader>gr', "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = 'Reset Hunk' },
    { '<leader>gR', "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = 'Reset Buffer' },
    { '<leader>gs', "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = 'Stage Hunk' },
    { '<leader>gu', "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = 'Undo Stage Hunk' },
  },
}
