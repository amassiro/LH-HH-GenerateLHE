# |/bin/sh
# submit to lxbash system

NUMBERSEED=$1   CSI=$2    ENERGY=$3

# alias f77="/usr/bin/g77"
# 
# ls /usr/bin

if [ $ENERGY = "13" ]; then
  ENERGYBEAM=6500
fi

if [ $ENERGY = "14" ]; then
  ENERGYBEAM=7000
fi

if [ $ENERGY = "8" ]; then
  ENERGYBEAM=4000
fi




echo " >>> check space "
hostname
df -H

echo " >>> copy the MG folder to tmp"

cd /tmp/
TESTFOLDER="test_"$ENERGY"_"$NUMBERSEED"_"$CSI
cp -r /afs/cern.ch/work/a/amassiro/Generation/HH/MG/MG_ME_V4.5.2 $TESTFOLDER

cd $TESTFOLDER

MODELFOLDER="MySO5_"$CSI

echo " >>> change parameters in model: energy and seed"

cd $MODELFOLDER

cat Cards/run_card.dat | sed -e s%7000%$ENERGYBEAM%g | sed -e s%0\ \ \ \ \ \ \ =\ iseed%$NUMBERSEED\ \ \ \ \ \ \ =\ iseed%g > Cards/run_card_TEMPENERGY.dat
cp Cards/run_card_TEMPENERGY.dat Cards/run_card.dat


echo " >>> select the model"
MODELNAME="SILH-SO5-CSI-"$CSI

cat Cards/proc_card.dat | sed -e s%MYMODELFIXME%$MODELNAME%g  > Cards/proc_card_TEMPMODEL.dat
cp Cards/proc_card_TEMPMODEL.dat Cards/proc_card.dat


NAMERESULT="SO5at"$ENERGY"TeV"

echo " >>> generate events"

export PATH=${PWD}:${PATH}
ln -s /afs/cern.ch/sw/lcg/contrib/g77/3.4.6/x86_64-slc5-gcc44-opt/bin/g77 f77
echo "PATH= ${PATH}"
which f77

./bin/generate_events 0 $NAMERESULT

cd ..

MODELFOLDERTGZ=$MODELFOLDER"_"$NUMBERSEED"_"$ENERGY".tgz"

tar -czf $MODELFOLDERTGZ    $MODELFOLDER
# rfcp $MODELFOLDERTGZ    /castor/cern.ch/user/a/amassiro/HHLHE-BIS/
# rfcp $MODELFOLDERTGZ    /castor/cern.ch/user/a/amassiro/HHLHE-SO5/
# rfcp $MODELFOLDERTGZ    /castor/cern.ch/user/a/amassiro/HHLHE-SO5-9Sep/
rfcp $MODELFOLDERTGZ    /castor/cern.ch/user/a/amassiro/HHLHE-SO5-11Sep/

cd ..
rm -r $TESTFOLDER


