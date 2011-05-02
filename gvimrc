" Start NERDTree when gVim/MacVim Start
autocmd VimEnter * NERDTree

let s:uname = system("echo -n \"$(uname)\"")
if s:uname == "Darwin"
  set guifont=Droid\ Sans\ Mono\ Slashed:h12
else
  set guifont="Droid Sans Mono Slashed 10"
endif

" Remove Ugly MacVim Toolbar
set go-=T
