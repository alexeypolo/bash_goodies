# source me

# launch GDB and automatically run the given command with args
alias gdbrun="gdb -ex=r --args"

# Git diff with a graphical tool of your choice. Alternatively, we could get away with adding few lines to ~/.gitconfig :
# [diff]
#        tool = gvimdiff
alias gdiffx='git difftool --no-prompt --tool=gvimdiff'
alias gdiff='git difftool --no-prompt --tool=vimdiff'

# grep does not consider Python *.pyc to be a binary file, have to exclude explicitly
alias grep="grep --color=auto --exclude '*.pyc'"

# Tell 'less' to interpret color codes and other escape sequences
alias less='less -r'

# grep in C/C++ sources and headers
alias grepc++='grep -nI --include=\*.c\* --include=\*.h\* --exclude=\*.htm*'
