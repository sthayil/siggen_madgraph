# siggen_madgraph
Generate MG5 .lhe files for RPV Higgsino analysis 

Download the MadGraph tarball (eg. v2_6_7) from https://launchpad.net/mg5amcnlo/+download 

Then,
```
tar -xvf MG5_aMC_v2.6.7.tar.gz 
cd MG5_aMC_v2_6_7
git clone git@github.com:sthayil/siggen_madgraph.git
cp siggen/RPVMSSM_UFO.tar.gz models/
tar -xvf models/RPVMSSM_UFO.tar.gz
cp siggen/restrict_iftah.dat models/RPVMSSM_UFO/
```

To generate n1_x1 events with masses mn1 and mx1,
```
source 0307_newmg5runner_n1x1.sh mn1 mx1
```
