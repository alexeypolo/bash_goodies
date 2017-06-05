colorscheme desert

" If comparing files side-by-side, then ...
if &diff
  " double the width up to a reasonable maximum
  let &columns = (((&columns + 1) * 2 > 180) ? 180 : &columns*2)
endif
