vim.g.neo_tree_remove_legacy_commands = 1
vim.g.nvim_tree_quit_on_open = 1

require('nvim-tree').setup {
  update_to_buf_dir = {
    enable = false,
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 50,
    auto_resize = true,
  },
}
