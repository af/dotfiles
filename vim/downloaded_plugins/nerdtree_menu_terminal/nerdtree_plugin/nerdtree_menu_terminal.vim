if exists("g:loaded_nerdtree_menu_terminal")
  finish
endif
let g:loaded_nerdtree_menu_terminal = 1

" Add menu item to NERDTree to open selected dir in terminal
if has('nvim')
  call NERDTreeAddMenuItem({'text': 'open (t)erminal to this dir', 'shortcut': 't', 'callback': 'NERDTreeOpenTerminal'})
endif

" Open a new nvim terminal window, with its working directory set to the parent of the currently selected nerdtree file
function! NERDTreeOpenTerminal()
  let curDirNode = g:NERDTreeDirNode.GetSelected()
  let path = curDirNode.path.str()

  botright new
  execute "lcd " . path
  execute "terminal"
endfunction

