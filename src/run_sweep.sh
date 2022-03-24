#!/bin/bash 

yes="y"

echo "Enter run name: "  
read exp_id  

echo "Would you like to train a new model? (y/n)"
read train 

if [ "$train" = "$yes" ]
then 
echo "Enter number of epochs: "  
read num_epochs
echo "Enter batch size: "  
read batch_size
echo "Enter lr step: "  
read lr_step

echo "Exp Id: $exp_id"
echo "Epochs: $num_epochs"
echo "Batch size: $batch_size"
echo "Lr Step: $lr_step"

else 
	echo "Exp Id: $exp_id"
fi

#Train the model
if [ "$train" = "$yes" ]
then 
# python main.py tracking --exp_id "$exp_id" --dataset mot --dataset_version 17halftrain --num_epochs "$num_epochs" --batch_size "$batch_size" --lr_step "$lr_step"
python main.py tracking --exp_id "$exp_id" --dataset mot --dataset_version 17halftrain --pre_hm --ltrb_amodal --same_aug --hm_disturb 0.05 --lost_disturb 0.4 --fp_disturb 0.1 --num_epochs "$num_epochs" --batch_size "$batch_size" --lr_step "$lr_step"
fi
# Setup logging
echo "Setup logging directory"

mkdir -p ../data_logging/

# Run test on the trained model
# python test.py tracking --exp_id "$exp_id" --dataset mot --dataset_version 17halfval --track_thresh 0.4 --pre_thresh 0.5 --load_model ../exp//tracking/"$exp_id"/model_last.pth | tee ../data_logging/"$exp_id.txt"
python test.py tracking --exp_id $"exp_id" --dataset mot --dataset_version 17halfval --pre_hm --ltrb_amodal --track_thresh 0.4 --pre_thresh 0.5 --load_model ../exp//tracking/"$exp_id"/model_last.pth| tee ../data_logging/"$exp_id.txt"
# Stop logging

# git add ../data_logging/"$exp_id.txt"
# git commit -m "Run $exp_id is complete"
# git push

sudo poweroff