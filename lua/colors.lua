vim.cmd([[
  function! MyHighlights() abort
    hi LspReferenceText gui=underline cterm=underline guifg=0 guibg=0
    hi LspReferenceRead gui=underline cterm=underline guifg=0 guibg=0
    hi LspReferenceWrite gui=underline cterm=underline guifg=0 guibg=0
    hi FloatermBorder guibg=#192330 guifg=#415166
    hi NonText guifg=#15AABF
    hi Visual ctermbg=darkred ctermfg=0
    hi CursorLine cterm=NONE ctermbg=black
    hi VertSplit guibg=#0D131A
  endfunction

  augroup MyColors
    autocmd!
    autocmd ColorScheme,BufEnter * :call MyHighlights()
  augroup END
]])

vim.g.rehash256 = 1
vim.opt.termguicolors = true
-- Nightfox theme
vim.cmd("colorscheme nightfox")
