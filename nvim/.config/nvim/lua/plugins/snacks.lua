local plugin_list = nil
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies = { 'roginfarrer/fzf-lua-lazy.nvim', dev = true },
    ---@type snacks.Config
    opts = {
      bigfile = {},
      dashboard = {},
      notifier = {},
      quickfile = {},
      -- statuscolumn = { enabled = true },
      input = {},
      rename = {},
      -- explorer = {},
      picker = {
        ui_select = true,
        win = {
          input = {
            keys = {
              ['.'] = { 'toggle_ignored', mode = { 'n' } },
              ['?'] = { 'toggle_hidden', mode = { 'n' } },
            },
          },
        },
        matches = {
          frecency = true,
          history_bonus = true,
        },
        db = {
          sqlite3_path = '/home/linuxbrew/.linuxbrew/lib/libsqlite3.so',
        },
      },
    },
    keys = function()
      ---@param builtin string
      ---@param args snacks.picker.Config|nil
      local function c(builtin, args)
        return function()
          Snacks.picker(builtin, args)
        end
      end

      return {
        { '<leader>;', c 'buffers', desc = 'Buffers' },
        { '<leader>b', c 'buffers', desc = 'Buffers' },
        { '<leader>/', c('grep', { hidden = true }), desc = 'Grep' },
        { '<leader>:', c 'command_history', desc = 'Command History' },
        { '<leader>ff', c('git_files', { hidden = true }), desc = 'Find Files (root dir)' },
        {
          '<leader>fF',
          function()
            ---@type string
            local cwd = vim.fn.expand '%:p:h'
            if vim.bo.filetype == 'oil' then
              cwd = require('oil').get_current_dir() or cwd
            end
            Snacks.picker.files { cwd = cwd, hidden = true }
          end,
          desc = 'Find Files (from buffer)',
        },
        {
          '<leader>fG',
          function()
            ---@type string
            local cwd = vim.fn.expand '%:p:h'
            if vim.bo.filetype == 'oil' then
              cwd = require('oil').get_current_dir() or cwd
            end
            Snacks.picker.grep { cwd = cwd, hidden = true }
          end,
          desc = 'Grep (from buffer)',
        },
        { '<leader>fd', c('git_files', { cwd = '~/dotfiles', hidden = true }), desc = 'Dotfiles' },
        { '<leader>fD', c('grep', { cwd = '~/dotfiles', hidden = true }), desc = 'Grep Dotfiles' },
        { '<leader>fh', c 'recent', desc = 'Recent' },
        { '<leader>fc', c 'grep_word', desc = 'Grep word under cursor' },
        { '<leader>st', c 'pickers', desc = 'Picker builtins' },
        { '<leader>sC', c 'commands', desc = 'commands' },
        { '<leader>sh', c 'help', desc = 'help pages' },
        { '<leader>sm', c 'man', desc = 'man pages' },
        { '<leader>sk', c 'keymaps', desc = 'key maps' },
        { '<leader>ss', c 'highlights', desc = 'search highlight groups' },
        { '<leader>sa', c 'autocmds', desc = 'auto commands' },
        { '<leader>sc', c 'colorschemes', desc = 'colorschemes' },
        { '<leader>r', c 'resume', desc = 'Picker resume' },
        { '<leader>gsl', c 'git_log', desc = 'Picker Git Log' },
        { '<leader>gss', c 'git_status', desc = 'Picker Git Status' },
        -- Override Neovim LSP defaults
        { 'gd', c 'lsp_definitions', desc = 'Definitions' },
        { 'gD', c 'lsp_declarations', desc = 'Declarations' },
        { 'grr', c 'lsp_references', nowait = true, desc = 'References' },
        { 'gri', c 'lsp_implementations', desc = 'Implementations' },
        { 'grt', c 'lsp_type_definitions', desc = 'Type Definitions' },
        { 'gO', c 'lsp_symbols', desc = 'LSP Document Symbols' },
        {
          '<c-x><c-f>',
          function()
            local curr_path = vim.fn.expand '%:p:h'
            Snacks.picker.pick {
              finder = 'git_files',
              actions = {
                confirm = {
                  action = function(picker, selected)
                    picker:close()
                    if selected.score == 0 then
                      return
                    end
                    vim.api.nvim_put({ selected.file }, '', false, true)
                    vim.schedule(function()
                      vim.cmd 'startinsert!'
                    end)
                  end,
                },
                relative = {
                  action = function(picker, selected)
                    picker:close()
                    if selected.score == 0 then
                      return
                    end
                    local path = require('util').makeRelativePath(selected._path, curr_path)
                    vim.api.nvim_put({ path }, '', false, true)
                    vim.schedule(function()
                      vim.cmd 'startinsert!'
                    end)
                  end,
                },
              },
              win = {
                input = {
                  keys = {
                    ['<c-r>'] = { 'relative', mode = { 'i', 'n' } },
                  },
                },
              },
            }
          end,
          desc = 'Fuzzy complete path',
          mode = { 'i' },
        },
        {
          '<leader>fl',
          function()
            if plugin_list == nil then
              plugin_list = {}
              local plugins = require('fzf-lua-lazy.lazy-plugins').plugins

              for _, plugin in ipairs(plugins) do
                local content = vim.fn.readfile(plugin.readme, '')
                local readme = table.concat(content, '\n')

                table.insert(
                  plugin_list,
                  vim.tbl_deep_extend('force', plugin, {
                    file = plugin.path,
                    text = plugin.name,
                    preview = { text = readme, ft = 'markdown' },
                  })
                )
              end
            end

            Snacks.picker.pick {
              finder = function()
                return plugin_list
              end,
              format = 'text',
              preview = 'preview',
              actions = {
                confirm = {
                  action = function(picker, selected)
                    picker:close()
                    local command = string.format('edit %s', selected.readme)
                    vim.cmd(command)
                  end,
                },
                open_in_browser = {
                  action = function(picker, selected)
                    local open_cmd
                    if vim.fn.executable 'xdg-open' == 1 then
                      open_cmd = 'xdg-open'
                    elseif vim.fn.executable 'explorer' == 1 then
                      open_cmd = 'explorer'
                    elseif vim.fn.executable 'open' == 1 then
                      open_cmd = 'open'
                    elseif vim.fn.executable 'wslview' == 1 then
                      open_cmd = 'wslview'
                    end

                    if not open_cmd then
                      vim.notify(
                        'Open in browser is not supported by your operating system.',
                        vim.log.levels.ERROR,
                        { title = 'Snacks Lazy' }
                      )
                    else
                      local url = selected.url
                      local ret = vim.fn.jobstart({ open_cmd, url }, { detach = true })
                      picker:close()
                      if ret <= 0 then
                        vim.notify(
                          string.format("Failed to open '%s'\nwith command: '%s' (ret: '%d')", url, open_cmd, ret),
                          vim.log.levels.ERROR,
                          { title = 'Snacks Lazy' }
                        )
                      end
                    end
                  end,
                },
              },
              win = {
                input = {
                  keys = {
                    ['<c-o>'] = { 'open_in_browser', mode = { 'i', 'n' } },
                  },
                },
              },
            }
          end,
        },
        -- {
        --   '<C-t>',
        --   function()
        --     Snacks.picker.explorer { hidden = true, auto_close = true }
        --   end,
        --   desc = 'Snacks Explorer',
        -- },
        -- {
        --   '-',
        --   function()
        --     Snacks.picker.explorer { hidden = true, auto_close = true }
        --   end,
        --   desc = 'Snacks Explorer',
        -- },
      }
    end,
  },
}
