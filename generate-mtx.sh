#!/bin/bash

app=./build/PaRMAT
ToMtx=./build/ToMtx

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

mkdir -p tmp

for ((scale=scale_min; scale <= scale_max; scale++)); do
  dir=rmat/g500-${scale}
  rm -rf ${dir}
  mkdir -p ${dir}

  for ((i=0; i<niter; i++)); do
    # shellcheck disable=SC2012
    out=${dir}/$((i + 1)).mtx

    nver=$((2**scale))
    nedges=$((nver*16))
    $app -nVertices ${nver} -nEdges ${nedges} -a 0.57 -b 0.19 -c 0.19 -output out.txt -threads 12 -memUsage 0.75

    $ToMtx ${nver} ${nedges} out.txt ${out}
    rm -rf out.txt
  done
done
