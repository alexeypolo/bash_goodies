#!/bin/bash

DIRS=$*

if [ "$DIRS" == "" ]; then
    echo "USAGE: $0 dir0 dir1 ..."
    exit 1
fi
if [ "$CTAGS" == "" ]; then
    CTAGS=ctags
fi

# Build tags for source code browsing Vim/Emacs/other
ctags --extras=+q --exclude="*.js*" -R $DIRS

# Build tags for custom highlighting in Vim/Emacs/other
#
# In Vim, custom highlight can be enabled by adding these lines in ~/.vimrc
#   if filereadable("types.vim")
#       autocmd BufRead,BufNewFile *.cpp :so types.vim
#       autocmd BufRead,BufNewFile *.h :so types.vim
#       autocmd BufRead,BufNewFile *.c :so types.vim
#   endif
(ctags --exclude='*json' --c++-kinds=cgnstu -o- -R $DIRS) | awk '{printf("syntax keyword cDefine\t%s\n", $1)}' > types.vim
