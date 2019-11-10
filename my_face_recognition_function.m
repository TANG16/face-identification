function [identityId] = my_face_recognition_function(image, faceRecoguntionModel)
% This function is core function to call image detection, image
% preprocessing, feature extraction, dimensionality reduction and
% thresholding prediction result.

% Detect face in the image with our detector model.
bbox = MyFaceDetectionFunction(faceRecoguntionModel.faceDetector, image);

% Check if face detected, otherwise return -1.
if ~isempty(bbox) == 1
    
    % Process images: crop, grayscale, resize, histogram equalization,
    % filtering
    processedImage = processImageGrayscale(image, bbox, ...
        faceRecoguntionModel.imageSize);
    
    % 2. Feature extraction
    dataProjected = extractFeature(processedImage, ...
        faceRecoguntionModel.cellSize, faceRecoguntionModel.pcaCoeff);
    
    % 3. Predict by the model
    [label, ~, ~,Posterior] = predict(faceRecoguntionModel.classifier, dataProjected);
    
    % 4. Thresholding
    % fprintf('Max confidence: %.4f\n', max(Posterior));
    if max(Posterior) < 0.15
        identityId = -1;
    else
        identityId = str2num(string(label));
    end
    
else
    % Face is not detected.
    identityId = -1;
end

end

