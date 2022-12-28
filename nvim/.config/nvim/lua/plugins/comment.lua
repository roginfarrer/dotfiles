return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  config = {
    -- ignore empty lines
    ignore = '^$',
    -- pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  },
}
