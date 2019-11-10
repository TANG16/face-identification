function [processedImg] = processImageGrayscale(img, bbox, imageSize)
%This function will resize and make grayscale image of providing image 


% if input image is not grayscale, convert to grayscale
if ~isempty(bbox) == 1
    %imshow(img);
    img = imcrop(img, bbox);
    %imshow(img);
end

if ~isempty(imageSize) == 1
    img = imresize(img, imageSize);
    %imshow(img);
end

if size(img,3)==3
    % it's RBG, we need to change to grayscale.
    img = rgb2gray(img);
    %imshow(img);
end

processedImg = adapthisteq(img);
%imshow(processedImg);

processedImg = medfilt2(processedImg);
%imshow(processedImg);

end

