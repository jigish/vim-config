" Pathogen
call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

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
set encoding=utf-8
set tags+=.tags
set ignorecase
set smartcase
set undofile
set backspace=indent,eol,start
set linespace=3
set incsearch
set shortmess=atI
set completeopt-=preview

" airline
let g:airline_powerline_fonts = 1

" Go specific settings
augroup golang
  au!
  au FileType go setlocal noexpandtab
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
let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_files=20000
let g:ctrlp_max_depth=20

" NERDTree
let g:NERDTreeChDirMode=2
let g:NERDChristmasTree=1
nmap <leader>t :NERDTreeToggle<CR>
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
nnoremap <silent><F6> :DeleteTrailingWhitespace<CR>

" Reload files
nnoremap <silent><F5> :!/usr/local/bin/ctags -f .tags -R . &<CR><CR>:NERDTree<CR>:ClearAllCtrlPCaches<CR>:NERDTreeToggle<CR>

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

" Ag (better than Ack)
if executable("ag")
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif
map <leader>aw yiw:Ack <c-r>0<CR>
map <leader>aa :Ack 
map <leader>af :AckFile 

" Ctags
map <leader>tw yiw:tag <c-r>0<CR>
map <leader>ts :ts<CR>
map <leader>tn :tn<CR>
map <leader>tp :tp<CR>
map <leader>tf :tf<CR>
map <leader>tl :tl<CR>
map <leader>tt :pop<CR>

" Tagbar
nmap <leader>tb :TagbarToggle<CR>

" ActionScript
au BufNewFile,BufRead *.as  setf actionscript

" Make
nnoremap <leader>mm :wa<CR>:make<CR>
nnoremap <leader>mc :wa<CR>:!make clean<CR>
nnoremap <leader>mt :wa<CR>:!make test<CR>
nnoremap <leader>mf :wa<CR>:!make fmt<CR>
nnoremap <leader>mp :wa<CR>:!TEST_PACKAGE=`echo "%:p:h" \| sed 's-.*/src/\(.*\)-\1-'` make test<CR>

" Rake
nnoremap <leader>rt :wa<CR>:!rake test<CR>
nnoremap <leader>rf :wa<CR>:!rake test SPEC=`echo "%:p"`<CR>
nnoremap <leader>r' yi':wa<CR>:!rake test SPEC=`echo "%:p"` SPEC_OPTS="-e \"<c-r>0\""<CR>
nnoremap <leader>r" yi":wa<CR>:!rake test SPEC=`echo "%:p"` SPEC_OPTS="-e \"<c-r>0\""<CR>

" NeoComplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#disable_auto_complete = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <C-l> <C-x><C-u>
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup()."\<Space>" : "\<Space>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
