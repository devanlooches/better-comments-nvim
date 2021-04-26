 if vim.g["highlightTags"] then
    HighlightTags = vim.g["highlightTags"]
else
    HighlightTags = {}
    HighlightTags["!"] = {guifg='#ff2d00'}
    HighlightTags["?"] = {guifg='#1f98ff'}
    HighlightTags["todo"] = {guifg='#ff8c00'}
    HighlightTags["TODO"] = {guifg='#ff8c00'}
    HighlightTags["*"] = {guifg='#98C379'}
end
local highlightNS = vim.api.nvim_create_namespace("bettercomments")
function EscapeCharacters(string)
    local result = string;
    result = result:gsub("%%s","")
    result = result:gsub("%%","%%%%")
    result = result:gsub("%[","%%[")
    result = result:gsub("%]","%%]")
    result = result:gsub("%(","%%(")
    result = result:gsub("%)","%%)")
    result = result:gsub("+","%%+")
    result = result:gsub("*","%%*")
    result = result:gsub("-","%%-")
    result = result:gsub("?","%%?")
    result = result:gsub("\"","\\\"")
    return result
end
function HighlightUpdate()
   vim.cmd'let g:commentstring = &commentstring'
    local commentstring = EscapeCharacters(vim.g["commentstring"])
    print(commentstring)
    local position = vim.api.nvim_win_get_cursor(0)[1]
    local cursorline = vim.api.nvim_buf_get_lines(0, position-1,position,true)[1]
    if cursorline:match(commentstring) then
    vim.api.nvim_buf_clear_namespace(0,highlightNS,0,-1)
    local lines = vim.api.nvim_buf_get_lines(0,0,-1,true)
    for i,line in pairs(lines) do
        for k,v in pairs(HighlightTags) do
            k = EscapeCharacters(k)
            if line:match(commentstring..k) ~= nil then
                local find = line:find(commentstring)
                if find  ~= nil then
                    vim.highlight.create("bettercomments:"..k,v)
                    vim.api.nvim_buf_add_highlight(0,highlightNS,"bettercomments:" ..k,i-1,find-1,-1)
                end
            else if line:match("^"..commentstring..k) ~= nil then
                    vim.highlight.create("bettercomments:"..k,v)
                    vim.api.nvim_buf_add_highlight(0,highlightNS,"bettercomments:"..k,i-1,0,-1)
            end
        end
    end
    end
end
end

return {
    HighlightUpdate = HighlightUpdate
}
