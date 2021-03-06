# |/bin/sh
# create model for CSI

CSI=$1

cd /afs/cern.ch/work/a/amassiro/Generation/HH/MG/MG_ME_V4.5.2.Model4

MODELFOLDER="MyMCHM4_"$CSI
rm -r $MODELFOLDER
cp -r MyMCHM4_XX  $MODELFOLDER

echo " >>> change parameters in model: energy and seed"

cd $MODELFOLDER

echo " >>> select the model"
MODELNAME="SILH-MCHM4-CSI-"$CSI

cat Cards/proc_card.dat | sed -e s%MYMODELFIXME%$MODELNAME%g  > Cards/proc_card_TEMPMODEL.dat
cp Cards/proc_card_TEMPMODEL.dat Cards/proc_card.dat

echo " >>> prepare newprocess"

./bin/newprocess

cd /afs/cern.ch/work/a/amassiro/Generation/HH/MG
