#!/usr/bin/env python3
#
# Identifies molecules in a molecular crystals based on bonds defined through the atomic covalent radius.
# Prints the identified molecules in .xyz format to standard output.
# Saves the reconstructed/patched structure in /tmp/patched.xyz and /tmp/patched.POSCAR (last 2 lines in the code)
#
import sys
from ase.neighborlist import *
from ase.io import read, write
from ase.io.vasp import write_vasp
from ase.data import covalent_radii

covalent_radii[11]=1.4 # decrease a bit the Na radius

fin=      str(sys.argv[1])
structure=  read(fin)
structure2= structure.copy()

try:
  lcenter= sys.argv[2]
except:
  lcenter= False


# Identify molecules based on the covalent radius * xxxx  =========================================================
nl= NeighborList(covalent_radii[structure.get_atomic_numbers()]*1.15,skin=0, self_interaction=False,bothways=True)
nl.update(structure)

#================================================
def find_molecule(atom_index):
  pool= set([])
  diff= set([atom_index])
  while diff != set([]):
    new=[]
    for i in list(diff):
      new = new + nl.get_neighbors(i)[0].tolist()

    newpool= pool | set(new)
    diff   = newpool - pool
    pool = newpool
#    print diff
  return pool | set([atom_index])
#================================================

molecules= []
todo= set(range(len(structure)))
while todo != set([]):
  cluster= find_molecule(list(todo)[0])

  if len(cluster) > 0:
    cluster_xyz= structure.get_positions()[list(cluster)]
    cluster_xyz= cluster_xyz - cluster_xyz[0]

  todo= todo - cluster

  molecules.append(list(cluster))

  # Patch the molecule around the heaviest atom
  heaviest_atom= list(cluster)[np.argmax(structure.get_masses()[list(cluster)])]
  structure.wrap(center= structure.get_scaled_positions()[heaviest_atom])
  if lcenter:
    mol_center=[0,0,0]
    mol_mass=0;
    for ic in cluster:
      mol_center= mol_center + structure.positions[ic]*structure.get_masses()[ic]
      mol_mass= mol_mass + structure.get_masses()[ic]
    structure.translate(-mol_center/mol_mass)

  # print molecule
  print (len(cluster))
  print (" xyz  ",end="")
  for i in list(cluster):
    print (i+1,end=" ")
  print ("")
  for i in list(cluster):
    print ( "{0:5s}{1:.12f} {2:.12f} {3:.12f}".format(structure.get_chemical_symbols()[i], structure[i].x, structure[i].y, structure[i].z ) )
    structure2.positions[list(cluster)]= structure.positions[list(cluster)]

write("/tmp/patched.xyz",structure2)
write_vasp("/tmp/patched.POSCAR",structure2, direct=False, sort=None, symbol_count=None, long_format=True, vasp5=True)
