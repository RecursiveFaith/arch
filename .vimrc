source $VIMRUNTIME/defaults.vim  " Load Vim's default settings (includes syntax highlighting
filetype plugin indent on  " Enable filetype detection and plugin/indent info
syntax on
set termguicolors
autocmd BufRead,BufNewFile *.md setfiletype markdown
set t_Co=256
set termguicolors

" Autoupdates
set autoread                                " Automatically reload files changed externally
set updatetime=1000                         " Set idle time to 1 second
autocmd FocusGained,BufEnter * checktime    " Check for external changes when gaining focus or entering a buffer
autocmd CursorHold * checktime              " Check for external changes when the cursor is idle

" Wrapping
set wrap        " Enable line wrapping
set linebreak   " Break lines at word boundaries
set nolist      " Turn off 'list' mode as it conflicts with linebreak

" Formatting
set relativenumber 

" Tabs
autocmd FileType * setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

"""""""""""
" Keyboard shortcuts
"""""""""""
let mapleader = ","
" Insert current time in HHMM format in normal mode
nnoremap <leader>t "=strftime("%H%M")<CR>P  
" Insert current time in HHMM format in insert mode
inoremap <leader>t <C-R>=strftime("%H%M")<CR> 
" Insert horizontal rule with leader+hr
nnoremap <leader>hr o<CR><CR><CR><Esc>40i=<Esc>o<CR><CR><CR><Esc>

" Yank into system clipboard in visual mode
vnoremap y y:call system('xsel -ib', @0)<CR>:redraw!<CR>
" Yank current line
nnoremap yy :call system('xsel -ib', getline('.'))<CR>:redraw!<CR>
" Yank till end of line
nnoremap Y :call system('xsel -ib', getline('.')[col('.')-1:])<CR>Y:redraw!<CR>
" Yank from cursor to start of line
nnoremap y^ :call system('xsel -ib', getline('.')[0:col('.')-2])<CR>:redraw!<CR>
" Yank from cursor to end of file
nnoremap yG :call system('xsel -ib', join(getline(line('.'), '$'), "\n"))<CR>:redraw!<CR>
" Yank from cursor to start of file
nnoremap ygg :call system('xsel -ib', join(getline(1, line('.')), "\n"))<CR>:redraw!<CR>
" Yank word under cursor
nnoremap yw :call system('xsel -ib', matchstr(getline('.'), '\%'.col('.') . 'c.*\>'))<CR>:redraw!<CR>
" Yank inner word
nnoremap yiw :call system('xsel -ib', expand('<cword>'))<CR>:redraw!<CR>
" Yank previous word
nnoremap yb :call system('xsel -ib', matchstr(getline('.'), '\%'.col('.') . 'c.*\<'))<CR>:redraw!<CR>
" Yank a paragraph
nnoremap yap :call system('xsel -ib', join(getline("'<", "'>"), "\n"))<CR>:redraw!<CR>
" Yank inner paragraph
nnoremap yip :call system('xsel -ib', join(getline("'<", "'>"), "\n"))<CR>:redraw!<CR>
" Yank a sentence
nnoremap yas :call system('xsel -ib', join(getline("'<", "'>"), "\n"))<CR>:redraw!<CR>
" Yank inner sentence
nnoremap yis :call system('xsel -ib', join(getline("'<", "'>"), "\n"))<CR>:redraw!<CR>
" Delete current line and yank into clipboard
nnoremap dd :call system('xsel -ib', getline('.'))<CR>dd:redraw!<CR>
" Delete till the end of the line and yank into clipboard
nnoremap D :call system('xsel -ib', getline('.')[col('.')-1:])<CR>D:redraw!<CR>
" Delete from cursor to start of line and yank into clipboard
nnoremap d^ :call system('xsel -ib', getline('.')[0:col('.')-2])<CR>d^:redraw!<CR>
" Delete from cursor to start of file and yank into clipboard
nnoremap dgg :call system('xsel -ib', join(getline(1, line('.')), "\n"))<CR>dgg:redraw!<CR>
" Delete from cursor to end of file and yank into clipboard
nnoremap dG :call system('xsel -ib', join(getline(line('.'), '$'), "\n"))<CR>dG:redraw!<CR>
" Delete a word and yank into clipboard
nnoremap dw :call system('xsel -ib', matchstr(getline('.'), '\%'.col('.') . 'c.*\>'))<CR>dw:redraw!<CR>
" Delete inner word and yank into clipboard
nnoremap diw :call system('xsel -ib', expand('<cword>'))<CR>diw:redraw!<CR>
" Delete previous word and yank into clipboard
nnoremap db :call system('xsel -ib', matchstr(getline('.'), '\%'.col('.') . 'c.*\<'))<CR>db:redraw!<CR>
" Delete a paragraph and yank into clipboard
nnoremap dap :call system('xsel -ib', join(getline("'<", "'>"), "\n"))<CR>dap:redraw!<CR>
" Delete inner paragraph and yank into clipboard
nnoremap dip :call system('xsel -ib', join(getline("'<", "'>"), "\n"))<CR>dip:redraw!<CR>
" Delete a sentence and yank into clipboard
nnoremap das :call system('xsel -ib', join(getline("'<", "'>"), "\n"))<CR>das:redraw!<CR>
" Delete inner sentence and yank into clipboard
nnoremap dis :call system('xsel -ib', join(getline("'<", "'>"), "\n"))<CR>dis:redraw!<CR>
" Change current line and yank deleted text into clipboard
nnoremap cc :call system('xsel -ib', getline('.'))<CR>cc:redraw!<CR>
" Change till the end of the line and yank deleted text into clipboard
nnoremap C :call system('xsel -ib', getline('.')[col('.')-1:])<CR>C:redraw!<CR>
" Change a word and yank deleted text into clipboard
nnoremap cw :call system('xsel -ib', matchstr(getline('.'), '\%'.col('.') . 'c.*\>'))<CR>cw:redraw!<CR>
" Change inner word and yank deleted text into clipboard
nnoremap ciw :call system('xsel -ib', expand('<cword>'))<CR>ciw:redraw!<CR>
" Change a paragraph and yank deleted text into clipboard
nnoremap cap :call system('xsel -ib', join(getline("'<", "'>"), "\n"))<CR>cap:redraw!<CR>
" Change inner paragraph and yank deleted text into clipboard
nnoremap cip :call system('xsel -ib', join(getline("'<", "'>"), "\n"))<CR>cip:redraw!<CR>
