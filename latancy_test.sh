#!/bin/bash

echo "This is a latancy check"
echo "What is the URL you want to test latncy to?"
read furl

echo "For how many times should I run the latncy scan?"
read flatancy

rm -rf test.txt

for i in $(seq 1 $flatancy);
do
        curl -s $furl -w @curl-format.txt | grep time_total | awk '{print $2}' | tr -d ',' >> test.txt
done

count=0
total=0

for i in $(cat test.txt)
do
        total=$(bc -l <<<"${total}+${i}")
        ((count++))
done

avg=$(bc -l <<<"${total}/${count}")

echo "Here is you latancy to" $furl
echo $avg
