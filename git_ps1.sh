# source me
git_branch() {
  git branch 2>/dev/null | grep '^*' | colrm 1 2
}
