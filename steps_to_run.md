### Stappen plan for DL to get it working ###

# Clone our private repo (you will need to log in when doing this, have to set up a private token to do this and use that as a password)

git clone https://github.com/patrickgeel/Tracking-objects-as-points.git

# This command stores your credentials so that you do not have to log in every time
git config --global credential.helper store


# Running setup steps, this should only be done once. REPLACE PATRICK WITH YOUR OWN NAME 

cd Tracking-objects-as-points

conda activate CenterTrack

git checkout --track -b patrick remotes/origin/patrick 

cd src/lib/model/networks

git clone https://github.com/CharlesShang/DCNv2/

cd DCNv2

rm -rf build

./make.sh

cd ~/Tracking-objects-as-points

# Setup for the data folder 

mkdir data

cd src/tools

bash get_mot_17.sh

cd ~/Tracking-objects-as-points/data


cd ~/Tracking-objects-as-points/src

python test.py tracking --exp_id mot17_half --dataset mot --dataset_version 17halfval --pre_hm --ltrb_amodal --track_thresh 0.4 --pre_thresh 0.5 --load_model ../models/mot17_half.pth
