#!/usr/bin/awk -f

BEGIN {FS=","; OFS=FS}

{
  gsub(/"/, "", $3)
  if ($3 == "Error Message")
  {
    next
  }
  
  gsub(/[0-9]{2,}/, "[ID-obfuscated]", $3)
  
  if($3 ~ /^State/) {
    gsub(/[ A-Z]+\.$/, "", $3)
  }
  
  a[$3] += 1
}

END { for(i in a) print sprintf("%7d", a[i])" "i}
