" Vim plugin
" Last Change: 06.08.2022
" Maintainer: Damian Piotrowski <dapiotrowski93@gmail.com>
" License:	This file is placed in the public domain.

if exists("g:loaded_dapi")
  finish
endif
let g:loaded_dapi = 1



command! OpenTerm call s:OpenTerm()
" ------------------------------------------------------------------------------
fun! s:OpenTerm()
  let l:running = split(execute("buffers R"), '\n')
  let l:runningNr = map(l:running, {key, val -> split(val, ' ')[0]})
  echo l:runningNr

  if len(l:runningNr) < 1
    execute('bo term')
  else
    if index(l:runningNr, string(bufnr('%'))) >= 0
      execute('bnext!')
    else
      execute('bo new')
    endif

    while index(l:runningNr, string(bufnr('%'))) < 0
      execute('bnext')
    endwhile
  endif
endfun

