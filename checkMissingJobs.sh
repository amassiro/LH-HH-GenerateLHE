#!/bin/bash

rfdir /castor/cern.ch/user/a/amassiro/HHLHE-MCHM4-11Sep | awk '{print $9}' > .dump_areAllTheFilesHERE.txt
MODEL="MCHM4"

for ENERGY in `seq 13 14`
do
	for CSI in `seq -w 5 10`
	do
		for NUMBERSEED in `seq 0 9`
		do
			grep -q My${MODEL}_${CSI}_${NUMBERSEED}_${ENERGY}.tgz .dump_areAllTheFilesHERE.txt
			if [[ "$?" != 0 ]]
			then
				echo "# My${MODEL}_${CSI}_${NUMBERSEED}_${ENERGY}.tgz does not exist"
				echo "./SubmitGenerateLHE.py 10 prodLHE ${MODEL} ${ENERGY} ${CSI} ${NUMBERSEED}"
			fi
		done
	done
done


#
#
#faultyjobs=""
#
#for job in `'ls' -d LSF*`
#do
#	ijob=`echo ${job} |cut -d _ -f 2`
#	grep -i -m 1 -q 'error\|no space\|no such' ${job}/STDOUT
#	if [[ "$?" == "0" ]]
#	then
#		echo "# Job ${ijob} is faulty"
#		faultyjobs=`echo "${ijob} ${faultyjobs}"`
#	fi
#done
#
##echo -e "\nfaultyjobs= ${faultyjobs}\n"
#
#echo "# Please move the corrupted outputs and resubmit the jobs by doing"
#echo "##### ##### #####"
#for ijob in `echo "${faultyjobs}"`
#do
#	executable=`grep -m 1 -o test_[0-9]*_[0-9]*_[0-9]* LSFJOB_${ijob}/STDOUT`
#	ENERGY=`echo "${executable}" | cut -d _ -f 2`	
#	NUMBERSEED=`echo "${executable}" | cut -d _ -f 3`	
#	CSI=`echo "${executable}" | cut -d _ -f 4`	
#	#echo "test_"$ENERGY"_"$NUMBERSEED"_"$CSI
#	echo "mv LSFJOB_${ijob} old/"
##	echo "./SubmitBash${MODEL}atENERGYTeV.sh ${NUMBERSEED} ${CSI} ${ENERGY}"
#done
#

