# source me

# launch GDB and automatically run the given command with args
alias gdbrun="gdb -ex=r --args"

# Git diff with a graphical tool of your choice. Alternatively, we could get away with adding few lines to ~/.gitconfig :
# [diff]
#        tool = gvimdiff
alias gdiff='git difftool --no-prompt --tool=gvimdiff'

# grep in C/C++ sources and headers
alias grepc++='grep --include=\*.h\* --include=\*.c\*'
