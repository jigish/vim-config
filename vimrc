" Pathogen
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

syntax on

" Text Formatting
set textwidth=110
let &wrapmargin= &textwidth
set formatoptions=croql

set hidden
set history=1000
set number
set hlsearch
set autoindent
set smartindent
set expandtab
set smarttab
set wildmenu
set wildmode=list:longest,full
set scrolloff=3
set title
set ts=2
set sw=2
set sts=2
set laststatus=2
set statusline=%{fugitive#statusline()}\ %<%F%h%m%r%h%w%y\ [%{&ff}]\ [%{strftime(\"%c\",getftime(expand(\"%:p\")))}]%=\ [%l\/%L\:%c%V\ %o]\ [ascii:%b]\ [%P]
set ignorecase
set smartcase
set undofile
set backspace=indent,eol,start
set linespace=3
set incsearch
set shortmess=atI

" Ensure the temp dirs exist
call system("mkdir -p ~/.vim/tmp/swap")
call system("mkdir -p ~/.vim/tmp/backup")
call system("mkdir -p ~/.vim/tmp/undo")
" Change where we store swap/undo files
set dir=~/.vim/tmp/swap/
set backupdir=~/.vim/tmp/backup/
set undodir=~/.vim/tmp/undo/

" Mappings
let mapleader = ","
nnoremap <C-j> 10j
nnoremap <C-k> 10k
nnoremap <C-Down> 10<Down>
nnoremap <C-Up> 10<Up>
" Caleb's cool s and S mappings
nnoremap s i<CR><ESC>==
nnoremap S d$O<ESC>p==

" Command-T
map <silent><C-t> :CommandT<CR>
map <silent><C-b> :CommandTBuffer<CR>
let g:CommandTMaxFiles=20000
let g:CommandTMaxDepth=20

" NERDTree
let g:NERDTreeChDirMode=2
let g:NERDChristmasTree=1
nmap <leader>t :NERDTreeToggle<CR>

" Kill Bells
set vb t_vb=
if has("autocmd") && has("gui")
  au GUIEnter * set t_vb=
endif

" Visual Options
set list
set listchars=tab:▸\ ,eol:¬

" ColorScheme
set t_Co=16
set background=dark
colorscheme lucius
hi ColorColumn guibg=#363946

" Show extra whitespace
hi ExtraWhitespace guibg=#CCCCCC
hi ExtraWhitespace ctermbg=7
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" A command to delete all trailing whitespace from a file.
command! DeleteTrailingWhitespace %s:\(\S*\)\s\+$:\1:

" ColorColumn
function! ToggleColorColumn()
  if &colorcolumn == 0
    " Draw the color column wherever wrapmargin is set
    let &colorcolumn = &wrapmargin
  else
    let &colorcolumn = 0
  endif
endfunction
command! ToggleColorColumn call ToggleColorColumn()
map <leader>c :ToggleColorColumn<CR>
call ToggleColorColumn()

" TagList
map <leader>l :TlistToggle<CR>

" Fugitive
map <leader>gs :Gstatus<CR>
map <leader>gc :Gcommit<CR>
map <leader>gp :Git push<CR>
map <leader>gd :Gdiff<CR>

" Ack
map <leader>a :Ack 
