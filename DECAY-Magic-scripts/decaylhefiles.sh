#!/bin/bash
#com="8TeV"
com="14TeV"
#com="13TeV"

#for index in `seq 0 3`
for index in `seq 0 0`
do
#	file=`echo "${com}_run${index}_events.lhe"`
	file=`echo "unweighted_events_DEBUG_run${index}_${com}.lhe"`
	echo "##### Treating file ${file} #####"
	base=${file%.*}
	awk '/\ \ 25\ \ /&&v++%2{sub(/\ \ 25\ \ \ \ 1/, "\ \ 45\ \ \ \ 1")}{print}' ${file} > ${base}_temp_v1.lhe
	if [[ "${index}" == "0" ]]
	then
		h1="1"; h2="7"; finalname="2B2G"
	elif [[ "${index}" == "1" ]]
	then
		h1="1"; h2="2"; finalname="2B2Tau"
	elif [[ "${index}" == "2" ]]
	then
		h1="1"; h2="11"; finalname="2B2WToLNuLNu"
	elif [[ "${index}" == "3" ]]
	then
		h1="1"; h2="13"; finalname="2B2WToJJLNu"
	fi
	./decaythis.exp ${base}_temp_v1.lhe ${base}_temp_v2.lhe ${h1}
#	sed -e "/  45    1/s/0.00000000000E+00 0. -1./0.12500000000E+03 0. -1./g" ${base}_temp_v2.lhe > ${base}_temp_v2bis.lhe
	sed -e "/  45    1/s/0.00000000000E+00 0. -1./0.12000000000E+03 0. -1./g" ${base}_temp_v2.lhe > ${base}_temp_v2bis.lhe
	sed -e "s/  45    1/  25    1/g" ${base}_temp_v2bis.lhe > ${base}_temp_v3bis.lhe
	./decaythis.exp ${base}_temp_v3bis.lhe GluGluToHHTo${finalname}_M-125_${com}_madgraph_v2.lhe ${h2}
#	break
done

