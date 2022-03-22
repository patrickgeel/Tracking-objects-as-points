#!/bin/bash 

#Train the model
#python main.py tracking --exp_id "$1" --dataset mot --dataset_version 17halftrain --num_epochs "$2" --batch_size "$3" --lr_step "$4"
# Setup logging
mkdir -p ../data_logging/
script ../data_logging/"$1.txt"
# Run test on the trained model 
python test.py tracking --exp_id "$1" --dataset mot --dataset_version 17halfval --track_thresh 0.4 --pre_thresh 0.5 --load_model ../exp//tracking/"$1"/model_last.pth
# Stop logging
exit

git add ../data_logging/"$1.txt"
git commit -m "Run $1 is complete"
git push 
