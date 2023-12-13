`gd`        -> go to definition
`dt'`       -> delete until '
`ctrl+o`    -> go back
`ctrl+i`    -> go forth
`:e`        -> restart LSP
`e`         -> go over word to left
`b`         -> go over word to right
`yt<delim>` -> yank to character
`u`         -> undo
`ctrl+r`    -> redo
`viwp`      -> replace word under cursor with buffer
`w`         -> move by word to left
`b`         -> move by word to right

## Sessions
`leader sl`     -> list sessions
`leader sn`     -> create new session

## todo
- multi cursor change word

## formatting
`:!gersemi % -i`

## windows and tabs
`ctrl+r` telescope: open in vertical tab
`ctrl+w +left/right` open window to left/right

## setup
- pipx packages
    - `yay -S python-pipx`
    - `pipx ensurepath`
- cmake
    - `pipx install cmake-language-server`

## folding
- https://github.com/kevinhwang91/nvim-ufo
- `zc` to fold
- `zo` to unfold
