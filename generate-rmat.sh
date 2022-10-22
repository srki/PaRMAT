#!/bin/bash

app=./build/PaRMAT

for scale in {8..10}; do
    nver=$((2**scale))
    nedges=$(($nver*16))
    $app -nVertices ${nver} -nEdges ${nedges} -a 0.57 -b 0.19 -c 0.19 -output out.txt -threads 12 -memUsage 0.75

    dir=rmat/g500-${scale}
    mkdir -p ${dir}
    cnt=$(ls -1 ${dir} | wc -l)
    out=${dir}/$((cnt + 1)).mtx
    echo ${out}
    echo "%%MatrixMarket matrix coordinate integer general" > ${out}
    echo ${nver} ${nver} ${nedges} >> ${out}
    while IFS=$'\t' read -r row col; do
        echo $((row+1)) $((col+1)) $((1 + RANDOM % 10)) >> ${out}
    done < out.txt
done
 rm -f out.txt