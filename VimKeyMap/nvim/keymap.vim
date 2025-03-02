let g:clipboard = {
    \   'name': 'win32yank',
    \   'copy': {
    \       '+': 'win32yank.exe -i --crlf',
    \       '*': 'win32yank.exe -i --crlf',
    \   },
    \   'paste': {
    \       '+': 'win32yank.exe -o --lf',
    \       '*': 'win32yank.exe -o --lf',
    \   },
    \   'cache_enabled': 1,
    \ }


" ==================== Auto load for first time uses ====================
let use_custom_statusline = 0
let use_plugins = 1

set hidden
set noswapfile
set mouse=a
set foldmethod=indent
set foldlevel=99
set hlsearch
set clipboard=unnamedplus
autocmd VimLeave * silent !echo -ne "\e[6 q"
syntax enable

inoremap <a-j> <esc>
inoremap <a-i> <c-p>
inoremap <a-k> <c-n>

set nowarn
set number
set cursorline
" format tab to 4 space => not format
" set noexpandtab
set tabstop=2
" set shiftwidth=2
set shiftwidth=4
" set softtabstop=2
set softtabstop=4
set autoindent


set inccommand=split
set laststatus=3
set splitright
set splitbelow
set noequalalways

hi NonText ctermfg=gray guifg=#414348
hi Visual cterm=reverse gui=reverse
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=200})
augroup END


set guifont=Hack\ Nerd\ Font\ Mono:h10
let mapleader=" "

nnoremap <leader>dft :diffthis<cr>
nnoremap <leader>dfw :diffoff<cr>
nnoremap <leader>dfW :diffoff!<cr>
nnoremap <leader>dfs :set scrollbind!<cr>
nnoremap <leader>dfe :windo set noscrollbind<cr>

autocmd BufRead,BufNewFile *.md inoremap <buffer> ,, <++>
                        \| nnoremap <buffer><LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
                        \| inoremap <buffer> ,c ```<++>```<CR><CR><++><Esc>2ki<CR><Esc>f>a<CR><Esc>2k$a
                        \| inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l

let g:SetWrapKeymapExcludeArray = ['minifiles']

nnoremap Q :qa<CR>
nnoremap S :w<CR>
" Open the vimrc file anytime

" Undo operations
" colemak keyboard
" noremap l u
" normal keyboard
nmap u <Nop>
nnoremap z u
" Insert Key
noremap h i
noremap H I

" Copy to system clipboard
vnoremap Y "+y
nnoremap Y y$
nnoremap <silent>gy :let @+ = expand('%:p')<CR>

" Find pair
nnoremap g{ %
vnoremap g{ %
nnoremap g} $%
vnoremap g} $%

" Search
nnoremap <LEADER><CR> :nohlsearch<CR>

" Folding
nnoremap <silent> <LEADER>o za
nnoremap <silent> <LEADER>Oa zM
nnoremap <silent> <LEADER>Od zR

vnoremap <silent> <LEADER>o za
vnoremap <silent> <LEADER>Oa zC
vnoremap <silent> <LEADER>Od zO

nnoremap <silent> [{ zk
nnoremap <silent> ]} zj
nnoremap <silent> <c-HOME> zk
nnoremap <silent> <c-END> zj
nnoremap <silent> <a-[> zk
nnoremap <silent> <a-]> zj

" move line
nnoremap <silent><a-Up> :m -2<CR>
nnoremap <silent><a-Down> :m +1<CR>
vnoremap <silent><a-Up> :m '<-2<CR>gv=gv
vnoremap <silent><a-Down> :m '>+1<CR>gv=gv

" remap undo, insert new line
nnoremap o o<ESC>
nnoremap u O<ESC>
nnoremap O <Nop>
nnoremap O dd

nnoremap u O<ESC>
nnoremap U "_ddk
" noremap <c-y> yyp
nnoremap <a-i> <c-u>
nnoremap <a-k> <c-d>
nnoremap <c-d> yyp
" nmap < <<CR>
" nmap > ><CR>
nnoremap x "_x
nnoremap <leader>d "_d
nnoremap <leader>D "_D
nnoremap <leader>c "_c
nnoremap <leader>C "_C
vnoremap <leader>d "_d
nnoremap <leader>dD "_dd
vnoremap <leader>D "_D
vnoremap <leader>c "_c
vnoremap <leader>C "_C

" nnoremap <c-n> <tab>
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
" inoremap <S-Tab> <CD>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap <leader><c-c> "+y
vnoremap <leader><c-x> "+d
nnoremap gj J
vnoremap gj J
nnoremap <a-a> <c-x>
nnoremap <a-d> <c-a>
" ==================== spell ====================
nnoremap s,G zG
nnoremap s,g zg
nnoremap s,w zw
nnoremap s,W zW
nnoremap s,uw zuw
nnoremap s,ug zug
nnoremap s,uW zuW
nnoremap s,uG zuG
nnoremap s,= z=
vnoremap s,G zG
vnoremap s,g zg
vnoremap s,w zw
vnoremap s,W zW
vnoremap s,uw zuw
vnoremap s,ug zug
vnoremap s,uW zuW
vnoremap s,uG zuG
vnoremap s,= z=
" ===
nnoremap <silent> <a-m> :set list!<cr>

nnoremap <a-v> <c-v>

inoremap <c-v> <c-r>+
cnoremap <c-v> <c-r>+
nnoremap <c-v> p
nnoremap <c-o> 10<C-E>
nnoremap <c-u> 10<C-Y>
" ==================== Cursor Movement ====================
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     i
" < j   l >
"     k
"     v

" normal keyborad
nnoremap <silent> i k
nnoremap <silent> j h
nnoremap <silent> k j
" visual keyborad
vnoremap <silent> i k
vnoremap <silent> j h
vnoremap <silent> k j

" noremap <silent> l l

" colemak keyborad
" noremap <silent> gu gk
" noremap <silent> ge gj
noremap <silent> \v v$h

" normal keyborad
noremap <silent> gi gk
noremap <silent> gk gj
" visual keyborad
vnoremap <silent> gi gk
vnoremap <silent> gk gj

" 覆蓋 i, k 成 gk, gj 
" noremap <silent> i gk
" noremap <silent> k gj

" U/E keys for 5 times u/e (faster navigation)
" colemak keyborad
" noremap <silent> U 5k
" noremap <silent> E 5j

" normal keyborad
noremap <silent> I 5k
noremap <silent> K 5j
" visual keyborad
vnoremap <silent> I 5k
vnoremap <silent> K 5j

" 覆蓋 I, K 成 5gk, 5gj 
" noremap <silent> I 5gk
" noremap <silent> K 5gj

" N key: go to the start of the line
" colemak keyborad
" noremap <silent> N 0

" normal keyborad
nnoremap <silent> J 0
" visual keyborad
vnoremap <silent> J 0

" I key: go to the end of the line
" colemak keyborad
" noremap <silent> I $

" normal keyborad
nnoremap <silent> L $
" visual keyborad
vnoremap <silent> L $

" noremap <silent> J g0
" noremap <silent> L g$

" Faster insert to normal mode
" inoremap <a-j> <esc>
inoremap <a-J> <esc>
nnoremap <a-J> <nop>
" ==================== Insert Mode Cursor Movement ====================
inoremap <a-n> <Up>
inoremap <a-m> <Down>
inoremap <a-,> <Left>
inoremap <a-.> <Right>

" ==================== buffer control =======================
nnoremap <c-j> :bprevious<CR>
nnoremap <c-l> :bnext<CR>
nnoremap <c-w> :bd<CR>
nnoremap <LEADER><c-w> :bd!<CR>
nnoremap <LEADER>d<c-w> :bd!<CR>


" ==================== Window management ====================
" Use <space> + new arrow keys for moving the cursor around windows
" colemak keyboard
" noremap <LEADER>w <C-w>w
" if version >= 801
" 	tnoremap <c-n> <C-w>N
" endif	

" noremap <LEADER>u <C-w>k
" noremap <LEADER>e <C-w>j
" noremap <LEADER>n <C-w>h
" noremap <LEADER>i <C-w>l
nnoremap qf <C-w>o
" normal keyboard
nnoremap <LEADER>i <C-w>k
nnoremap <LEADER>k <C-w>j
nnoremap <LEADER>j <C-w>h
nnoremap <LEADER>l <C-w>l

nnoremap <LEADER>J <C-w>t
nnoremap <LEADER>n <C-w><C-p>

" Disable the default s key
nnoremap s <nop>
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
" colemak keyboard
" noremap su :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
" noremap se :set splitbelow<CR>:split<CR>
" noremap sn :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
" noremap si :set splitright<CR>:vsplit<CR>

" normal keyboard
nnoremap <silent> si :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
nnoremap <silent> sk :set splitbelow<CR>:split<CR>
nnoremap <silent> sj :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
nnoremap <silent> sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
nnoremap <up> :res -5<CR>
nnoremap <down> :res +5<CR>
nnoremap <left> :vertical resize-5<CR>
nnoremap <right> :vertical resize+5<CR>
" Place the two screens up and down
nnoremap sh <C-w>t<C-w>K
" Place the two screens side by side
nnoremap sv <C-w>t<C-w>H
" Rotate screens
nnoremap srh <C-w>b<C-w>K
nnoremap srv <C-w>b<C-w>H
" Press <SPACE> + q to close the window below the current window
nnoremap <silent> <leader>q :q<CR>


" ==================== Tab management ====================
" Create a new tab with tu
nnoremap <a-'> :tab split<CR>
nnoremap <a-,> :tabprevious<CR>
nnoremap <a-.> :tabnext<CR>
nnoremap <C-Left> :-tabmove<CR>
nnoremap <C-Right> :+tabmove<CR>
nnoremap <a-\> :tabclose<CR>


" ==================== Other useful stuff ====================
" Open a new instance of st with the cwd
" nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>
" Opening a terminal window
nnoremap <silent> <c-\> :split \| term<CR>
tnoremap <c-n> <c-\><c-n>
" nnoremap <LEADER>b- :b#<CR>
nnoremap <a--> :b#<CR>


" set wrap
set nowrap


function! SetWrapKeymaps()
  if index(g:SetWrapKeymapExcludeArray, &ft) >= 0
    return
  endif
  if exists('b:venn_enabled') && b:venn_enabled
    return
  endif
  if &wrap
    " 如果 wrap 為 true
    nnoremap <buffer><silent> i gk
    nnoremap <buffer><silent> k gj
    nnoremap <buffer><silent> I 5gk
    nnoremap <buffer><silent> K 5gj
    nnoremap <buffer><silent> J g0
    nnoremap <buffer><silent> L g$

    vnoremap <buffer><silent> i gk
    vnoremap <buffer><silent> k gj
    vnoremap <buffer><silent> I 5gk
    vnoremap <buffer><silent> K 5gj
    vnoremap <buffer><silent> J g0
    vnoremap <buffer><silent> L g$
  else
    " 如果 wrap 為 false
    nnoremap <buffer><silent> i k
    nnoremap <buffer><silent> k j
    nnoremap <buffer><silent> I 5k
    nnoremap <buffer><silent> K 5j
    nnoremap <buffer><silent> J 0
    nnoremap <buffer><silent> L $

    vnoremap <buffer><silent> i k
    vnoremap <buffer><silent> k j
    vnoremap <buffer><silent> I 5k
    vnoremap <buffer><silent> K 5j
    vnoremap <buffer><silent> J 0
    vnoremap <buffer><silent> L $
  endif
endfunction

" 每次切換緩衝區或打開新文件時執行 SetWrapKeymaps 函數
autocmd BufEnter * call SetWrapKeymaps()
autocmd OptionSet wrap call SetWrapKeymaps()

function! SendInputMethodCommandToLocal(mode)
  " NOTE: 這裡引入 exclude filetpe 排除 im-select 在 nvimtree 和 telescope 交互時的會造成的 window-picker 的開檔錯誤
  if &ft == 'TelescopePrompt'
    return
  endif
  " 根據模式構建命令
  if a:mode == "insert"
    let command = ["im-select.exe", "com.apple.keylayout.ABC"]
  else
    let command = ["im-select.exe", "1033"]
  endif
  " NOTE: 修改原先的 system 成 jobstart，以避免阻塞 vim (這樣即使是 1 秒的 nc 也不會影響 vim 的使用體驗
  call jobstart(command, {'detach': v:true})
endfunction

autocmd InsertEnter * call SendInputMethodCommandToLocal("insert")
autocmd InsertLeave * call SendInputMethodCommandToLocal("normal")

" === window move ===
nnoremap <a-e>l :wincmd r<CR>
nnoremap <a-e><Right> :wincmd r<CR>
nnoremap <a-e>j :wincmd H<CR>
nnoremap <a-e><Left> :wincmd H<CR>
nnoremap <a-e>i :wincmd K<CR>
nnoremap <a-e><Up> :wincmd K<CR>
nnoremap <a-e>k :wincmd j<CR>
nnoremap <a-e><Down> :wincmd j<CR>

" === gf control ===
autocmd BufEnter * if expand('%') != '' | set path=.,%:h | endif
nnoremap sF <c-w>F
nnoremap sf <c-w>f
nnoremap sgk <c-w>f
nnoremap sgl <c-w>vgf
nnoremap sgF <c-w>gF
nnoremap sgf <c-w>gf

" === change path ===
let g:WorkDirectoryPath = getcwd()
nnoremap <silent> <a-BS> :cd ../<CR>
nnoremap <silent> <leader><a-BS> :cd %:p:h<cr>
nnoremap <silent> <leader>r<a-BS> :execute ':cd ' . g:WorkDirectoryPath<cr>

function DeleteHiddenBuffers() " Vim with the 'hidden' option
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction
command! DeleteHiddenBuffers call DeleteHiddenBuffers()
nnoremap <leader>bc :DeleteHiddenBuffers<cr>

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif


" nnoremap <leader>rc :e $HOME/AppData/Local/nvim/init.vim<CR>

source $HOME/AppData/Local/nvim/.vim/vim/explorer.vim
source $HOME/AppData/Local/nvim/.vim/vim/buffer.vim
