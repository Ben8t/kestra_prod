#!/bin/sh

counter=10

while [ $counter -gt 0 ]
do
    echo -n "$counter "
    counter=$((counter - 1))
done

printf "\n"