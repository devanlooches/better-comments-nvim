fun! BetterComments()
    lua for k in pairs(package.loaded) do if k:match("^better%-comments") then package.loaded[k] = nil end end
    lua require('better-comments').HighlightUpdate()
endfun

augroup BetterComments
    autocmd VimEnter,TextChanged,TextChangedI * :call BetterComments()
augroup END

"Example configuration
lua << END
local HighlightTags = {}
HighlightTags["TEST"] = {guifg='#FF9000'}
HighlightTags["!"] = {guifg='#A00000'}
vim.g.highlightTags = HighlightTags
END
