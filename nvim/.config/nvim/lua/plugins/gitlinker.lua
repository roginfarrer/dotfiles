return {
  'ruifm/gitlinker.nvim',
  config = function()
    require('gitlinker').setup {
      mappings = nil,
      callbacks = {
        [_G.work_github_url] = require('gitlinker.hosts').get_github_type_url,
      },
    }
  end,
  keys = {
    {
      '<leader>gc',
      function()
        require('gitlinker').get_buf_range_url 'n'
      end,
      desc = 'Copy github url to clipboard',
    },
    {
      '<leader>gc',
      function()
        require('gitlinker').get_buf_range_url 'v'
      end,
      desc = 'Copy github url to clipboard',
      mode = { 'v' },
    },
    {
      '<leader>go',
      function()
        require('gitlinker').get_buf_range_url('n', { action_callback = require('gitlinker.actions').open_in_browser })
      end,
      desc = 'Open file in browser',
    },
    {
      '<leader>go',
      function()
        require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').open_in_browser })
      end,
      desc = 'Open file in browser',
      mode = { 'v' },
    },
  },
}
