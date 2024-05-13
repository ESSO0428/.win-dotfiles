" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward


nmap u <Nop>
noremap z u
" Insert Key
noremap h i
noremap H I

" Copy to system clipboard
nnoremap Y y$

" Find pair
nnoremap g{ %
vnoremap g{ %
nnoremap g} $%
vnoremap g} $%

" Search
unmap <Space>
nmap <Space><CR> :nohlsearch


" ==================== Cursor Movement ====================
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     i
" < j   l >
"     k
"     v

" normal keyborad
" for obsidian
" noremap i k
noremap i gk
noremap j h
" for obsidian
" noremap k j
noremap k gj
nmap <BS> j
imap <A-j> <Esc>


" U/E keys for 5 times u/e (faster navigation)
nmap I 5i
nmap K 5k

" for obsidian
" nmap J 0
" nmap L $
nmap J g0
nmap L g$
" noremap I 5k
" noremap K 5j

nmap W 5w
nmap E 5e
nmap B 5b

" for obsidian
vmap I 5i
vmap K 5k
vmap J g0
vmap L g$

noremap gj J
vmap gj J

" focus
exmap focusLeft obcommand editor:focus-left
exmap focusRight obcommand editor:focus-right
exmap focusBottom obcommand editor:focus-bottom
exmap focusTop obcommand editor:focus-top

nmap <Space>i :focusTop
nmap <Space>k :focusBottom
nmap <Space>j :focusLeft
nmap <Space>l :focusRight

nunmap s
" mapping vs/hs as workspace split
exmap vs obcommand workspace:split-vertical
exmap sp obcommand workspace:split-vertical
exmap hs obcommand workspace:split-horizontal
" noremap si :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
nmap sk :hs
" noremap sj :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
nmap sl :vs



" Emulate Folding https://vimhelp.org/fold.txt.html#fold-commands
exmap togglefold obcommand editor:toggle-fold
nmap <Space>o :togglefold

exmap unfoldall obcommand editor:unfold-all
nmap <Space>Od :unfoldall

exmap foldall obcommand editor:fold-all
nmap <Space>Oa :foldall

" [g]oto [f]ile (= Follow Link under cursor)
exmap followLinkUnderCursor obcommand editor:follow-link
exmap followLinkUnderCursorNew obcommand editor:open-link-in-new-leaf
nmap gf :followLinkUnderCursor
nmap <A-o> :followLinkUnderCursor
nmap <Space>gf :followLinkUnderCursorNew
nmap <Space><A-o> :followLinkUnderCursorNew

" rename file
exmap renameFile obcommand workspace:edit-file-title
nmap <Space>rn :renameFile

" Blockquote
exmap toggleBlockquote obcommand editor:toggle-blockquote
nmap < :toggleBlockquote
nmap > :toggleBlockquote

exmap write obcommand editor:save-file
nmap S :write

exmap fileExpOpen obcommand file-explorer:open
exmap fileExpOpenActive obcommand  file-explorer:reveal-active-file
" nmap <Space>e :fileExpOpen
" nmap <Space>ss :fileExpOpenActive
nmap <Space>e :fileExpOpenActive

exmap GlobalSearch obcommand global-search:open
nmap <Space>sg :GlobalSearch

exmap OpenSetting obcommand app:open-settings
nmap <Space>rc :OpenSetting

exmap TogglePin obcommand workspace:toggle-pin
nmap <Space><A-i> :TogglePin

exmap GoBackPage obcommand app:go-back
exmap GoForwardPage obcommand app:go-forward
nmap <A--> :GoBackPage
nmap <A-=> :GoForwardPage

nnoremap <A-v> <C-v>
nnoremap <C-v> p

exmap GoTabLast obcommand workspace:goto-last-tab
exmap GoTab1 obcommand workspace:goto-tab-1
exmap GoTab2 obcommand workspace:goto-tab-2
exmap GoTab3 obcommand workspace:goto-tab-3
exmap GoTab4 obcommand workspace:goto-tab-4
exmap GoTab5 obcommand workspace:goto-tab-5
exmap GoTab6 obcommand workspace:goto-tab-6
exmap GoTab7 obcommand workspace:goto-tab-7
exmap GoTab8 obcommand workspace:goto-tab-8
nmap <A-1> :GoTab1
nmap <A-2> :GoTab2
nmap <A-3> :GoTab3
nmap <A-4> :GoTab4
nmap <A-5> :GoTab5
nmap <A-6> :GoTab6
nmap <A-7> :GoTab7
nmap <A-8> :GoTab8
nmap <A-9> :GoTabLast
nmap <A-0> :GoTabLast

exmap Close obcommand workspace:close-window
nmap Q :Close

exmap ToggleComments obcommand editor:toggle-comments
nmap <Space>/ :ToggleComments

exmap ToggleHighlight obcommand editor:toggle-highlight
nmap <Space>m :ToggleHighlight

exmap ToggleList obcommand editor:toggle-bullet-list
nmap , :ToggleList

exmap FoldMore obcommand editor:fold-more
nmap <S-Tab> :FoldMore
exmap FoldLess obcommand editor:fold-less
nmap <Tab> :FoldLess

exmap WindowsFileExplorer obcommand open-with-default-app:show
nmap <A-s> :WindowsFileExplorer

exmap ToggleCheck obcommand editor:toggle-checklist-status
nmap gS :ToggleCheck

exmap CloseTabGroup obcommand workspace:close-tab-group
nmap <Space>q :CloseTabGroup


" Make o and O respect context
exmap blankBelow obcommand obsidian-editor-shortcuts:insertLineBelow
exmap blankAbove obcommand obsidian-editor-shortcuts:insertLineAbove
nmap &a& :blankAbove
nmap &b& :blankBelow
" nmap o &b&i
" nmap u &a&k
nmap o &b&
nmap u &a&
nmap U ddi
nmap O dd

exmap GoToPreviousHeading obcommand obsidian-editor-shortcuts:goToPrevHeading
exmap GoToNextHeading obcommand obsidian-editor-shortcuts:goToNextHeading
" nmap [[ :GoToPreviousHeading
" nmap ]] :GoToNextHeading
" nmap gi :GoToPreviousHeading
" nmap gk :GoToNextHeading
nmap &gtp& :GoToPreviousHeading
nmap &gtn& :GoToNextHeading
nmap gi &gtp&0
nmap gk &gtn&0

" go to github search src/main.ts (commands in id, plugin name is github repo name)
" 有時候 plugin name 可能與 github 不同，最準確的話要查載下來的目錄名稱
exmap ShowProjects obcommand obsidian-projects:show-projects
nmap <Space>rp :ShowProjects

exmap GraphOpen obcommand graph:open
nmap <Space>rb :GraphOpen

exmap new obcommand workspace:new-tab

exmap Date obcommand insert-current-date
exmap Time obcommand insert-current-time
exmap MarkdownPreview obcommand markdown:toggle-preview

exmap HoverTableEditor obcommand markdown-table-editor:markdown-table-editor-open-in-popover
nmap <Space>tm :HoverTableEditor

nmap <C-d> yyp
nnoremap x "_x
nnoremap <Space>d "_d
nnoremap <Space>D "_D
nnoremap <Space>c "_c
nnoremap <Space>C "_C
vnoremap <Space>d "_d
vnoremap <Space>D "_D
vnoremap <Space>c "_c
vnoremap <Space>C "_C

exmap HoverCurrentRelativePlot obcommand cmdr:macro-0
nmap <Space>hr :HoverCurrentRelativePlot

exmap ToggleChecklistStatus obcommand editor:toggle-checklist-status
nmap [] :ToggleChecklistStatus

exmap DecreaseHeading obcommand obsidian-heading-shifter:decrease-heading
exmap IncreaseHeading obcommand obsidian-heading-shifter:increase-heading
nmap < :DecreaseHeading
nmap > :IncreaseHeading

exmap OutlineOpen obcommand outline:open
nmap <C-t> :OutlineOpen

exmap SwitcherOpen obcommand switcher:open
nmap <Space>sf :SwitcherOpen

exmap AddH1 obcommand obsidian-heading-shifter:apply-heading1
nmap # :AddH1

exmap expandsnip obcommand  text-snippets-obsidian:text-snippets






exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap s
vunmap S
nmap s" :surround_double_quotes
nmap s' :surround_single_quotes
nmap s` :surround_backticks
nmap sb :surround_brackets
nmap s( :surround_brackets
nmap s) :surround_brackets
nmap s[ :surround_square_brackets
nmap s] :surround_square_brackets
nmap s{ :surround_curly_brackets
nmap s} :surround_curly_brackets

vmap S" :surround_double_quotes
vmap S' :surround_single_quotes
vmap S` :surround_backticks
vmap Sb :surround_brackets
vmap S( :surround_brackets
vmap S) :surround_brackets
vmap S[ :surround_square_brackets
vmap S] :surround_square_brackets
vmap S{ :surround_curly_brackets
vmap S} :surround_curly_brackets
