 if vim.g["highlightTags"] then
    HighlightTags = vim.g["highlightTags"]
else
    HighlightTags = {}
    HighlightTags["!"] = '#ff2d00'
    --[[
    "tag": "!",
    "color": "#FF2D00",
    "strikethrough": false,
    "underline": false,
    "backgroundColor": "transparent",
    "bold": false,
    "italic": false

    "tag": "?",
    "color": "#3498DB",
    "strikethrough": false,
    "underline": false,
    "backgroundColor": "transparent",
    "bold": false,
    "italic": false

    "tag": "//",
    "color": "#474747",
    "strikethrough": true,
    "underline": false,
    "backgroundColor": "transparent",
    "bold": false,
    "italic": false

    "tag": "todo",
    "color": "#FF8C00",
    "strikethrough": false,
    "underline": false,
    "backgroundColor": "transparent",
    "bold": false,
    "italic": false

    "tag": "*",
    "color": "#98C379",
    "strikethrough": false,
    "underline": false,
    "backgroundColor": "transparent",
    "bold": false,
    "italic": false
    --]]
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
            if line:match(commentstring..k) ~= nil then
                local find = line:find(commentstring)
                if find  ~= nil then
                    vim.highlight.create("bettercomments:"..k,{guifg=v})
                    vim.api.nvim_buf_add_highlight(0,highlightNS,"bettercomments:" ..k,i-1,find-1,-1)
                end
            else if line:match("^"..commentstring..k) ~= nil then
                    vim.highlight.create("bettercomments:"..k,{guifg=v})
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
