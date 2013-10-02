LH-HH-GenerateLHE
=================

Generate LHE events for Di-Higgs

Scripts:



Example:


* compile model
..* ls -d  SILH-MCHM4-CSI-??/ | awk '{print "cd "$1"; rm *.o; make; ./couplings; cd .."}'


* create model: in MG directory and run "bin/newprocesses" (it cannot compile on lxbatch, no f77!)

..* ./CreateModelGenerateLHE.sh  10
..* ./CreateModelGenerateLHEMCHM4.sh  10


* submit generation of LHE events (stored to castor)

..* ./SubmitGenerateLHE.py    10     prodLHESO5    SO5     13      10
..* ./SubmitGenerateLHE.py    10     prodLHEMCHM4    MCHM4     13      10




