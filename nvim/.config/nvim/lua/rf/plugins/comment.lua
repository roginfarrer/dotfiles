require('Comment').setup {
  pre_hook = function(ctx)
    local U = require 'Comment.utils'
    local ty = ctx.ctype == U.ctype.line and 'single' or 'multi'
    return require('ts_context_commentstring.internal').calculate_commentstring(
      ty
    )
  end,
}
