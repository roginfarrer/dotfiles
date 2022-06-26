local home = vim.fn.expand '~/Dropbox (Maestral)/Obsidian'
-- _G.zk_maps = function()
--   -- inoremap('[[', "<ESC>:lua require('telekasten').insert_link({i=true})<CR>")
--   vim.cmd [[set ft=markdown.zk]]
--   nnoremap('gf', function()
--     require('telekasten').follow_link()
--   end)
-- end
-- vim.cmd [[
--   augroup zk
--     autocmd!
--     autocmd BufEnter */Obsidian/*.md lua _G.zk_maps()
--   augroup END
-- ]]
require('telekasten').setup {
  home = home,

  -- if true, telekasten will be enabled when opening a note within the configured home
  take_over_my_home = true,

  -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
  --                               and thus the telekasten syntax will not be loaded either
  auto_set_filetype = false,

  dailies = home .. '/' .. 'daily',
  weeklies = home .. '/' .. 'weekly',
  templates = home .. '/' .. 'templates',

  -- image subdir for pasting
  -- subdir name
  -- or nil if pasted images shouldn't go into a special subdir
  image_subdir = 'img',

  -- markdown file extension
  extension = '.md',

  -- following a link to a non-existing note will create it
  follow_creates_nonexisting = true,
  dailies_create_nonexisting = true,
  weeklies_create_nonexisting = true,

  -- template for new notes (new_note, follow_link)
  -- set to `nil` or do not specify if you do not want a template
  -- template_new_note = home .. '/' .. 'templates/new_note.md',

  -- template for newly created daily notes (goto_today)
  -- set to `nil` or do not specify if you do not want a template
  template_new_daily = home .. '/' .. 'templates/daily.md',

  -- template for newly created weekly notes (goto_thisweek)
  -- set to `nil` or do not specify if you do not want a template
  template_new_weekly = home .. '/' .. 'templates/weekly.md',

  -- image link style
  -- wiki:     ![[image name]]
  -- markdown: ![](image_subdir/xxxxx.png)
  image_link_style = 'wiki',

  -- integrate with calendar-vim
  -- plug_into_calendar = true,
  -- calendar_opts = {
  --   -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
  --   weeknm = 4,
  --   -- use monday as first day of week: 1 .. true, 0 .. false
  --   calendar_monday = 1,
  --   -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
  --   calendar_mark = 'left-fit',
  -- },

  -- telescope actions behavior
  close_after_yanking = false,
  insert_after_inserting = true,

  -- tag notation: '#tag', ':tag:', 'yaml-bare'
  tag_notation = '#tag',

  -- command palette theme: dropdown (window) or ivy (bottom panel)
  command_palette_theme = 'ivy',

  -- tag list theme:
  -- get_cursor: small tag list at cursor; ivy and dropdown like above
  show_tags_theme = 'ivy',

  -- when linking to a note in subdir/, create a [[subdir/title]] link
  -- instead of a [[title only]] link
  subdirs_in_links = false,

  -- template_handling
  -- What to do when creating a new note via `new_note()` or `follow_link()`
  -- to a non-existing note
  -- - prefer_new_note: use `new_note` template
  -- - smart: if day or week is detected in title, use daily / weekly templates (default)
  -- - always_ask: always ask before creating a note
  template_handling = 'smart',

  -- path handling:
  --   this applies to:
  --     - new_note()
  --     - new_templated_note()
  --     - follow_link() to non-existing note
  --
  --   it does NOT apply to:
  --     - goto_today()
  --     - goto_thisweek()
  --
  --   Valid options:
  --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
  --              all other ones in home, except for notes/with/subdirs/in/title.
  --              (default)
  --
  --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
  --                    except for notes with subdirs/in/title.
  --
  --     - same_as_current: put all new notes in the dir of the current note if
  --                        present or else in home
  --                        except for notes/with/subdirs/in/title.
  new_note_location = 'smart',
}

-- require('which-key').register({
--   z = {
--     name = 'Telekasten',
--     n = { require('telekasten').new_note, 'New Note' },
--     N = { require('telekasten').new_templated_note, 'New Templeted Note' },
--     f = { require('telekasten').find_notes, 'Find Notes' },
--     g = { require('telekasten').search_notes, 'Grep Notes' },
--     w = { require('telekasten').find_weekly_notes, 'Find Weekly Notes' },
--     T = { require('telekasten').goto_thisweek, 'Goto Today' },
--     d = { require('telekasten').find_daily_notes, 'Find Daily Notes' },
--     t = { require('telekasten').goto_today, 'Goto Today' },
--     y = { require('telekasten').yank_notelink, 'Yank Notelink' },
--     z = { require('telekasten').follow_link, 'Follow Link' },
--     c = { require('telekasten').toggle_todo, 'Toggle Todo' },
--     a = { require('telekasten').show_tags, 'Show Tags' },
--     ['#'] = { require('telekasten').show_tags, 'Show Tags' },
--     p = { require('telekasten').panel, 'Panel' },
--   },
-- }, {
--   prefix = '<leader>',
-- })
