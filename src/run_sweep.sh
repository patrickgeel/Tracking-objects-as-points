#!/bin/bash 

#Train the model
python main.py tracking --exp_id "$1" --dataset mot --dataset_version 17halftrain --num_epochs "$2" --batch_size "$3" --lr_step "$4"
# Run test on the trained model 
python test.py tracking --exp_id "$1" --dataset mot --dataset_version 17halfval --pre_hm --ltrb_amodal --track_thresh 0.4 --pre_thresh 0.5 --load_model ../exp//tracking/"$1"/model_last.pth
