" Enter ":Config" in normal mode to open the config
command! Config execute ":e $MYVIMRC"

" Call ":Reload" to apply the latest config contents
command! Reload execute "source $MYVIMRC"

" Yank to end of line
map Y y$

" Macro over visual range
xmap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
