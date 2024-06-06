#!/bin/bash

showhelp() {
  echo "
########################################
Break a feed file into files with N lines according to feed operation.

Usage: $0 <feed_file.csv> [<lines_per_file>]

Example: $0 SUBSCRIBE_Account_Feed_20240227.csv 1000 # breaks into files with 1000 entries
"
}

footerline() {
  lines=$(wc -l $1 | sed -e 's/ .*//')
  today=$(date +%Y-%m-%d)
  echo "Trailer,$today,$lines"
}

do_split() {
  tmpdir=".tmp"
  mkdir -p "$tmpdir" 

  operation=$1
  original=$2

  basefilename=$(basename $original ".csv")

  operationfile="$tmpdir"/"$basefilename"_"$operation"_

  inprocess="$tmpdir/inprocess"
  header="$tmpdir/header"

  grep '^.\?'"$operation"'.\?' "$original" > "$inprocess"

  split -l $lines_per_file  "$inprocess" "$operationfile"

  head -n1 "$original" > "$header"

  for i in "$operationfile"*; do
    footerline "$i" >> $i
    cat "$header" "$i" > $i.csv
  done;

  mv "$tmpdir"/*.csv .
  rm -rf "$tmpdir"

  echo ""
  echo "########################################"
  echo "    Results for operation $operation "
  for i in "$basefilename"_"$operation"_*.csv; do
    echo "----------------------------------------"
    echo "Sample from: $i"
    head -n2 $i
    echo "..."
    tail -n2 $i
  done;
  echo "########################################"
}

if [ -z $1 ]; then
  showhelp
  exit 1
fi

if [ ! -f $1 ]; then
  echo "
########################################
  $1 not found
"
  showhelp
  exit 1
fi

if [ -z $2 ]; then
  lines_per_file=1000
else
  lines_per_file=$2
fi

original_file=$1

feed_file=$(basename -s .csv "$original_file")

do_split VOID "$original_file"
do_split ADD "$original_file"
do_split CHANGE "$original_file"

exit 0
