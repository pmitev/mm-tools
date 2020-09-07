#!/usr/bin/env python3
import sys
from ase.io import read
#
# Calculates angle in degrees  between provided atom indexes.
# Minimum image convention is applied if applicable i.e. cell parameters provided.
# First atom has index=1
# Syntax: ASE-get-angle.py structure idx1 idx2 idx3
#

fin=   str(sys.argv[1])
structure= read(fin)

print ( "a:{0}-{1}-{2}\t{3}".format(str(sys.argv[2]),str(sys.argv[3]),str(sys.argv[4]), (structure.get_angle(int(sys.argv[2])-1,int(sys.argv[3])-1,int(sys.argv[4])-1, mic=True))) )
