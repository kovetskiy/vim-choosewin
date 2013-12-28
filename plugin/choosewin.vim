" GUARD:
if expand("%:p") ==# expand("<sfile>:p")
  unlet! g:loaded_choosewin
endif
if exists('g:loaded_choosewin')
  finish
endif
let g:loaded_choosewin = 1
let s:old_cpo = &cpo
set cpo&vim

" Main:
let g:choosewin_active = 0
let s:options = {
      \ 'g:choosewin_statusline_replace': 1,
      \ 'g:choosewin_label_align':         'center',
      \ 'g:choosewin_label_padding':       3,
      \ 'g:choosewin_label_fill':          0,
      \ 'g:choosewin_color_label': { 'gui': ['ForestGreen', 'white', 'bold'], 'cterm': [ 9, 16] },
      \ 'g:choosewin_color_other': { 'gui': ['gray20', 'black'], 'cterm': [ 240, 0] },
      \ 'g:choosewin_color_cursor': { 'gui': ['bg', 'fg', 'underline'], 'cterm': [ 'bg', 'fg', 'underline'] },
      \ 'g:choosewin_return_on_single_win': 0,
      \ }

function! s:options_set(options) "{{{
  for [varname, value] in items(a:options)
    if !exists(varname)
      let {varname} = value
    endif
    unlet value
  endfor
endfunction "}}}
call s:options_set(s:options)

augroup plugin-choosewin
  autocmd!
  autocmd ColorScheme,SessionLoadPost * call choosewin#color_set()
augroup END

" KeyMap:
nnoremap <silent> <Plug>(choosewin)  :<C-u>call choosewin#start()<CR>

" Command
command! -bar ChooseWin call choosewin#start()

" Finish:
let &cpo = s:old_cpo
" vim: foldmethod=marker
