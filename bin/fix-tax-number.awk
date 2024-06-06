#!/usr/bin/awk -f

BEGIN {FS=","; OFS=FS}
{
  gsub(/"/, "", $8)
  $8 = sprintf("\"%09d\"", $8)
  print
}
