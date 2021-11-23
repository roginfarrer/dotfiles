-- [[
--
-- https://github.com/henriquehbr/nvim-startup.lua
-- 
-- MIT License
--
-- Copyright (c) 2021 Henrique Borges
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
-- ]]
local M = {}

local startup_file = '/tmp/nvim-startuptime'

local message = 'nvim-startup: launched in {}'

local startup_time_pattern = '([%d.]+)  [%d.]+: [-]+ NVIM STARTED [-]+'

-- read startup time file
local startup_time_file = io.open(startup_file)
    and io.open(startup_file):read '*all'
  or nil

-- get startup time and converts to number (in case `message` is function)
local startup_time = startup_time_file
    and tonumber(
      startup_time_file:match(startup_time_pattern)
    )
  or nil

local result = ''
if startup_time_file and startup_time then
  -- replace the message `{}` placeholder with the startup time
  local template_message = type(message) == 'function'
      and message(startup_time)
    or message
  result = template_message:gsub('{}', startup_time .. ' ms')
elseif startup_time_file and not startup_time then
  result = 'nvim-startup: running on the next (n)vim instance'
else
  result = 'nvim-startup: startup time log not found (' .. startup_file .. ')'
end

vim.cmd("command! NStartupTime echo '" .. result .. "'")

-- clear startup time log
-- removing it causes some cache related issues (hyphothesis)
io.open(startup_file, 'w'):close()

return M
