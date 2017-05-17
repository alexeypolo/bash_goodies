# source me in .bashrc or .profile
# Change from subfolder to a root folder of a Git or SVN repo

function cdr() {
    d=$PWD

    while [ "$d" != "" ]; do
        # check if this is a root folder of Git or SVN repo
        [[ (-d "$d/.git") || (-d "$d/.svn") ]] && cd "$d" && return

        # delete shortest match from end of string
        # http://tldp.org/LDP/abs/html/string-manipulation.html
        d=${d%/*}
    done
}
