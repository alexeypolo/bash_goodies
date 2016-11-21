# source me in .bashrc or .profile

# Run standard 'find' and filter results through 'grep'.
#
# Example 1: find my_file in current directory, recurse to subdirs
#     $ ff my_file
#
# Example 2: find 'file_x' and 'file_y' in directory 'dir' 
#     $ ff -d dir -e "my_file_x|my_file_y"
#
# Example 3: find 'my_file' and 'MY_FILE' in directory 'dir' 
#     $ ff -d dir -i "my_file"

function ff() {
    ff_usage="USAGE: ff [-d directory] <grep-pattern>"

    # search directory is either "." (default) or "-d <dir>"
    dir="."
    [[ "$1" == "-d" ]] && dir="$2" && shift 2;

    pattern="$*";    
    [[ ! -d "$dir" ]] && echo "Directory $dir does not exist" && return 1;    
    [[ "$pattern" == "" ]] && echo "$ff_usage" && return 1;
    find "$dir" | grep $pattern;
}
