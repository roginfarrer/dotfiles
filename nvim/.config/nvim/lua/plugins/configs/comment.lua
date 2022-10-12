local ft = require 'Comment.ft'

require('Comment').setup {
  -- ignore empty lines
  ignore = '^$',
  ---@param ctx Ctx
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

-- ft({ 'scss', 'sass' }, { '//%s', '/*%s*/' })
