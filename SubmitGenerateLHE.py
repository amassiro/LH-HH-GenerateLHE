#!/bin/env python

# example:
#                         bunch   folder    model  energy   CSI
#./SubmitGenerateLHE.py    10     prodLHE    SO5     13      09
#./SubmitGenerateLHE.py    10     prodLHE   MCHM4    13      09


import os
import subprocess
import sys

max    = int(sys.argv[1])
folder = sys.argv[2]
model  = sys.argv[3]
energy = sys.argv[4]
csi    = sys.argv[5]
blabla = sys.argv[6]

wd     = os.getcwd()
queue  = '1nd'
#queue  = '1nh' # -> not enough !?!?
newfol = '{FOLDER}_{ENERGY}'.format(FOLDER=folder, ENERGY=energy)
os.system('mkdir -p {PWD}/{NEW}'.format(PWD=wd,NEW=newfol))



if len(sys.argv) == 1:
   print "uff, not enough information"
   sys.exit(0)


# inputs:
#   SubmitBashSO5atENERGYTeV.sh    NUMBERSEED=$1   CSI=$2    ENERGY=$3
#   SubmitBashMCHM4atENERGYTeV.sh  NUMBERSEED=$1   CSI=$2    ENERGY=$3

for i in range(max) :
  command = '#!/bin/bash\n\
              cd {PWD}\n\
              ./SubmitBash{MODEL}atENERGYTeV.sh {ITER} {CSI} {ENERGY} \n \
             '.format(PWD=wd, MODEL=model, ITER=str(i), CSI=csi, ENERGY=energy).replace('  ','')

  fname = '/'.join([wd,newfol,'sub_'+str(i)+'_'+model+'_'+energy+'_'+csi+'.sh'])
  f1    = open(fname, 'w+')
  print >> f1 , command
  os.system('chmod 755 {FILE}'.format(FILE=fname)) 
  f1.close()

#for i in range(max) :
for i in [blabla] :
  fname = '/'.join([wd,newfol,'sub_'+str(i)+'_'+model+'_'+energy+'_'+csi+'.sh'])
  subprocess.Popen(['bsub -q {QUEUE} < {FILE}'.format(QUEUE=queue,FILE=fname)], stdout=subprocess.PIPE, shell=True)
