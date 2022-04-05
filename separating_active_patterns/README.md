# Separating active patterns along with non-active patterns from videos

## Active pattern mining & Growth transformation

* After the preparation of dataset, as below

>After downloading, drag all .zip and .tar.gz files into ./data directory, and run
>
>```
>bash data/preprocess_kth.sh
>```
>
>Then all preprocessed and subsequence splitted frames are obtained in ./data/kth/processed.

* For the preprocessed frames in ./data/kth/processed, run the demo 

```
ap_mining_kth.m
```

then all separated patterns which are represented as masks are stored in the same directory as:

>——.\data\kth\processed\
>
>——.\data\kth\processed_ap\
>
>——.\data\kth\processed_nap\

## Visualized cases

![image](https://github.com/Anonymous-Submission-ID/Anonymous-Submission/blob/main/separating_active_patterns/figs/Figure%201.png)
