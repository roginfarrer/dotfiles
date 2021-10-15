vim.g.nvim_tree_quit_on_open = 1

require('nvim-tree').setup({
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 50,
    auto_resize = true,
  },
})
