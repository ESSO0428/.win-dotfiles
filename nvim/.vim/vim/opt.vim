set sessionoptions+=tabpages,globals
" let g:taboo_close_tab_label="%x"
" let g:taboo_tab_format='%n'
" let g:airline#extensions#tabline#enabled = 1
set laststatus=2   " Always show the statusline
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%{getcwd()}'

" Taboo
" Disable Taboo's re-write of the tabline, because airline is doing that.
" We just want it for renaming tabs (only visible when there are multiple tabs)
" let g:taboo_tabline = 1
let g:airline#extensions#taboo#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:taboo_renamed_tab_format = "[%l]"

" Requires Vim built with clipboard support, typically
" needs to be self-compiled with clipboard option enabled.
" You can check for clipboard support in Vim by running
" 'vim --version' and looking for options like 'xterm_clipboard'.
if has('clipboard') && version >= 801
  autocmd TextYankPost *
    \ if v:event.operator is 'y' || v:event.operator is 'd' |
    \ execute 'OSCYankRegister +' |
    \ endif
endif  
