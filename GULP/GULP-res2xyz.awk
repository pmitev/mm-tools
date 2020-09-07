#!/usr/bin/awk -f
#
# Extracts the geopmetry from GULP .res file and writes in .xyz format
# Note, that the script does not work for structures build with symmetry 
#
BEGIN{
  ss="H,He,Li,Be,B,C,N,O,F,Ne,Na,Mg,Al,Si,P,S,Cl,Ar,K,Ca,Sc,Ti,V,Cr,Mn,Fe,Co,Ni,Cu,Zn,Ga,Ge,As,Se,Br,Kr,Rb,Sr,Y,Zr,Nb,Mo,Tc,Ru,Rh,Pd,Ag,Cd,In,Sn,Sb,Te,I,Xe,Cs,Ba,La,Ce,Pr,Nd,Pm,Sm,Eu,Gd,Tb,Dy,Ho,Er,Tm,Yb,Lu,Hf,Ta,W,Re,Os,Ir,Pt,Au,Hg,Tl,Pb,Bi,Po,At,Rn,Fr,Ra,Ac,Th,Pa,U,Np,Pu,Am,Cm,Bk,Cf,Es,Fm,Md,No,Lr,Rf,Ha,D"
  split(ss,atsym,",")
  ms="1.00794,4.002602,6.941,9.012182,10.811,12.0107,14.0067,15.9994,18.9984032,20.1797,22.989770,24.3050,26.981538,28.0855,30.973761,32.065,35.453,39.948,39.0983,40.078,44.955910,47.867,50.9415,51.9961,54.938049,55.845,58.933200,58.6934,63.546,65.39,69.723,72.64,74.92160,78.96,79.904,83.80,85.4678,87.62,88.90585,91.224,92.90638,95.94,98,101.07,102.90550,106.42,107.8682,112.411,114.818,118.710,121.760,127.60,126.90447,131.293,132.90545,137.327,138.9055,140.116,140.90765,144.24,145,150.36,151.964,157.25,158.92534,162.50,164.93032,167.259,168.93421,173.04,174.967,178.49,180.9479,183.84,186.207,190.23,192.217,195.078,196.96655,200.59,204.3833,207.2,208.98038,208.98,209.99,222.02,223.02,226.03,227.03,232.0381,231.03588,238.02891,237.05,244.06,243.06,247.07,247.07,251.08,252.08,257.10,258.10,259.10,262.11,261.11,262.11,266.12,264.12,269.13,268.14,271.15,272.15,277,0,285,0,289,0,293"
  split(ms,atmass,",")
  for (j in atsym) atnmr[atsym[j]]=j
  #print atsym[8]
  #print atnmr["Ti"]
  #print atmass[8]
}

/svec/ {getline; printf $1" "; getline; print $2"   1.0000 "; }

/name/ {label=$0}

$2=="core" && $3*1.==$3 && $4*1.==$4 && $5*1.==$5 {
  i++
#  printf"%i  %9.5f %9.5f %9.5f  %i\n",i,$3,$4,$5,atnmr[$1]
  ttt=ttt sprintf("%s  %9.5f %9.5f %9.5f\n",$1,$3,$4,$5);
}

END{
  print i
  print label  
  print ttt
}
