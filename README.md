# Anonymous submission ID-137

This is the implementation of 'Active Patterns Perceived for Stochastic Video Prediction' by the anonymous submission in ACMMM 2022: ID-137.

## 1. Important updates

(1) 2022-04-01: This project is going to be released, please waiting.

(2) 2022-04-03: The procedure of data preparation and proprecessing scripts on KTH are uploaded for inference.

...

## 2. Getting started

The requirements of the hardware and software are given as below.

### 2.1. Prerequisites

> CPU: Intel(R) Core(TM) i7-6900K CPU @ 3.20GHz
>
> GPU: GeForce GTX 1080 Ti
> 
> CUDA Version: 10.2
> 
> OS: Ubuntu 16.04.6 LTS

### 2.2. Installing

Configure the virtual environment on Ubuntu.

(1) Create a virtual with python 3.6

```
conda create -n asvp python=3.6
conda activate asvp
```

(2) Install requirements (Please pay attention that we use tensorflow-gpu==1.10.0)

```
pip install -r requirements.txt
```

(3) Additionally install ffmpeg

```
conda install x264 ffmpeg -c conda-forge
```

Here the virtual env is created on Ubuntu.

### 2.3. Dataset

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

## 3. Active pattern mining

Active pattern mining is necessary only for training and there is no need to do this if only with respective to inference with released model.

When trying to separate active patterns along with non-active ones from videos, please refer to 

```
Give the example
```

## 4. Inference with released models

Explain how to run the automated tests

### 4.1. Inference on KTH human action

Explain what these tests test and why

```
Give an example
```

### 4.2. Inference on BAIR action-free robot pushing

Explain what these tests test and why

```
Give an example
```

## 5. Performance

Add additional notes about how to deploy this on a live system

## 6. More cases

Add additional notes about how to deploy this on a live system

## 7. Training

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## 8. License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments



