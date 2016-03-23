set history=100
syntax on

" Highligh all search matches
set hlsearch

" Press Space to remove the highlighting of the current search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Open func listing for a file
noremap <silent> <F8> :TlistToggle<CR>

" Turn on line/char count at the bottom line of Vim
set ruler

" http://vim.wikia.com/wiki/Indenting_source_code

" Indentation purely with hard tabs
" set tabstop=4
" set shiftwidth=4

" Indentation without hard tabs
set expandtab
set shiftwidth=4
set softtabstop=4

" List buffers
noremap <F6> :ls<CR>:b

""""""""""""""""""""""""""""""""""""""""""""
" Show white spaces in a more intruding way
highlight ExtraWhitespace ctermbg=red guibg=red
" turn off
noremap <F9> :match
" turn on
noremap <F10> :match ExtraWhitespace /\s\+$/
""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Show whitespace characters when list is set:
set listchars=tab:>-,trail:.,extends:>,precedes:<,nbsp:_

" Toggle between displaying whitespaces characeters or not
noremap <F11> :set list!<CR>

" Turn it on on start up
:set list
""""""""""""""""""""""""""""""""""""""""""""

" Toggle between showing line numbers or not
noremap <F12> :set nu!<CR>

" Use tab for completion
" imap <Tab> <C-P>
