return {

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    init = function()
      vim.cmd [[autocmd! User FlashEnter echo 'flash_enter']]
      vim.cmd [[autocmd! User FlashLeave echo 'flash_leave']]
    end,
    keys = function()
      local function flashWithAutocmd(cmd)
        return function()
          vim.cmd [[doautocmd User FlashEnter]]
          require('flash')[cmd]()
          vim.cmd [[doautocmd User FlashLeave]]
        end
      end
      -- stylua: ignore
      return {
      { "s", mode = { "n", "o", "x" }, flashWithAutocmd('jump'), desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, flashWithAutocmd('treesitter'), desc = "Flash Treesitter" },
      { "r", mode = "o", flashWithAutocmd('remote'), desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, flashWithAutocmd('treesitter_search'), desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, flashWithAutocmd('toggle'), desc = "Toggle Flash Search" },
    }
    end,
  },
}
