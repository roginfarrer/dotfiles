return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local pairs = require 'nvim-autopairs'
    local cmp = require 'cmp'

    pairs.setup {
      fast_wrap = {},
      disable_filetype = { 'TelescopePrompt', 'vim' },
      check_ts = true,
      ts_config = {
        lua = { 'string' }, -- it will not add pair on that treesitter node
        javascript = { 'template_string' },
      },
    }

    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done { map_char = { tex = '' } }
    )
  end,
}
