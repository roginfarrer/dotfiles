return {
  {
    'MeanderingProgrammer/markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('render-markdown').setup {
        -- anti_conceal = { enabled = false },
        -- win_options = {
        --   concealcursor = {
        --     default = '',
        --     rendered = '',
        --   },
        -- },
      }
    end,
    ft = { 'markdown', 'mdx' },
    init = function()
      local autocmd = require('util').autocmd

      local function toggleConceal(conceal)
        local event = vim.v.event
        local new_mode = event.new_mode
        local old_mode = event.old_mode
        if string.match(new_mode, 'o') then
          vim.b.concealcursor = vim.o.concealcursor
          vim.o.concealcursor = ''
        end
        if string.match(old_mode, 'o') then
          vim.o.concealcursor = vim.b.concealcursor
        end
      end

      -- I created these autocmds, don't actually come from flash
      autocmd('User', {
        group = 'flash_markdown_enter',
        pattern = 'FlashEnter',
        callback = function()
          print 'flash enter autocmd'
          vim.b.concealcursor = vim.o.concealcursor
          vim.b.conceallevel = vim.o.conceallevel
          vim.o.concealcursor = nil
          vim.o.conceallevel = 0
        end,
      })
      autocmd('User', {
        group = 'flash_markdown_leave',
        pattern = 'FlashLeave',
        callback = function()
          print 'flash leave autocmd'
          vim.o.concealcursor = vim.b.concealcursor
          vim.o.conceallevel = vim.b.conceallevel
        end,
      })

      -- Remove conceal when in operator mode to make it easier to execute commands on concealed characters (like links)
      autocmd('ModeChanged', {
        group = 'markdown_conceal',
        pattern = { 'no:*', '*:no' },
        callback = function()
          local event = vim.v.event
          local new_mode = event.new_mode
          local old_mode = event.old_mode
          if string.match(new_mode, 'o') then
            vim.b.concealcursor = vim.o.concealcursor
            vim.o.concealcursor = ''
          end
          if string.match(old_mode, 'o') then
            vim.o.concealcursor = vim.b.concealcursor
          end
        end,
      })
    end,
  },
}
