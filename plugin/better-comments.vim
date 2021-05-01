function! UpdateBetterComments()
    lua require('better-comments').HighlightUpdate()
endfun

augroup BetterComments
    autocmd VimEnter,TextChanged,TextChangedI * :call UpdateBetterComments()
    autocmd VimEnter,TextChanged,TextCHangedI * lua for k in pairs(package.loaded) do if k:match("^better%-comments") then package.loaded[k] = nil end end
augroup END


"Example configuration
"lua << END
"local HighlightTags = {}
"HighlightTags["YOUR_TAG"] = {guifg='#FF9000'}
"vim.g.highlightTags = HighlightTags
"END
