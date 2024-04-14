" set statusline         "显示状态栏命令                                                                                                                                                         
set laststatus=2                                                                
function! ModeName()
  let mode = mode()
  if mode == 'n'
    return '[Normal]'
  elseif mode == 'i'
    return '[Insert]'
  elseif mode == 'v'
    return '[Visual]'
  " Add more cases as needed...
  else
    return mode
  endif
endfunction
   
" hi User1 cterm=none ctermfg=gray ctermbg=darkgreen
hi User1 cterm=none ctermfg=gray ctermbg=darkgray
hi User2 cterm=none ctermfg=darkgrey ctermbg=gray
hi User3 cterm=bold ctermfg=darkgrey ctermbg=gray
hi User4 cterm=bold ctermfg=green ctermbg=gray
hi User5 cterm=none ctermfg=darkgrey ctermbg=gray
hi User6 cterm=none ctermfg=darkgrey ctermbg=gray

set statusline=%1*%{ModeName()}\ %m%r%h%w%=\ %2*\ %{getcwd()}\ %3*\ %{&fileencoding}\ %4*\ %{&fileformat}\ %=\ %5*%{\"\".(\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}\ %6*[%l,%v]\ %7*%p%%\ \|\ %8*%LL\
" set statusline=%1*%{ModeName()}\ %m%r%h%w%=\ %2*\ %{getcwd()}\ %=\ %3*%{\"\".(\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}\ %4*[%l,%v]\ %5*%p%%\ \|\ %6*%LL\
set tabline=%!MyTabLine()  " custom tab pages line
set showtabline=2

function! SpawnBufferLine()
  let s = ' hello r/vim | '

  " Get the list of buffers. Use bufexists() to include hidden buffers
  let bufferNums = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  " Making a buffer list on the left side
  for i in bufferNums
    " Highlight with yellow if it's the current buffer
    let s .= (i == bufnr('%')) ? ('%#TabLineSel#') : ('%#TabLine#')
    let s .= i . ' '  " Append the buffer number
    if bufname(i) == ''
      let s .= '[NEW]'  " Give a name to a new buffer
    endif
    if getbufvar(i, "&modifiable")
      let s .= fnamemodify(bufname(i), ':t')  " Append the file name
      " let s .= pathshorten(bufname(i))  " Use this if you want a trimmed path
      " If the buffer is modified, add + and separator. Else, add separator
      let s .= (getbufvar(i, "&modified")) ? (' [+] | ') : (' | ')
    else
      let s .= fnamemodify(bufname(i), ':t') . ' [RO] | '  " Add read only flag
    endif
  endfor
  let s .= '%#TabLineFill#%T'  " Reset highlight

  let s .= '%=' " Spacer

  " Making a tab list on the right side
  for i in range(1, tabpagenr('$'))  " Loop through the number of tabs
    " Highlight with yellow if it's the current tab
    let s .= (i == tabpagenr()) ? ('%#TabLineSel#') : ('%#TabLine#')
    let s .= '%' . i . 'T '  " set the tab page number (for mouse clicks)
    let s .= i . ''          " set page number string
  endfor
  let s .= '%#TabLineFill#%T'  " Reset highlight

  " Close button on the right if there are multiple tabs
  if tabpagenr('$') > 1
    let s .= '%999X X'
  endif
  return s 
endfunction

set tabline=%!SpawnBufferLine()  " Assign the tabline
