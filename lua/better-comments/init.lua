if vim.g["highlightTags"] then
    HighlightTags = vim.g["highlightTags"]
else
    HighlightTags = {}
    HighlightTags["!"] = '#F90000'
end
local highlightNS = vim.api.nvim_create_namespace("bettercomments")
function HighlightUpdate()
   vim.cmd'let g:commentstring = &commentstring'
    local commentstring = string.gsub(vim.g["commentstring"],'%%s',"")
    print(commentstring)
    local position = vim.api.nvim_win_get_cursor(0)[1]
    local cursorline = vim.api.nvim_buf_get_lines(0, position-1,position,true)[1]
    if cursorline:match("^"..commentstring) then
    vim.api.nvim_buf_clear_namespace(0,highlightNS,0,-1)
    local lines = vim.api.nvim_buf_get_lines(0,0,-1,true)
    for i,line in pairs(lines) do
        for k,v in pairs(HighlightTags) do
            if line:match(commentstring.."%s*"..k) ~= nil then
                vim.highlight.create("bettercomments:"..k,{guifg=v})
                vim.api.nvim_buf_add_highlight(0,highlightNS,"bettercomments:" ..k,i-1,0,-1)
            end
        end
    end
    end
end

return {
    HighlightUpdate = HighlightUpdate
}
