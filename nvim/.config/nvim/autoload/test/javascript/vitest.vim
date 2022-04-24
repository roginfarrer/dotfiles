if !exists('g:test#javascript#vitest#file_pattern')
  let g:test#javascript#vitest#file_pattern = '\v(__tests__/.*|(spec|test))\.(js|jsx|coffee|ts|tsx)$'
endif

function! test#javascript#vitest#test_file(file) abort
  if a:file =~# g:test#javascript#vitest#file_pattern
      if exists('g:test#javascript#runner')
          return g:test#javascript#runner ==# 'vitest'
      else
        return test#javascript#has_package('vitest')
      endif
  endif
endfunction

function! test#javascript#vitest#build_position(type, position) abort
  if a:type ==# 'nearest'
    let name = s:nearest_test(a:position)
    if !empty(name)
      let name = '-t '.shellescape(name, 1)
    endif
    return [name, a:position['file']]
  elseif a:type ==# 'file'
    return [a:position['file']]
  else
    return []
  endif
endfunction

let s:yarn_command = '\<yarn\>'
function! test#javascript#vitest#build_args(args) abort
  if exists('g:test#javascript#vitest#executable')
    \ && g:test#javascript#vitest#executable =~# s:yarn_command
    return filter(a:args, 'v:val != "--"')
  else
    return a:args
  endif
endfunction

function! test#javascript#vitest#executable() abort
  if filereadable('node_modules/.bin/vitest')
    return 'node_modules/.bin/vitest'
  else
    return 'vitest'
  endif
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#javascript#patterns)
  return (len(name['namespace']) ? '^' : '') .
       \ test#base#escape_regex(join(name['namespace'] + name['test'])) .
       \ (len(name['test']) ? '$' : '')
endfunction
