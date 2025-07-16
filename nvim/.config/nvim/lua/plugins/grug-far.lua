return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = { 'GrugFar' },
    keys = {
      { '<leader>fr', '<cmd>GrugFar<CR>', desc = 'Find & Replace' },
    },
    opts = {},
  },

  {
    'oil.nvim',
    optional = true,
    opts = function(_, opts)
      opts.keymaps = {
        ['g/'] = {
          callback = function()
            local oil = require 'oil'
            -- get the current directory
            local prefills = { paths = oil.get_current_dir() }

            local grug_far = require 'grug-far'
            -- instance check
            if not grug_far.has_instance 'explorer' then
              grug_far.open {
                instanceName = 'explorer',
                prefills = prefills,
                staticTitle = 'Find and Replace from Explorer',
              }
            else
              grug_far.open_instance 'explorer'
              -- updating the prefills without clearing the search and other fields
              grug_far.update_instance_prefills('explorer', prefills, false)
            end
          end,
          desc = 'oil: Search in directory',
        },
      }
    end,
  },
}
