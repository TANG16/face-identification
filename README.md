## Face Identification
Face identification is the application to identify person through their images which could come in different styles.
The system firstly detects face on photo by using HaarCascade then the biggest bounding box is a condition to pass to next step which is face identification.


## Face Detection
Face Detector Model is built for detecting faces on photo. The input photos may not be only human's photo. Therefore, human's face detection needs to be implemented. In this step, HaarCascade algorithm for frontal face is used.

Parameter setting: 
To bring the best result of face detection, parameter tuning is done by at MergeThreshold and MinSize throught setGlobaDetector function. See 'MyFaceDetectionFunction.m'

## Image Preprocessing
Images were processed by croping only faces, changing color images to grayscale.

## Augmentation
To increase number of dataset and for more possibility from different angle of face on photos. The image was augmented by X and Y Translation, Rotation, Zooming in and Out.

## Feature Extraction
There were many experiments for the combinations of Feature Selection and Classifier. Finally, HOG is used for feature extraction and SVM is used for classification to identify face.

helperExtract... files are for extracting specific feature from imageDataStore object and return extracted features and labels.
Please note that in HOG, the smaller cell size is, the longer time will take for training in fitcecoc.

TestFeatureExtraction.... files are for testing extracted feature and combined with classification models.

## Classification
Classification model is built by using SVM (fitcecoc in Matlab for multi-classes classification)

