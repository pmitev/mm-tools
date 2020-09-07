#!/usr/bin/awk -f
#
# Calculates a histogram of data from the 1st column of a file
# within specified range and bin size.
# Default parameters are "hard coded" to avoid 
# reading the data multiple times or loading it in memory.
#
BEGIN{ 
  if (!col) col= 1
  if (!min) min= 0
  if (!max) max= 4000
  if (!dx)  dx = 1.
  
  n= 0; m= 0;
}

{ 
  nh= (max-min)/dx 
  m++ ; x= $(col)
  if( x >= min && x <= max ) {
    n++
    i= int((x-min)/dx) + 1
    h[i]= h[i] + 1.0
  }
}

END{
 print " #... histogram parameters: min= "min" max= "max" dx= "dx" nbins= "nh
 print " #... data points read "m" ; data points in range "n
  x= min-dx/2.0
  for(i=1;i<=nh;i++) {
    x= x + dx
    printf("%10.4f\t%12.6f\t%12.6f\n", x, h[i], h[i]/n/dx )
  }
}
