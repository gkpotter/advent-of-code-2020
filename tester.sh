#!/bin/bash

tmp="test.tmp"

# Test Python
echo -e "Advent of Code 2020 Test\n\nPython" | tee ${tmp}
echo "-------------------------" | tee -a ${tmp}

for i in $(seq -f "%02g" 1 25)
do
	python3 days/day_${i}/main.py | tee -a  ${tmp}
	echo "-------------------------" | tee -a  ${tmp}
done

# Test OCaml
echo -e "\nOCaml" | tee -a ${tmp}
echo "-------------------------" | tee -a  ${tmp}
for i in "01" "02" "03" "04" "05" "06" "08" "09" "10" "13" "15" "19" "22" "25"
do
	cd days/day_${i}/
	corebuild main.native -quiet -pkgs str
	./main.native | tee -a  ../../${tmp}
	corebuild -clean -quiet
	cd ../..
	echo "-------------------------" | tee -a  ${tmp}
done

# Test Node.js
echo -e "\nNode.js" | tee -a ${tmp}
echo "-------------------------" | tee -a  ${tmp}
for i in "01" "04" "07" "11" "12" "14" "16" "17" "18" "20" "21" "23" "24" "25"
do
	node days/day_${i}/main.js | tee -a ${tmp}
	echo "-------------------------" | tee -a  ${tmp}
done

mv ${tmp} test.log

echo "Test results saved to: ./test.log"

exit 0