" Remove Ugly MacVim Toolbar
set go-=T

" Remove scrollbar shits
set go-=r
set go-=R
set go-=L

" Font
let s:os =  substitute(system('uname'),"\n","","")
if s:os == "Darwin"
  set guifont=Inconsolata\ For\ Powerline:h12
else
  set guifont="Inconsolata\ For\ Powerline 12"
endif
