" Diff open windows, specifying which windows by their number
"
" Ex: With 3 windows in the top row and 1 in the bottom, diff the top left and top right windows:
"   :DiffThese 1, 3
function! s:DiffThese(...)
  let windows = a:000
  if len(a:000) == 0
    " Default to diffing the top 3 windows (assuming vimdiff)
    let windows = [1, 2, 3]
  endif

  let start_i = winnr()
  windo diffthis | if index(windows, winnr()) == -1 | set nodiff | endif
  execute start_i . "wincmd w"
endfunction

command! -n=? -bar DiffThese :call s:DiffThese(<args>)
" Assume rebasing, where your changes are in the 3rd window and the master changes are in the 1st
command! -n=0 -bar DiffTheirs :call s:DiffThese(1,2)
command! -n=0 -bar DiffMine :call s:DiffThese(2,3)
command! -n=0 -bar DiffChanges :call s:DiffThese(1,3)
command! -n=0 -bar DiffAll :call s:DiffThese(1,2,3,4)
command! -n=0 -bar DiffOff diffoff!
