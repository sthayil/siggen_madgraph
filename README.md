# siggen_madgraph
Generate MG5 .lhe files for RPV Higgsino analysis 

Download the MadGraph tarball (eg. v2_6_7) from https://launchpad.net/mg5amcnlo/+download 

Then,
```
tar -xvf MG5_aMC_v2.6.7.tar.gz 
cd MG5_aMC_v2_6_7
git clone git@github.com:sthayil/siggen_madgraph.git
cp siggen_madgraph/RPVMSSM_UFO.tar.gz models/
tar -xvf models/RPVMSSM_UFO.tar.gz
cp siggen_madgraph/restrict_iftah.dat models/RPVMSSM_UFO/
```

To generate x1_n2 events with masses mn1, mx1, mn2:
```
source 0909_mg5runner.sh x1_n2 mn1 mx1 mn2
```
Process options: n1_n1, n1_x1, x1_x1, n1_n2, x1_n2, n2_n2
If no x1 or n2, put a dummy value such as mmm for mx1, mn2
