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

To generate x1_n2 events, first do:
```
../bin/mg5_aMC generate_x1_n2_twoorthreeleptons.mg5
```

Then, to generate events with masses mn1, mx1, mn2, do:
```
source 0416_mg5runner.sh x1_n2 mn1 mx1 mn2
```