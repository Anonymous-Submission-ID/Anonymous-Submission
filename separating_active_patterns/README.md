# Separating active patterns along with non-active patterns from videos

## Active pattern mining & Growth transformation

After the preparation of dataset, as below

>After downloading, drag all .zip and .tar.gz files into ./data directory, and run
>
>```
>bash data/preprocess_kth.sh
>```
>
>Then all preprocessed and subsequence splitted frames are obtained in ./data/kth/processed.

For the preprocessed frames in ./data/kth/processed, run the demo 

```
ap_mining_kth.m
```

then all separated patterns which are represented as masks are stored in the same directory as:

——.\data\kth\processed\

——.\data\kth\processed_ap\

——.\data\kth\processed_nap\

## Visualized cases



Datasets contain:

[KTH human action dataset](https://www.csc.kth.se/cvap/actions/) & [BAIR action-free robot pushing dataset](https://sites.google.com/view/sna-visual-mpc/)

For reproducing the experiment, the processed dataset should be downloaded. 

For KTH, raw data and subsequence file should be downloaded firstly. In this turn of review, please temporarily download from:

[raw data](https://mega.nz/folder/JREhlAKB#U26ufSZcVSiw0EOOlW6pMw) and [subsequence file](https://mega.nz/folder/EVMiRJhB#Gboh1r5PmbqGv97db2974w).

After downloading, drag all .zip and .tar.gz files into ./data directory, and run

```
bash data/preprocess_kth.sh
```

Then all preprocessed and subsequence splitted frames are obtained in ./data/kth/processed.

If you only need to inference with released models, please run the code below for converting images into tfrecords for inference

```
bash data/kth2tfrecords.sh 
```

else, please skip this step and turn to Part 3 for separating active patterns along with non-active ones from videos.
