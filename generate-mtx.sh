#!/bin/bash

app=./build/PaRMAT

niter=0
scale_min=0
scale_max=0

while test $# -gt 0
do
    case "$1" in
        --niter)
            echo "Building MADNESS"
            niter=$2
            ;;
        --scale-min) echo "Building MADNESS fork"
            scale_min=$2
            ;;
        --scale-max) echo "Building hcnc"
            scale_max=$2
            ;;
        --*) echo "bad option $1"
            ;;
        *) echo "argument $1"
            ;;
    esac
    shift
    shift
done

for ((i=0; i<niter; i++)); do
  for ((scale=scale_min; scale <= scale_max; scale++)); do
      nver=$((2**scale))
      nedges=$((nver*16))
      $app -nVertices ${nver} -nEdges ${nedges} -a 0.57 -b 0.19 -c 0.19 -output out.txt -threads 12 -memUsage 0.75

      dir=rmat/g500-${scale}
      mkdir -p ${dir}
      # shellcheck disable=SC2012
      cnt=$(ls -1 ${dir} | wc -l)
      out=${dir}/$((cnt + 1)).mtx

      echo "%%MatrixMarket matrix coordinate integer general" > ${out}
      echo ${nver} ${nver} ${nedges} >> ${out}
      while IFS=$'\t' read -r row col; do
          echo $((row+1)) $((col+1)) $((1 + RANDOM % 10)) >> ${out}
      done < out.txt
  done
done

rm -f out.txt

