fun! BetterComments()
    lua for k in pairs(package.loaded) do if k:match("^better%-comments") then package.loaded[k] = nil end end
    lua require('better-comments').HighlightUpdate()
endfun

augroup BetterComments
    autocmd CursorMoved,CursorMovedI * :call BetterComments()
augroup END

"Example configuration
"lua << END
"local HighlightTags = {}
"HighlightTags["TEST"] = '#FF9000'
