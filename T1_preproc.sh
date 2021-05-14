#!/bin/bash


clev


### For loop that will crop, run bias field correction, and resample T1 data.

for i in UCSD*; do

cd ~/cleveland/${i}/t1

#Crop

c3d \
UCSD*.nii \
-trim 20vox \
-o ${i}_cropped.nii.gz


# N4 BIAS FIELD CORRECTION


N4BiasFieldCorrection \
-v -d 3 \
-i  ${i}_cropped.nii.gz \
-o ${i}_n4.nii.gz \
-s 4 -b [200] -c [50x50x50x50,0.000001]


# RESAMPLE


c3d \
${i}_n4.nii.gz \
-resample-mm 1x1x1mm \
-o ${i}_T1w.nii.gz


#Clean up Directory


rm ${i}_cropped.nii.gz
rm ${i}_n4.nii.gz

done