vim.cmd([[
  function! TrimWhitespace() abort
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endfunction

  augroup Main
    autocmd!

    " Return to last known valid position
    au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Trim Whitespace
    autocmd BufWritePre * :call TrimWhitespace()

    " Highlight yank
    autocmd TextYankPost * silent! lua require("vim.highlight").on_yank({timeout = 650})

    " Set assembly ft
    autocmd BufNewFile,BufRead *.S set ft=asm
  augroup END
]])
