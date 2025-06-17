local plugin_list = nil
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies = { 'roginfarrer/fzf-lua-lazy.nvim', dev = true },
    ---@type snacks.Config
    opts = {
      animate = { enabled = false },
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      -- statuscolumn = { enabled = true },
      input = { enabled = true },
      scroll = { enabled = false },
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
      },
    },
    keys = function()
      local function getDirectoryPath()
        if vim.bo.filetype == 'oil' then
          return require('oil').get_current_dir()
        end
        return vim.fn.expand '%:p:h'
      end
      local function c(builtin, args)
        return function()
          args = args or {}
          if args.cwd == 'root_from_file' then
            args.cwd = getDirectoryPath()
          end
          Snacks.picker[builtin](args)
        end
      end

      return {
        { '<leader>;', c 'buffers', desc = 'Buffers' },
        { '<leader>b', c 'buffers', desc = 'Switch Buffer' },
        { '<leader>/', c('grep', { hidden = true }), desc = 'Grep' },
        { '<leader>ff', c('git_files', { hidden = true }), desc = 'Find Files (cwd)' },
        { '<leader>fF', c('files', { cwd = 'root_from_file', hidden = true }), desc = 'Find Files (from buffer)' },
        { '<leader>fG', c('grep', { cwd = 'root_from_file', hidden = true }), desc = 'Grep (cwd)' },
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
        { '<leader>ld', c 'lsp_definitions', desc = 'Goto Definition' },
        { '<leader>lD', c 'lsp_declarations', desc = 'Goto Declarations' },
        { '<leader>lI', c 'lsp_implementations', desc = 'Goto Implementation' },
        { '<leader>lR', c 'lsp_references', nowait = true, desc = 'References' },
        { '<leader>ly', c 'lsp_type_definitions', desc = 'Goto T[y]pe Definition' },
        { 'gd', c 'lsp_definitions', desc = 'Goto Definition' },
        { 'gD', c 'lsp_declarations', desc = 'Goto Declarations' },
        { 'gr', c 'lsp_references', nowait = true, desc = 'References' },
        { 'gI', c 'lsp_implementations', desc = 'Goto Implementation' },
        { 'gy', c 'lsp_type_definitions', desc = 'Goto T[y]pe Definition' },
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
      }
    end,
  },
}
