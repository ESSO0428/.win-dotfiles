function CleanUselessBuffers()                           
  for buf in getbufinfo()                         
  if buf.name == "" && buf.changed == 0 && buf.loaded == 1       
    :execute ':bdelete ' . buf.bufnr           
  endif                  
  endfor                   
endfunction                                 
                                           
function ToggleLex()                               
  call CleanUselessBuffers()                           
                                           
  " we iterate through the buffers again because some netrw buffers are      
  " skipped after we browsed to a different location and hence the name      
  " of the window changed (no longer '')                     
  let flag = 0                                   
  for buf in getbufinfo()                            
    if (get(buf.variables, "current_syntax", "") == "netrwlist") && buf.changed == 0 && buf.loaded == 1
      :execute  ':bdelete ' . buf.bufnr                    
      let flag = 1                               
    endif                                    
  endfor                                     
                                           
  if !flag                                  
    :Lexplore                                 
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
   autocmd filetype netrw call NetrwMapping()
augroup END

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
endfunction
