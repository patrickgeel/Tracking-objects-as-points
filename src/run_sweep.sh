#!/bin/bash 

# echo "Enter run name: "  
# read exp_id  
# echo "Enter number of epochs: "  
# read num_epochs
# echo "Enter batch size: "  
# read batch_size
# echo "Enter lr step: "  
# read lr_step

# echo "Exp Id: $exp_id"
# echo "Epochs: $num_epochs"
# echo "Batch size: $batch_size"
# echo "Lr Step: $lr_step"

#Train the model
python main.py tracking --exp_id "$exp_id" --dataset mot --dataset_version 17halftrain --num_epochs "$num_epochs" --batch_size "$batch_size" --lr_step "$lr_step"

# Setup logging
echo "Setup logging directory"

mkdir -p ../data_logging/
script ../data_logging/"$exp_id.txt"
echo "Logging directory is ../data_logging/$exp_id.txt"

# Run test on the trained model
python test.py tracking --exp_id "$exp_id" --dataset mot --dataset_version 17halfval --track_thresh 0.4 --pre_thresh 0.5 --load_model ../exp//tracking/"$exp_id"/model_last.pth
# Stop logging
exit

# git add ../data_logging/"$exp_id.txt"
# git commit -m "Run $exp_id is complete"
# git push
