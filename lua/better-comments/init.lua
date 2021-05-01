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
HighlightNS = vim.api.nvim_create_namespace("bettercomments")
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
    return result
end

function MultiLineHighlightUpdate(comment_begin,comment_end)
end
function HighlightUpdate()
   vim.cmd'let g:commentstring = &commentstring'
    local commentstring = EscapeCharacters(vim.g["commentstring"])
    local position = vim.api.nvim_win_get_cursor(0)[1]
    local cursorline = vim.api.nvim_buf_get_lines(0, position-1,position,true)[1]
    InComment = false
    CommentBegin = nil
    CommentEnd = nil
    vim.api.nvim_buf_clear_namespace(0,HighlightNS,0,-1)
    local lines = vim.api.nvim_buf_get_lines(0,0,-1,true)
    for i,line in pairs(lines) do
        for k,v in pairs(HighlightTags) do
            k = EscapeCharacters(k)
            if commentstring == "<!%-%-%-%->" then
                CommentBegin = "<!--"
                CommentEnd = "-->"
            end
            if commentstring == "//" or commentstring == "/%*%*/" then
                CommentBegin = "/*"
                CommentEnd = "*/"
            end
            if commentstring == "%-%-" then
                CommentBegin = "--[["
                CommentEnd = "]]"
            end
            if CommentBegin ~= nil then
                if line:match(EscapeCharacters(CommentBegin)) then
                    InComment = true
                end
            end
            if line:match(commentstring..k) ~= nil then
                local find = line:find(commentstring..k)
                if find  ~= nil then
                    vim.highlight.create("bettercomments:"..k,v)
                    vim.api.nvim_buf_add_highlight(0,HighlightNS,"bettercomments:" ..k,i-1,find-1,-1)
                end
            else if (line:match(k) ~= nil and InComment == true) then 
            line = line:gsub(EscapeCharacters(CommentEnd), "")
            line = line:gsub(EscapeCharacters(CommentBegin), "")
                local find = line:find(k)
                if find  ~= nil then
                    vim.highlight.create("bettercomments:"..k,v)
                    vim.api.nvim_buf_add_highlight(0,HighlightNS,"bettercomments:" ..k,i-1,0,-1)
                end
            end
            if CommentEnd ~= nil then
                if line:match(EscapeCharacters(CommentEnd)) then
                    InComment = false
                end
            end
        end
        end
    end
end

return {
    HighlightUpdate = HighlightUpdate,
}

