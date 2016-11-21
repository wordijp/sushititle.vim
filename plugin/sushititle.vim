scriptencoding utf-8

if exists('g:loaded_sushititle_vim')
    finish
endif
let g:loaded_sushititle_vim = 1

let s:save_cpo = &cpo
set cpo&vim

" ---
call sushititle#start()
" ---

let &cpo = s:save_cpo
unlet s:save_cpo
