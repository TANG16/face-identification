function [trainingImages, trainingLabels] = getGrayscaleTrainingData(matFilePath, imgPathDir, imgSizes)



% Load challenge Training data
% load("/Volumes/Work/UPF/Class_FACIAL/FaceAndGesture-Lab4/AGC2019_Challenge3_Materials/AGC19_Challenge3_Training.mat")
load(matFilePath);
% Provide the path to the input images, for example
% 'C:\AGC_Challenge_2019\images\'
%imgPath = "/Volumes/Work/UPF/Class_FACIAL/FaceAndGesture-Lab4/AGC2019_Challenge3_Materials/TRAINING/";
imgPath = imgPathDir;


trainingImages = [];
trainingLabels = zeros(length( AGC19_Challenge3_TRAINING ), 1);
trainingLabelsArray =  [];
boxesSize = [];

% Define new size of image here.
meanImageWidth = imgSizes(1);
meanImageHeight = imgSizes(2);

% meanImgWidth = 240 %240.9694;
% meanImgHeight = 231%231.3629;

% Process all images in the Training set
for j = 1 :length( AGC19_Challenge3_TRAINING )
    A = imread( sprintf('%s%s',...
        imgPath, AGC19_Challenge3_TRAINING(j).imageName ));
    
    fprintf("processing image at = %0.0f\n", j);
    
    
    bboxes = AGC19_Challenge3_TRAINING(j).faceBox;
    % Get number of detected face
    nFaces = size(bboxes, 1);
    
    % Get label ID from training set
    label_id = AGC19_Challenge3_TRAINING(j).id;
    
    if nFaces > 0
        
        for f = 1:nFaces
            % Process box size from [x1 y1 x2 y2] to [x y width height]
            bboxes(f, 3) = bboxes(f, 3) - bboxes(f, 1);
            bboxes(f, 4) = bboxes(f, 4) - bboxes(f, 2);

            if nFaces == 1
                % if there is only one face detected
                % add face image to training image and add label to
                % trainning label
                % pass image to be processed in processImage function
                processedImage = processImageGrayscale(A, bboxes(f, :), ...
                    meanImageWidth, meanImageHeight) ;
                trainingImages(j,:,:) = processedImage;
                trainingLabels(j,:) = label_id;
                
                % boxesSize is for calculating the mean of width and height
                % of the image for resizing
                boxesSize = [boxesSize; bboxes];
            elseif nFaces > 1
                fprintf("2 face found in image name: %s\n", AGC19_Challenge3_TRAINING(j).imageName);
                % If number of face is more than 1,
                % as from assignment we have to label the biggest one as the
                % id.
                
                % Find the biggest box's size and set label
                % from rectangle area width x height
                % which is at the index 3, 4 of bbox respectively
                
                tempBoxArea = 0; % for keeping the largest box
                biggestImage = 0; % for keeping the index of largest box
                % Loop through all detected box
                for nImg = 1: nFaces
                    % Calculate area of square
                    area = bboxes(nImg, 3)* bboxes(nImg, 4);
                    if area > tempBoxArea
                        biggestImage = nImg;
                        tempBoxArea = area;
                    end
                end
                
                % Label the biggest image with ID
                processedImage = processImageGrayscale(A, bboxes(biggestImage, :) ...
                    , meanImageWidth, meanImageHeight) ;
                trainingImages(j,:,:) = processedImage;
                trainingLabels(j,:) = label_id;
                boxesSize = [boxesSize; bboxes(biggestImage, :)];
            end
        end
    else
        % No face detected in image
        processedImage = processImageGrayscale(A, [0 0 size(A,1) size(A,2)], ...
            meanImageWidth, meanImageHeight) ;
        trainingImages(j,:,:) = processedImage;
        trainingLabels(j,:) = label_id;
    end
    
    
end

fprintf("size of images in array:%0.0f\n", size(trainingImages,1));
fprintf("size of label in array:%0.0f\n", size(trainingLabels,1));

end