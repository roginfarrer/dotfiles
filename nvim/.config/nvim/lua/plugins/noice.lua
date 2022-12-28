return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
  config = function()
    local focused = true
    vim.api.nvim_create_autocmd('FocusGained', {
      callback = function()
        focused = true
      end,
    })
    vim.api.nvim_create_autocmd('FocusLost', {
      callback = function()
        focused = false
      end,
    })

    require('noice').setup {
      -- cmdline = {
      --   view = 'cmdline',
      -- },
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
        inc_rename = true,
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = 'split',
          opts = { enter = true, format = 'details' },
          filter = {},
        },
      },
      routes = {
        {
          filter = {
            cond = function()
              return not focused
            end,
          },
          view = 'notify_send',
          opts = { stop = false },
        },
        {
          filter = {
            event = 'msg_show',
            find = '%d+L, %d+B',
          },
          view = 'mini',
        },
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

    vim.keymap.set('c', '<S-Enter>', function()
      require('noice').redirect(vim.fn.getcmdline())
    end, { desc = 'Redirect Cmdline' })

    vim.keymap.set('n', '<leader>nl', function()
      require('noice').cmd 'last'
    end, { desc = 'Noice Last Message' })

    vim.keymap.set('n', '<leader>nh', function()
      require('noice').cmd 'history'
    end, { desc = 'Noice History' })

    vim.keymap.set('n', '<leader>na', function()
      require('noice').cmd 'all'
    end, { desc = 'Noice All' })

    vim.keymap.set('n', '<c-f>', function()
      if not require('noice.lsp').scroll(4) then
        return '<c-f>'
      end
    end, { silent = true, expr = true })

    vim.keymap.set('n', '<c-b>', function()
      if not require('noice.lsp').scroll(-4) then
        return '<c-b>'
      end
    end, { silent = true, expr = true })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function(event)
        vim.schedule(function()
          require('noice.text.markdown').keys(event.buf)
        end)
      end,
    })
  end,
}
