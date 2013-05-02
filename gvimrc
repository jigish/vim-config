" Start NERDTree when gVim/MacVim Start
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd l

let s:os =  substitute(system('uname'),"\n","","")
if s:os == "Darwin"
  set guifont=Inconsolata:h12
else
  set guifont="Inconsolata 12"
endif

" Remove Ugly MacVim Toolbar
set go-=T
