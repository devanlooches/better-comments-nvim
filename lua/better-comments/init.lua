HighlightTags = {}
HighlightTags["!"] = '#A00000'
local highlightNS = vim.api.nvim_create_namespace("bettercomments")
function HighlightUpdate()
    vim.api.nvim_buf_clear_namespace(0,highlightNS,0,-1)
    local lines = vim.api.nvim_buf_get_lines(0,0,-1,true)
    for i,line in pairs(lines) do
        for k,v in pairs(HighlightTags) do
            if line:match("^--"..k) ~= nil then
                vim.highlight.create("bettercomments:"..k,{guibg=v})
                vim.api.nvim_buf_add_highlight(0,highlightNS,"bettercomments:" ..k,i-1,0,-1)
            end
        end
    end
end

return {
    HighlightUpdate = HighlightUpdate
}
