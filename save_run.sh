#!/usr/bin/bash

# bash save_run.sh <name description>
# bash save_run.sh summer
# bash save_run.sh stem

folder="run-$1"

mkdir -p $folder

cp data2.txt $folder/
cp gen_plots.Rout $folder/
cp -r results $folder/
cp -r figs $folder/
