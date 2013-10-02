#!/bin/bash

faultyjobs=""

for job in `'ls' -d LSF*`
do
	ijob=`echo ${job} |cut -d _ -f 2`
	grep -i -m 1 -q 'error\|no space\|no such' ${job}/STDOUT
	if [[ "$?" == "0" ]]
	then
		echo "# Job ${ijob} is faulty"
		faultyjobs=`echo "${ijob} ${faultyjobs}"`
	fi
done

#echo -e "\nfaultyjobs= ${faultyjobs}\n"

MODEL="SO5"
echo "# Please move the corrupted outputs and resubmit the jobs by doing"
echo "##### ##### #####"
for ijob in `echo "${faultyjobs}"`
do
	executable=`grep -m 1 -o test_[0-9]*_[0-9]*_[0-9]* LSFJOB_${ijob}/STDOUT`
	ENERGY=`echo "${executable}" | cut -d _ -f 2`	
	NUMBERSEED=`echo "${executable}" | cut -d _ -f 3`	
	CSI=`echo "${executable}" | cut -d _ -f 4`	
	#echo "test_"$ENERGY"_"$NUMBERSEED"_"$CSI
	if [$NUMBERSEED == ""]
	then
	 a=100
    else
     echo "mv LSFJOB_${ijob} old/"
#	echo "./SubmitBash${MODEL}atENERGYTeV.sh ${NUMBERSEED} ${CSI} ${ENERGY}"
     echo "./ReSubmitGenerateLHE.py 10 prodLHESO5 ${MODEL} ${ENERGY} ${CSI} ${NUMBERSEED}"
    fi
done


