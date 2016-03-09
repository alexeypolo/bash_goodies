# source me

function fsed()
{
    usage="fsed [--dry|-d] <normal-sed-pattern> [file-list]"

    # Parse args
    [ $# == 0 ] && echo $usage && return;

    if [ "$1" == "--dry" ] || [ "$1" == "-d" ]; then
        dry_run=1
        shift
    else
        dry_run=0
    fi

    sed_pattern=$1
    shift

    files=$*

    # Do the work

    echo File list:; echo $files

    tmp=$(mktemp)
    for f in $files; do
        cat $f | sed $sed_pattern > $tmp
        diff $f $tmp
        [ "$dry_run" == "0" ] && mv $tmp $f
    done
}
