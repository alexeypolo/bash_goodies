# source me

FMT_RED="\e[1m\e[31m"                                                                                                                                     
FMT_GREEN="\e[1m\e[32m"
FMT_BLUE="\e[1m\e[34m"
FMT_BOLD="\e[1m"
FMT_OFF="\e[0m"

function echo_red()   { echo -e $FMT_RED"$*"$FMT_OFF; }
function echo_blue()  { echo -e $FMT_BLUE"$*"$FMT_OFF; }
function echo_green() { echo -e $FMT_GREEN"$*"$FMT_OFF; }
function echo_bold()  { echo -e $FMT_BOLD"$*"$FMT_OFF; }
