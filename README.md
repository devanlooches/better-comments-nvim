# Better Comments

[Demo Image](imgs/demo.png)

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

## Defaults
The default Configurations are as follows:
```lua
HighlightTags = {}
HighlightTags["!"] = {guifg='#ff2d00'}
HighlightTags["?"] = {guifg='#1f98ff'}
HighlightTags["todo"] = {guifg='#ff8c00'}
HighlightTags["TODO"] = {guifg='#ff8c00'}
HighlightTags["*"] = {guifg='#98C379'}
vim.g.highlightTags = HighlightTags
```
