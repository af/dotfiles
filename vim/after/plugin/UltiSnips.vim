" Stop UltiSnips from messing with the following vimrc mappings:
"     xnoremap <Tab> >gv
"     xnoremap <S-Tab> <gv

" Found via https://www.reddit.com/r/vim/comments/35b13h/what_does_your_tab_key_do/cr3b1hu<F37>
try
    call UltiSnips#map_keys#MapKeys()

    xunmap <Tab>
    xnoremap <Tab> >gv

    exec "xnoremap <silent> T :call UltiSnips#SaveLastVisualSelection()<cr>gvs"

    let did_UltiSnips_after=1
catch /E117/
endtry
