return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    -- using "config" instead of "opts" because requiring ts_context_commentstring throws error
    require('Comment').setup {
      -- ignore empty lines
      ignore = '^$',
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }
  end,
}
