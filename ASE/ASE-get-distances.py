#!/usr/bin/env python3
#
# Calculates distances between all provided atom indexes and the first atom index provided on the command line.
# Minimum image convention is applied if applicable i.e. cell parameters provided.
# First atom has index=1
# Syntax: ASE-get-distances.py structure idx1 idx2 idx3 ... idxN
#

import sys
from ase.io import read

nn= len(sys.argv)
fin=   str(sys.argv[1])

structure= read(fin)

for i in range(3,nn):
  print ("d:{0}-{1}\t{2}".format( str(sys.argv[2]), int(sys.argv[i]), structure.get_distance(int(sys.argv[2])-1, int(sys.argv[i])-1, mic=True)) )
