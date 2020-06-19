
function! js#ObjectToFunction() range
  execute a:firstline . "," . a:lastline . 's/\([^: \t]*\):\(.*\)/this.\1 = \2/'
  execute a:firstline . "," . a:lastline . 's/, *$/;/'
endfunction


