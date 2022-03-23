#!/bin/bash
mkdir -p ../data_logging/
python test.py tracking --exp_id mot17_half --dataset mot --dataset_version 17halfval --pre_hm --ltrb_amodal --track_thresh 0.4 --pre_thresh 0.5 --load_model ../models/mot17_half.pth | tee ../data_logging/mot17_half.txt

git add ../data_logging/mot17_half.txt
git commit -m "Run mot17_half is complete"
git push
sudo shutdown
