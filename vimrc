" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" NeoBundle
if has('vim_starting')
  set nocompatible " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-ragtag'
NeoBundle 'tpope/vim-git'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'gregsexton/Muon'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'bling/vim-airline'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'saltstack/salt-vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'vim-scripts/AnsiEsc.vim'
NeoBundle 'vim-scripts/LargeFile'
" Lazy load shit because I don't always use them
NeoBundleLazy 'scrooloose/nerdtree'
NeoBundleLazy 'majutsushi/tagbar'
NeoBundleLazy 'vim-ruby/vim-ruby'
autocmd FileType ruby,rb,erb,ru NeoBundleSource vim-ruby
NeoBundleLazy 'scrooloose/syntastic'
autocmd FileType ruby,rb,erb,ru NeoBundleSource syntastic
NeoBundleLazy 'fatih/vim-go'
autocmd FileType go NeoBundleSource vim-go
" NeoBundle 'myusuf3/numbers.vim' " unused because it is slow

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" Text Formatting
syntax on
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
set encoding=utf-8
set tags+=.tags
set ignorecase
set smartcase
set undofile
set backspace=indent,eol,start
set linespace=1
set incsearch
set shortmess=atI
set completeopt-=preview

" my fingers are slow. bind :W to :w & :Wq to :wq & :Wa to :wa
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
cnoreabbrev <expr> Wa ((getcmdtype() is# ':' && getcmdline() is# 'Wa')?('wa'):('Wa'))

" vimproc > !
nnoremap ! :VimProcBang 


" airline
let g:airline_powerline_fonts=1
let g:airline_theme='lucius'

" Go specific settings
augroup golang
  au!
  au FileType go setlocal noexpandtab
  au FileType go let $GOPATH = getcwd() . ':' . getcwd() . '/vendor' " most of my go projects use this structure
augroup END

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
" Caleb's cool s and S mappings
nnoremap s i<CR><ESC>==
nnoremap S d$O<ESC>p==

" yank to and paste from clipboard
vnoremap <leader>yc "*y
nnoremap <leader>yv "*p

" Fucking Arrow Keys
nnoremap <Up> <ESC>
nnoremap <Down> <ESC>
nnoremap <Left> <ESC>
nnoremap <Right> <ESC>
inoremap <Up> <ESC>
inoremap <Down> <ESC>
inoremap <Left> <ESC>
inoremap <Right> <ESC>

" Ctrl-P
let g:ctrlp_map='<c-y>'
nnoremap <silent><C-t> :CtrlP pwd<CR>
nnoremap <silent><C-b> :CtrlPBuffer<CR>
nnoremap <silent><C-p> :CtrlPTag<CR>
let g:ctrlp_custom_ignore={
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(so|class)$',
  \ }
let g:ctrlp_max_files=20000
let g:ctrlp_max_depth=20
if executable("ag")
  let g:ctrlp_user_command = 'ag %s --ignore "*.class" -l --nocolor -g ""'
endif

" NERDTree
let g:NERDTreeChDirMode=2
let g:NERDChristmasTree=1
nmap <leader>t :NeoBundleSource nerdtree<CR>:NERDTreeToggle<CR>
" Exit vim if NERDTree is the last window open
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Kill Bells
set vb t_vb=
if has("autocmd") && has("gui")
  au GUIEnter * set t_vb=
endif

" Visual Options
set list
set listchars=tab:▸\ ,eol:¬

" ColorScheme
set t_Co=256
set background=dark
colorscheme muon
let g:gitgutter_override_sign_column_highlight=0
hi SignColumn ctermbg=bg
hi link GitGutterAdd          Special
hi link GitGutterChange       Statement
hi link GitGutterDelete       String
hi link GitGutterChangeDelete PreProc

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
nnoremap <silent><F6> :DeleteTrailingWhitespace<CR>

" Reload files
nnoremap <silent><F5> :VimProcBang /usr/local/bin/ctags -f .tags -R . &<CR><CR>:NERDTree<CR>:ClearAllCtrlPCaches<CR>:NERDTreeToggle<CR>

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

" Fugitive
map <leader>gs :Gstatus<CR>
map <leader>gc :Gcommit<CR>
map <leader>gp :Git push<CR>
map <leader>gl :Git pull<CR>
map <leader>gd :Gdiff<CR>
map <leader>gb :Gblame<CR>
map <leader>ga :Git add .<CR>
nnoremap <leader>gD <c-w>h<c-w>c

" Git Gutter
map <leader>gg :GitGutterToggle<CR>
map <leader>gr :GitGutterToggle<CR>:GitGutterToggle<CR>

" Ag (better than Ack)
if executable("ag")
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif
map <leader>aw yiw:Ack <c-r>0<CR>
map <leader>aa :Ack 
map <leader>as :Ack -s 
map <leader>af :AckFile 

" eclim
au BufEnter *.java map <leader>tw :JavaSearch<CR>
au BufEnter *.scala map <leader>tw :ScalaSearch<CR>
au BufLeave *.java,*.scala map <leader>tw yiw:tag <c-r>0<CR>
let g:EclimJavaSearchSingleResult='edit'
let g:EclimScalaSearchSingleResult='edit'
map <leader>er :ProjectDelete <c-r>=expand('%:p:h:t')<CR><CR>:ProjectImport .<CR>:ProjectOpen<CR>

" ctags
map <leader>tw yiw:tag <c-r>0<CR>
map <leader>ts :ts<CR>
map <leader>tn :tn<CR>
map <leader>tp :tp<CR>
map <leader>tf :tf<CR>
map <leader>tl :tl<CR>
map <leader>tt :pop<CR>

" Tagbar
nmap <leader>tb :NeoBundleSource tagbar<CR>:TagbarToggle<CR>

" Make
nnoremap <leader>mm :wa<CR>:!make<CR>
nnoremap <leader>mc :wa<CR>:VimProcBang make clean<CR>
nnoremap <leader>mt :wa<CR>:VimProcBang make test<CR>
nnoremap <leader>mf :wa<CR>:VimProcBang make fmt<CR>

" Rake
nnoremap <leader>rt :wa<CR>:VimProcBang rake test SPEC_OPTS="--no-color"<CR>
nnoremap <leader>rf :wa<CR>:VimProcBang rspec --no-color <c-r>%<CR>
nnoremap <leader>rl :wa<CR>:VimProcBang rspec --no-color <c-r>%:<c-r>=line(".")<CR><CR>

" Exec
nnoremap <leader>ee ^y$:VimProcBang <c-r>0<CR>

" ruby-specific
" convert strings to symbols and visa-versa
nnoremap <leader>sw" :silent! normal ds"<ESC>i:<ESC>
nnoremap <leader>sw' :silent! normal ds'<ESC>i:<ESC>
nnoremap <leader>ss" :silent! normal ysiw"<ESC>:silent! normal hx<ESC>
nnoremap <leader>ss' :silent! normal ysiw'<ESC>:silent! normal hx<ESC>

" underscore to camelcase
vmap <leader>c :s-_\([a-z]\)-\U\1-g<CR>

" buffer management
nnoremap <leader>bd :bdelete<CR>

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
