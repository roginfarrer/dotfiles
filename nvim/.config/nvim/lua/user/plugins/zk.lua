require('zk').setup {
  -- create user commands such as :ZkNew
  create_user_commands = true,

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { 'zk', 'lsp' },
      name = 'zk',
      -- init_options = ...
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { 'markdown', 'telekasten', 'zk' },
    },
  },
}
require('telescope').load_extension 'zk'

-- _G.zk_maps = function()
--   -- inoremap('[[', "<ESC>:lua require('telekasten').insert_link({i=true})<CR>")
--   vim.cmd [[set ft=markdown.zk]]
--   nnoremap('gf', function()
--     require('telekasten').follow_link()
--   end)
-- end
-- vim.cmd [[
--   augroup zk
--     autocmd!
--     autocmd BufEnter */Obsidian/*.md lua _G.zk_maps()
--   augroup END
-- ]]

require('which-key').register({
  z = {
    name = 'ZK',
    n = {
      function()
        local title = vim.fn.input 'Title: '
        require('zk').new(nil, { title = title })
      end,
      'New Note',
    },
    f = { '<cmd>ZkList<CR>', 'Find Notes' },
    g = {
      function()
        require('telescope.builtin').live_grep {
          cwd = vim.fn.expand '$ZK_NOTEBOOK_DIR',
          prompt_title = 'Grep ZK Notes',
        }
      end,
      'Grep Notes',
    },
    w = {
      function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.expand '$ZK_NOTEBOOK_DIR/weekly',
          prompt_title = 'Find Weekly Notes',
          path_display = function(_, path)
            -- Just the filename, eg filename.md
            local tail = require('telescope.utils').path_tail(path)
            -- chop of the extension
            return string.match(tail, '(.*)%.')
          end,
        }
      end,
      'Find Weekly Notes',
    },
    t = {
      function()
        require('zk').new(nil, { group = 'daily', dir = 'daily' })
      end,
      'Goto Today',
    },
    d = {
      function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.expand '$ZK_NOTEBOOK_DIR/daily',
          prompt_title = 'Find Daily Notes',
          path_display = function(_, path)
            local tail = require('telescope.utils').path_tail(path)
            return string.match(tail, '(.*)%.')
          end,
        }
      end,
      'Find Daily Notes',
    },
    T = {
      function()
        require('zk').new(nil, { group = 'weekly', dir = 'weekly' })
      end,
      'Goto Today',
    },
  },
}, {
  prefix = '<leader>',
})

require('which-key').register({
  z = {
    name = 'ZK',
    c = {
      require('zk').new_link,
      'Create note from selection',
    },
  },
}, {
  prefix = '<leader>',
  mode = 'x',
})
