# Better Comments

## Installation
Install with your favorite plugin manager.

## Configuration
You can configure different style and color tags like in the following example:
```lua
local HighlightTags = {}
HighilightTags["YOUR_TAG"] = {guifg='some_color', gui="<style(s)>"}
vim.g.highlightTags = HighlightTags
```
The gui property supports these values:
* bold
* underline
* undercurl
* inverse
* italic
* standout
* nocombine
* strikethrough
