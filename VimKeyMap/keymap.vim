nnoremap s; :set relativenumber!<cr>
let mapleader=" "
nnoremap Q :qa<CR>
nnoremap S :w<CR>
" Open the vimrc file anytime

" Undo operations
" colemak keyboard
" noremap l u
" normal keyboard
" nmap u <Nop>
nnoremap z u
" Insert Key
noremap h i
noremap H I

" Copy to system clipboard
vnoremap Y "+y
nnoremap Y y$

" Find pair
nnoremap g{ %
vnoremap g{ %
nnoremap g} $%
vnoremap g} $%

" Search
nnoremap <leader><CR> :nohlsearch<CR>

" Folding
nnoremap <silent> <leader>o za
nnoremap <silent> <leader>Oa zM
nnoremap <silent> <leader>Od zR

vnoremap <silent> <leader>o za
vnoremap <silent> <leader>Oa zC
vnoremap <silent> <leader>Od zO

nnoremap <silent> [{ zk
nnoremap <silent> ]} zj


nnoremap o o<ESC>
nnoremap u O<ESC>
" for vscode ...
" noremap O <Nop>
nnoremap O "_dd

nnoremap U "_ddk
nnoremap <a-i> <c-u>
nnoremap <a-k> <c-d>
" noremap <c-y> yyp
" nnoremap <c-d> "dyyp
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
nnoremap gj J
vnoremap gj J
vnoremap gj J
nnoremap <a-a> <c-x>
nnoremap <a-d> <c-a>

nnoremap <a-v> <c-v>
" ==================== Cursor Movement ====================
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     i
" < j   l >
"     k
"     v

" normal keyborad
" for vscode
" noremap <silent> i k
nnoremap <silent> i gk
nnoremap <silent> j h
vnoremap <silent> i gk
vnoremap <silent> j h
" for vscode
" noremap <silent> k j
nnoremap <silent> k gj
vnoremap <silent> k gj
" noremap <silent> l l

" colemak keyborad
" noremap <silent> gu gk
" noremap <silent> ge gj
nnoremap <silent> \v v$h

" normal keyborad
nnoremap <silent> gi gk
nnoremap <silent> gk gj
vnoremap <silent> gi gk
vnoremap <silent> gk gj

" remap gi (go to last insert position)
noremap <silent> ss gi

" U/E keys for 5 times u/e (faster navigation)
" colemak keyborad
" noremap <silent> U 5k
" noremap <silent> E 5j
" normal keyborad
" for vscode
" noremap <silent> I 5k
nnoremap <silent> I 5gk
vnoremap <silent> I 5gk
" for vscode
" noremap <silent> K 5j
nnoremap <silent> K 5gj
vnoremap <silent> K 5gj


" N key: go to the start of the line
" colemak keyborad
" noremap <silent> N 0
" normal keyborad
nnoremap <silent> J g0
vnoremap <silent> J g0
" I key: go to the end of the line
" colemak keyborad
" noremap <silent> I $
" normal keyborad
nnoremap <silent> L g$
vnoremap <silent> L g$

nnoremap <C-u> 10<C-y>
nnoremap <C-o> 10<C-e>

" ==================== buffer control =======================
nnoremap <c-j> :bprevious<CR>
nnoremap <c-l> :bnext<CR>
nnoremap <c-w> :bd<CR>
nnoremap <leader><c-w> :bd!<CR>
" ==================== Window management ====================
" Use <space> + new arrow keys for moving the cursor around windows
" colemak keyboard
" noremap <leader>w <C-w>w
tnoremap <Esc> <C-w>N

" noremap <leader>u <C-w>k
" noremap <leader>e <C-w>j
" noremap <leader>n <C-w>h
" noremap <leader>i <C-w>l
nnoremap qf <C-w>o
" normal keyboard
nnoremap <leader>i <C-w>k
nnoremap <leader>k <C-w>j
nnoremap <leader>j <C-w>h
nnoremap <leader>l <C-w>l

" Disable the default s key
nnoremap s <nop>
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
" colemak keyboard
" noremap su :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
" noremap se :set splitbelow<CR>:split<CR>
" noremap sn :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
" noremap si :set splitright<CR>:vsplit<CR>

" normal keyboard
nnoremap si :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
nnoremap sk :set splitbelow<CR>:split<CR>
nnoremap sj :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
nnoremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
nnoremap <up> :res +5<CR>
nnoremap <down> :res -5<CR>
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
nnoremap <leader>q :q<CR>
