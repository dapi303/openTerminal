" Vim plugin
" Last Change: 18.10.2022
" Maintainer: Damian Piotrowski <dapiotrowski93@gmail.com>
" License:	This file is placed in the public domain.

if exists("g:loaded_dapi")
  finish
endif
let g:loaded_dapi = 1


command! OpenTerm call s:OpenTerm()
command! HideTerm call s:HideTerm()
" ------------------------------------------------------------------------------
fun s:HideTerm()
  let l:buffers = execute("buffers R")
  if len(l:buffers)
    let l:substr = substitute(l:buffers, '\n', '', 'g')
    let l:substr = substitute(l:substr, '\s\+', ' ', 'g')
    let l:props = split(l:substr, ' ')

    if l:props[1] == 'aR'
      let l:wins = win_findbuf(l:props[0])
      let l:previous = win_findbuf(bufnr('%'))
      call win_gotoid(l:wins[0])
      hide
      call win_gotoid(l:previous[0])
    elseif l:props[1] == '%aR'
      hide
    endif
  endif

endfun

fun s:OpenTerm()
  let l:buffers = execute("buffers R")
  if len(l:buffers)
    let l:substr = substitute(l:buffers, '\n', '', 'g')
    let l:substr = substitute(l:substr, '\s\+', ' ', 'g')
    let l:props = split(l:substr, ' ')

    if l:props[1] == 'aR'
      let l:wins = win_findbuf(l:props[0])
      call win_gotoid(l:wins[0])
    elseif l:props[1] == 'hR'
      execute('bo new')
      execute('b' . l:props[0])
      if exists("g:openTermMaxHeight")
        execute('resize ' . g:openTermMaxHeight)
      endif
    endif
  else
    execute('bo term')
    if exists("g:openTermMaxHeight")
      execute('resize ' . g:openTermMaxHeight)
    endif
  endif
endfun

