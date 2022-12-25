require('noice').setup {
  cmdline = {
    view = 'cmdline',
  },
  -- messages = {
  --   enabled = false,
  -- },
  -- messages = {
  --   enabled = false,
  -- },
  lsp = {
    override = {
      -- override the default lsp markdown formatter with Noice
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      -- override the lsp markdown formatter with Noice
      ['vim.lsp.util.stylize_markdown'] = true,
      -- override cmp documentation with Noice (needs the other options to work)
      ['cmp.entry.get_documentation'] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
  routes = {
    -- hide "written" messages
    {
      filter = {
        event = 'msg_show',
        kind = '',
        find = 'written',
      },
      opts = { skip = true },
    },
  },
}
