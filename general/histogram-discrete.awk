#!/usr/bin/awk -f
#
# Calculates discrete histogram of data and prints unsorted the accumulated values.
# By default it runs over the firs column.
# 
BEGIN{
  if (!col) col= 1
}

{
  counts[$(col)]++;
  total++;
}

END {
  for (v in counts) {
    printf "%s %.0f %f \n", v, counts[v], counts[v]/0.01/total ;
  }
}
