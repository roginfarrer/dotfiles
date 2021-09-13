-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/rfarrer/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/rfarrer/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/rfarrer/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/rfarrer/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/rfarrer/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["TrueZen.nvim"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/TrueZen.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/cmp-path"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/dashboard-nvim"
  },
  diffconflicts = {
    commands = { "DiffConflicts" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/diffconflicts"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen", "DiffviewFileHistory" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/diffview.nvim"
  },
  ["gitlinker.nvim"] = {
    config = { "\27LJ\2\nX\0\0\3\0\4\0\t6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0B\0\1\1K\0\1\0\14gitlinker\rmappings\22plugins.gitlinker\frequire\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/gitlinker.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    config = { "\27LJ\2\n)\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\14impatient\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/impatient.nvim"
  },
  ["lir-git-status.nvim"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/lir-git-status.nvim"
  },
  ["lir.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.lir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/lir.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\vpreset\rcodicons\tinit\flspkind\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugins.lualine\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/lualine.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["nightfox.nvim"] = {
    after = { "lualine.nvim" },
    loaded = true,
    only_config = true
  },
  ["nord.nvim"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/nord.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n=\0\0\3\1\2\0\a-\0\0\0\14\0\0\0X\0\3€6\0\0\0'\2\1\0B\0\2\1K\0\1\0\1\0\20plugins.null-ls\frequire\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.autopairs\frequire\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-base16.lua"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/nvim-base16.lua"
  },
  ["nvim-cmp"] = {
    after = { "cmp-nvim-lua", "cmp-buffer", "cmp-path" },
    loaded = true,
    only_config = true
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.lsp\frequire\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-spectre"] = {
    commands = { "FindAndReplace" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/nvim-spectre"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-ts-autotag" },
    loaded = true,
    only_config = true
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nŸ\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\roverride\1\0\0\20lir_folder_icon\1\0\0\1\0\3\tname\18LirFolderNode\ncolor\f#7ebae4\ticon\bî—¿\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["package-info.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17package-info\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/package-info.nvim"
  },
  ["packer.nvim"] = {
    after = { "impatient.nvim" },
    loaded = true,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  ["targets.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/targets.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.telescope\frequire\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n%\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\ntheme\frequire\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["treesitter-unit"] = {
    config = { "\27LJ\2\n›\3\0\0\6\0\15\0!6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\4\0'\4\v\0005\5\f\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\a\0'\4\r\0005\5\14\0B\0\5\1K\0\1\0\1\0\1\fnoremap\0028:<c-u>lua require\"treesitter-unit\".select(true)<CR>\1\0\1\fnoremap\0024:<c-u>lua require\"treesitter-unit\".select()<CR>\6o\1\0\1\fnoremap\0023:lua require\"treesitter-unit\".select(true)<CR>\aau\1\0\1\fnoremap\2/:lua require\"treesitter-unit\".select()<CR>\aiu\6x\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/treesitter-unit"
  },
  ["trouble.nvim"] = {
    commands = { "Trouble", "TroubleToggle" },
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/trouble.nvim"
  },
  ["vim-abolish"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-abolish"
  },
  ["vim-agriculture"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-agriculture"
  },
  ["vim-commentary"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-commentary"
  },
  ["vim-doge"] = {
    commands = { "DogeGenerate", "DogeCreateDocStandard" },
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17plugins.doge\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-doge"
  },
  ["vim-easydir"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-easydir"
  },
  ["vim-eunuch"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-eunuch"
  },
  ["vim-markdown"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.polyglot\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-mdx-js"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-mdx-js"
  },
  ["vim-open-url"] = {
    commands = { "<Plug>(open-url-browser)" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-open-url"
  },
  ["vim-sandwich"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-sandwich"
  },
  ["vim-test"] = {
    commands = { "TestFile", "TestSuite", "TestNearest", "TestVisit", "TestLast" },
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.vim-test\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/opt/vim-test"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.which-key\frequire\0" },
    loaded = true,
    path = "/Users/rfarrer/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: nvim-spectre
time([[Setup for nvim-spectre]], true)
try_loadstring("\27LJ\2\nÂ\1\0\0\4\0\b\0\f6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0'\2\6\0'\3\a\0B\0\3\1K\0\1\0\24:FindAndReplace<CR>\15<leader>fr\rnnoremap\nutils\frequireQcommand! FindAndReplace lua require('spectre').open({is_insert_mode = true})\bcmd\bvim\0", "setup", "nvim-spectre")
time([[Setup for nvim-spectre]], false)
-- Setup for: vim-test
time([[Setup for vim-test]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\ttest\rmappings\frequire\0", "setup", "vim-test")
time([[Setup for vim-test]], false)
-- Setup for: dashboard-nvim
time([[Setup for dashboard-nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.dashboard\frequire\0", "setup", "dashboard-nvim")
time([[Setup for dashboard-nvim]], false)
time([[packadd for dashboard-nvim]], true)
vim.cmd [[packadd dashboard-nvim]]
time([[packadd for dashboard-nvim]], false)
-- Setup for: packer.nvim
time([[Setup for packer.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vpacker\rmappings\frequire\0", "setup", "packer.nvim")
time([[Setup for packer.nvim]], false)
time([[packadd for packer.nvim]], true)
vim.cmd [[packadd packer.nvim]]
time([[packadd for packer.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n=\0\0\3\1\2\0\a-\0\0\0\14\0\0\0X\0\3€6\0\0\0'\2\1\0B\0\2\1K\0\1\0\1\0\20plugins.null-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0", "config", "neoscroll.nvim")
time([[Config for neoscroll.nvim]], false)
-- Config for: nightfox.nvim
time([[Config for nightfox.nvim]], true)
try_loadstring("\27LJ\2\n%\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\ntheme\frequire\0", "config", "nightfox.nvim")
time([[Config for nightfox.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: treesitter-unit
time([[Config for treesitter-unit]], true)
try_loadstring("\27LJ\2\n›\3\0\0\6\0\15\0!6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\4\0'\4\v\0005\5\f\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\a\0'\4\r\0005\5\14\0B\0\5\1K\0\1\0\1\0\1\fnoremap\0028:<c-u>lua require\"treesitter-unit\".select(true)<CR>\1\0\1\fnoremap\0024:<c-u>lua require\"treesitter-unit\".select()<CR>\6o\1\0\1\fnoremap\0023:lua require\"treesitter-unit\".select(true)<CR>\aau\1\0\1\fnoremap\2/:lua require\"treesitter-unit\".select()<CR>\aiu\6x\20nvim_set_keymap\bapi\bvim\0", "config", "treesitter-unit")
time([[Config for treesitter-unit]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nŸ\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\roverride\1\0\0\20lir_folder_icon\1\0\0\1\0\3\tname\18LirFolderNode\ncolor\f#7ebae4\ticon\bî—¿\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n%\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\ntheme\frequire\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: gitlinker.nvim
time([[Config for gitlinker.nvim]], true)
try_loadstring("\27LJ\2\nX\0\0\3\0\4\0\t6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0B\0\1\1K\0\1\0\14gitlinker\rmappings\22plugins.gitlinker\frequire\0", "config", "gitlinker.nvim")
time([[Config for gitlinker.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.lsp\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd lualine.nvim ]]

-- Config for: lualine.nvim
try_loadstring("\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugins.lualine\frequire\0", "config", "lualine.nvim")

vim.cmd [[ packadd cmp-buffer ]]
vim.cmd [[ packadd cmp-nvim-lua ]]
vim.cmd [[ packadd cmp-path ]]
vim.cmd [[ packadd impatient.nvim ]]

-- Config for: impatient.nvim
try_loadstring("\27LJ\2\n)\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\14impatient\frequire\0", "config", "impatient.nvim")

vim.cmd [[ packadd nvim-ts-autotag ]]

-- Config for: nvim-ts-autotag
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0", "config", "nvim-ts-autotag")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file FindAndReplace lua require("packer.load")({'nvim-spectre'}, { cmd = "FindAndReplace", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewFileHistory lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewFileHistory", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DogeCreateDocStandard lua require("packer.load")({'vim-doge'}, { cmd = "DogeCreateDocStandard", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DogeGenerate lua require("packer.load")({'vim-doge'}, { cmd = "DogeGenerate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffConflicts lua require("packer.load")({'diffconflicts'}, { cmd = "DiffConflicts", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[au CmdUndefined <Plug>(open-url-browser) ++once lua require"packer.load"({'vim-open-url'}, {}, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TestFile lua require("packer.load")({'vim-test'}, { cmd = "TestFile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TestSuite lua require("packer.load")({'vim-test'}, { cmd = "TestSuite", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TestNearest lua require("packer.load")({'vim-test'}, { cmd = "TestNearest", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TestVisit lua require("packer.load")({'vim-test'}, { cmd = "TestVisit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TestLast lua require("packer.load")({'vim-test'}, { cmd = "TestLast", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'targets.vim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'vim-markdown', 'nvim-colorizer.lua', 'vim-mdx-js', 'vim-sandwich', 'nvim-ts-context-commentstring', 'package-info.nvim', 'lir.nvim', 'gitsigns.nvim', 'lspkind-nvim', 'vim-abolish', 'vim-agriculture', 'vim-commentary', 'vim-easydir', 'vim-eunuch'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au BufNewFile * ++once lua require("packer.load")({'vim-markdown', 'nvim-colorizer.lua', 'vim-mdx-js', 'vim-sandwich', 'nvim-ts-context-commentstring', 'lir.nvim', 'gitsigns.nvim', 'lspkind-nvim', 'vim-abolish', 'vim-agriculture', 'vim-commentary', 'vim-easydir', 'vim-eunuch'}, { event = "BufNewFile *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
