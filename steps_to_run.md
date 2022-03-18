# Stappen plan for DL to get it working ###

## Clone our private repo (you will need to log in when doing this, have to set up a private token to do this and use that as a password)

~~~
conda create --name CenterTrack python=3.6
~~~
~~~
conda activate CenterTrack
pip install numpy
~~~
~~~
conda install pytorch torchvision -c pytorch
~~~
~~~
pip install cython; pip install -U 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'
~~~

## Clone our private repo (you will need to log in when doing this, have to set up a private token to do this and use that as a password)
~~~
git clone https://github.com/patrickgeel/Tracking-objects-as-points.git
~~~

## This command stores your credentials so that you do not have to log in every time (https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
~~~
git config --global credential.helper store
~~~


## Running setup steps, this should only be done once. REPLACE PATRICK WITH YOUR OWN NAME 
~~~
cd Tracking-objects-as-points
~~~
~~~
git checkout --track -b patrick remotes/origin/patrick 
~~~
~~~
pip install -r requirements.txt
pip install torchvision==0.5.0
cd src/lib/model/networks
git clone https://github.com/CharlesShang/DCNv2/
cd DCNv2
rm -rf build
./make.sh

~~~
## Setup for the data folder 
~~~
cd ~/Tracking-objects-as-points
mkdir data
cd src/tools
bash get_mot_17.sh
cd ~/Tracking-objects-as-points/data
mv MOT17/train/ . && mv MOT17/test/ . && rm -rf MOT17
cd ~/Tracking-objects-as-points/src/tools
python convert_mot_to_coco.py
python convert_mot_det_to_results.py

~~~
## This part should run the test model for the MOT17_half
~~~
cd ~/Tracking-objects-as-points/src
python test.py tracking --exp_id mot17_half --dataset mot --dataset_version 17halfval --pre_hm --ltrb_amodal --track_thresh 0.4 --pre_thresh 0.5 --load_model ../models/mot17_half.pth

~~~
