local function cmd(args)
  return ':FzfLua ' .. args .. '<CR>'
end

return {
  'ibhagwan/fzf-lua',
  enabled = false,
  opts = 'telescope',
  keys = {
    -- { '<leader>ft', cmd 'builtin include_extensions=true', desc = 'telescope' },
    { '<leader>fp', cmd 'git_files', desc = 'git files' },
    { '<leader>;', cmd 'buffers', desc = 'buffers' },
    { '<leader>fb', cmd 'buffers', desc = 'buffers' },
    { '<leader>ff', cmd 'files', desc = 'all files' },
    { '<leader>fg', cmd 'live_grep', desc = 'live grep' },
    -- { '<leader>fG', filesContaining, desc = 'live grep (files containing)' },
    { '<leader>fd', cmd 'git_files cwd=~/dotfiles', desc = 'find in dotfiles' },
    -- { '<leader>fD', searchDotfiles, desc = 'grep in dotfiles' },
    { '<leader>fh', cmd 'oldfiles', desc = 'old files' },
    { '<leader>fH', cmd 'help_tags', desc = 'help tags' },
    { '<leader>fl', cmd 'lazy', desc = 'lazy plugins' },
    -- { '<leader>f.', grepInCurrentDirectory, desc = 'find in current directory' },
    { '<leader>Ht', cmd 'builtin', desc = 'telescope' },
    { '<leader>Hc', cmd 'commands', desc = 'commands' },
    { '<leader>Hh', cmd 'help_tags', desc = 'help pages' },
    { '<leader>Hm', cmd 'man_pages', desc = 'man pages' },
    { '<leader>Hk', cmd 'keymaps', desc = 'key maps' },
    { '<leader>Hs', cmd 'highlights', desc = 'search highlight groups' },
    { '<leader>Hf', cmd 'filetypes', desc = 'file types' },
    { '<leader>Ho', cmd 'vim_options', desc = 'options' },
    { '<leader>Ha', cmd 'autocommands', desc = 'auto commands' },
    { '<leader>gb', cmd 'git_branches', desc = 'checkout branch' },
    { '<leader>gC', cmd 'git_bcommits', desc = 'checkout commit (for current file)' },
  },
}
