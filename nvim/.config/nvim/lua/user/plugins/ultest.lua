require('ultest').setup {
  builders = {
    ['javascript#jest'] = function(cmd)
      local filename = cmd[#cmd]
      -- require('modules.utils').dump(cmd)
      return {
        dap = {
          type = 'node2',
          request = 'launch',
          cwd = vim.fn.getcwd(),
          args = {
            '--inspect-brk',
            'node_modules/.bin/jest',
            filename,
          },
          sourceMaps = true,
          protocol = 'inspector',
          skipFiles = { '<node_internals>/**/*.js' },
          console = 'integratedTerminal',
          port = 9229,
        },
      }
    end,
  },
}

