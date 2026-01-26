let g:netrw_liststyle = 3

function! s:OpenDir(path) abort
  let l:p = a:path

  if has('win32') || has('win64')
    let l:p = substitute(l:p, '/', '\', 'g')
    execute 'silent! !start explorer ' . shellescape(l:p)
    redraw!
    return
  endif

  if has('mac') || has('macunix')
    execute 'silent! !open ' . shellescape(l:p)
    redraw!
    return
  endif

  if executable('xdg-open')
    execute 'silent! !xdg-open ' . shellescape(l:p)
    redraw!
    return
  endif

  call netrw#BrowseX(l:p, 0)
endfunction

function! NetrwXOpen() abort
  let l:target = netrw#Call('NetrwGetWord')

  let l:path = netrw#Call('NetrwBrowseChgDir', 1, l:target, 0)

  if isdirectory(l:path)
    call s:OpenDir(l:path)
    return
  endif

  call netrw#BrowseX(l:path, 0)
endfunction

function! CleanUselessBuffers()
  for buf in getbufinfo()
    if buf.name ==# "" && buf.changed == 0 && buf.loaded == 1
      execute ':bdelete ' . buf.bufnr
    endif
  endfor
endfunction

function! ToggleLex()
  " Keep your original cleanup behavior
  call CleanUselessBuffers()

  " We iterate through windows in the *current tab* only.
  " This avoids closing netrw buffers that belong to other tabs.
  let l:found = 0

  " We iterate through the windows again because some netrw buffers may be
  " skipped after we browsed to a different location and hence the name
  " of the window changed (no longer '')
  for l:w in range(1, winnr('$'))
    let l:bufnr = winbufnr(l:w)

    " Detect the netrw file listing buffer by its syntax
    if getbufvar(l:bufnr, 'current_syntax', '') ==# 'netrwlist'
      " Jump to that window and close its buffer
      execute l:w . 'wincmd w'
      bdelete
      let l:found = 1
      break
    endif
  endfor

  " If no netrw window exists in this tab, open it
  if !l:found
    Lexplore
  endif
endfunction
" noremap <leader>e :Lexplore<cr>
if version >= 801
  noremap <silent><leader>e :call ToggleLex()<CR>
else
  noremap <silent><leader>e :Explore<CR>
endif

augroup netrw_mapping
  autocmd!
  autocmd FileType netrw call NetrwMapping()
augroup END

" Helper: in netrw, try to detect if the current line is a directory entry.
function! s:NetrwLineIsDir(line) abort
  " Common netrw UI: directories often end with '/'
  " (works well with g:netrw_liststyle = 3)
  return a:line =~# '/\s*$'
endfunction

" Helper: jump cursor to the exact position under the mouse.
function! s:NetrwGotoMousePos() abort
  let l:m = getmousepos()

  " If the click happened in some other window, jump there first.
  if get(l:m, 'winid', 0) != 0
    call win_gotoid(l:m.winid)
  endif

  " Move cursor to the clicked line/column (fallback to 1 if missing)
  call cursor(get(l:m, 'line', 1), get(l:m, 'column', 1))
endfunction

" " Helper: handle single click behavior in netrw buffer
" function! s:NetrwLeftClick() abort
"   let l:line = getline('.')
"   " Single click enters directories only; files require double click
"   if s:NetrwLineIsDir(l:line)
"     " Use netrw's browse/open action (must allow mappings)
"     execute "normal \<Plug>NetrwLocalBrowseCheck"
"   endif
" endfunction

" click_type: 1 = single click, 2 = double click
function! s:NetrwMouseOpen(click_type) abort
  " Always go to the clicked entry first
  call s:NetrwGotoMousePos()

  let l:line = getline('.')

  if a:click_type == 2
    " Double click: open file or enter directory
    execute "normal \<Plug>NetrwLocalBrowseCheck"
    return
  endif

  " Single click: enter directories only; files require double click
  if s:NetrwLineIsDir(l:line)
    execute "normal \<Plug>NetrwLocalBrowseCheck"
  endif
endfunction

function! NetrwMapping()
  nnoremap <buffer> i k
  nnoremap <buffer> I 5k
  " noremap <buffer> l <Plug>NetrwLocalBrowseCheck
  nmap <buffer> l <cr>
  nmap <buffer> a %
  nmap <buffer> A d
  nmap <buffer> r R

  nmap <buffer> s <Nop>
  nmap <nowait><buffer> q :q<CR>
  nmap <buffer> <a-l> v
  nmap <buffer> <a-k> o

  nnoremap <silent><buffer> si :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
  nnoremap <silent><buffer> sk :set splitbelow<CR>:split<CR>
  nnoremap <silent><buffer> sj :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
  nnoremap <silent><buffer> sl :set splitright<CR>:vsplit<CR>

  " ---- Mouse behavior (GVim / terminals that deliver mouse events) ----
  " Single click:
  "   - directory: enter it
  "   - file: do nothing (use double click)
  "
  " Double click:
  "   - open entry (same as <CR>)
  "
  " Note: if your terminal doesn't send <2-LeftMouse>, double click may not work.
  " nmap <silent><buffer> <LeftMouse> :call <SID>NetrwLeftClick()<CR>
  " nmap <silent><buffer> <2-LeftMouse> <CR>
  " Mouse: single click enters directories; double click opens files/dirs
  nnoremap <silent><buffer> <LeftMouse>    :call <SID>NetrwMouseOpen(1)<CR>
  nnoremap <silent><buffer> <2-LeftMouse>  :call <SID>NetrwMouseOpen(2)<CR>

  nnoremap <silent><buffer> x :call NetrwXOpen()<CR>
endfunction
