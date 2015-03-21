" Remove Ugly MacVim Toolbar
set go-=T

" Remove scrollbar shits
set go-=r
set go-=R
set go-=L

" Font
let s:os =  substitute(system('uname'),"\n","","")
if s:os == "Darwin"
  set guifont=Input:h10
else
  set guifont="Input 10"
endif
