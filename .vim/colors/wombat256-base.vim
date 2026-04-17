" Vim color file
" Base file for machine-specific wombat256 variants.
" Do not use this file directly as a colorscheme — source it from
" wombat256-local.vim or wombat256-server.vim after defining palette variables.
"
" Required variables (define these before sourcing this file):
"   g:wom_bg          - main background        e.g. "#1a1a2e"
"   g:wom_bg_subtle   - slightly darker bg     e.g. "#141422"
"   g:wom_bg_mid      - mid-tone bg            e.g. "#2d2d2d"
"   g:wom_bg_split    - split/status bg        e.g. "#444444"
"   g:wom_cterm_bg        - cterm main bg index
"   g:wom_cterm_bg_subtle - cterm subtle bg index
"   g:wom_cterm_bg_mid    - cterm mid bg index

set background=dark

hi clear

if exists("syntax_on")
    syntax reset
endif


" General colors
execute "hi Normal       ctermfg=254  ctermbg=" . g:wom_cterm_bg        . " cterm=none  guifg=#f6f3e8  guibg=" . g:wom_bg        . " gui=none"
execute "hi Cursor       ctermfg=none ctermbg=241                     cterm=none  guifg=NONE     guibg=#656565  gui=none"
execute "hi Visual       ctermfg=7    ctermbg=238                     cterm=none  guifg=#f6f3e8  guibg=#444444  gui=none"
execute "hi Folded       ctermfg=103  ctermbg=238                     cterm=none  guifg=#a0a8b0  guibg=#384048  gui=none"
execute "hi Title        ctermfg=7    ctermbg=none                    cterm=bold  guifg=#f6f3e8  guibg=NONE     gui=bold"
execute "hi StatusLine   ctermfg=7    ctermbg=238                     cterm=none  guifg=#f6f3e8  guibg=#444444  gui=italic"
execute "hi VertSplit    ctermfg=238  ctermbg=238                     cterm=none  guifg=#444444  guibg=#444444  gui=none"
execute "hi StatusLineNC ctermfg=243  ctermbg=238                     cterm=none  guifg=#857b6f  guibg=#444444  gui=none"
execute "hi LineNr       ctermfg=243  ctermbg=" . g:wom_cterm_bg_subtle  . " cterm=none  guifg=#857b6f  guibg=" . g:wom_bg_subtle  . " gui=none"
execute "hi SpecialKey   ctermfg=244  ctermbg=" . g:wom_cterm_bg_subtle  . " cterm=none  guifg=#808080  guibg=" . g:wom_bg_subtle  . " gui=none"
execute "hi NonText      ctermfg=244  ctermbg=" . g:wom_cterm_bg_subtle  . " cterm=none  guifg=#808080  guibg=" . g:wom_bg_subtle  . " gui=none"

" Vim >= 7.0 specific colors
if version >= 700
execute "hi CursorLine               ctermbg=" . g:wom_cterm_bg_mid     . " cterm=none                guibg=" . g:wom_bg_mid     
execute "hi MatchParen   ctermfg=7   ctermbg=243                     cterm=bold  guifg=#f6f3e8  guibg=#857b6f  gui=bold"
execute "hi Pmenu        ctermfg=7   ctermbg=238                                 guifg=#f6f3e8  guibg=#444444"
execute "hi PmenuSel     ctermfg=0   ctermbg=192                                 guifg=#000000  guibg=#cae682"
endif


" Syntax highlighting
hi Keyword      ctermfg=111     cterm=none      guifg=#8ac6f2   gui=none
hi Statement    ctermfg=111     cterm=none      guifg=#8ac6f2   gui=none
hi Constant     ctermfg=173     cterm=none      guifg=#e5786d   gui=none
hi Number       ctermfg=173     cterm=none      guifg=#e5786d   gui=none
hi PreProc      ctermfg=173     cterm=none      guifg=#e5786d   gui=none
hi Function     ctermfg=192     cterm=none      guifg=#cae682   gui=none
hi Identifier   ctermfg=192     cterm=none      guifg=#cae682   gui=none
hi Type         ctermfg=192     cterm=none      guifg=#cae682   gui=none
hi Special      ctermfg=194     cterm=none      guifg=#e7f6da   gui=none
hi String       ctermfg=113     cterm=none      guifg=#95e454   gui=italic
hi Comment      ctermfg=246     cterm=none      guifg=#99968b   gui=italic
hi Todo         ctermfg=245     cterm=none      guifg=#8f8f8f   gui=italic


" Links
hi! link FoldColumn     Folded
hi! link CursorColumn   CursorLine

" vim:set ts=4 sw=4 noet:
