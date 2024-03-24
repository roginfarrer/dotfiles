return {
  {
    'echasnovski/mini.files',
    enabled = false,
    opts = {
      windows = { width_nofocus = 25 },
      options = {
        permanent_delete = false,
      },
      content = {
        filter = function(entry)
          return entry.fs_type ~= 'file' or entry.name ~= '.DS_Store'
        end,
        sort = function(entries)
          local function compare_alphanumerically(e1, e2)
            -- Put directories first.
            if e1.is_dir and not e2.is_dir then
              return true
            end
            if not e1.is_dir and e2.is_dir then
              return false
            end
            -- Order numerically based on digits if the text before them is equal.
            if e1.pre_digits == e2.pre_digits and e1.digits ~= nil and e2.digits ~= nil then
              return e1.digits < e2.digits
            end
            -- Otherwise order alphabetically ignoring case.
            return e1.lower_name < e2.lower_name
          end

          local sorted = vim.tbl_map(function(entry)
            local pre_digits, digits = entry.name:match '^(%D*)(%d+)'
            if digits ~= nil then
              digits = tonumber(digits)
            end

            return {
              fs_type = entry.fs_type,
              name = entry.name,
              path = entry.path,
              lower_name = entry.name:lower(),
              is_dir = entry.fs_type == 'directory',
              pre_digits = pre_digits,
              digits = digits,
            }
          end, entries)
          table.sort(sorted, compare_alphanumerically)
          -- Keep only the necessary fields.
          return vim.tbl_map(function(x)
            return { name = x.name, fs_type = x.fs_type, path = x.path }
          end, sorted)
        end,
      },
    },
    config = function(_, opts)
      local MiniFiles = require 'mini.files'
      MiniFiles.setup(opts)

      local copy_path = function()
        -- Works only if cursor is on the valid file system entry
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        vim.fn.setreg('+', cur_directory)
        vim.notify('Copied "' .. cur_directory .. '" to the clipboard!')
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          vim.keymap.set('n', '<leader>yf', copy_path, { buffer = args.data.buf_id })
        end,
      })
    end,
    -- stylua: ignore
    keys = {
      { '-', function() require('mini.files').open(vim.api.nvim_buf_get_name(0), true) end, desc = 'Open mini.files', },
    },
  },
}
