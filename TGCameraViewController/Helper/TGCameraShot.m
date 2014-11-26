//
//  TGCameraShot.m
//  TGCameraViewController
//
//  Created by Bruno Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

@import AssetsLibrary;
#import "TGCameraShot.h"

@interface TGCameraShot ()

+ (UIImage *)cropImage:(UIImage *)image withCropSize:(CGSize)cropSize;

@end



@implementation TGCameraShot

+ (void)takePhotoCaptureView:(UIView *)captureView stillImageOutput:(AVCaptureStillImageOutput *)stillImageOutput effectiveScale:(NSInteger)effectiveScale videoOrientation:(AVCaptureVideoOrientation)videoOrientation cropSize:(CGSize)cropSize completion:(void (^)(UIImage *))completion
{    
    AVCaptureConnection *videoConnection = nil;
    
    for (AVCaptureConnection *connection in [stillImageOutput connections]) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        
        if (videoConnection) {
            break;
        }
    }
    
    [videoConnection setVideoOrientation:videoOrientation];
    [videoConnection setVideoScaleAndCropFactor:effectiveScale];
    
    __weak __typeof(self)weakSelf = self;
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
    completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            UIImage *croppedImage = [weakSelf cropImage:image withCropSize:cropSize];
            completion(croppedImage);
        }
    }];
}

#pragma mark -
#pragma mark - Private methods

+ (UIImage *)cropImage:(UIImage *)image withCropSize:(CGSize)cropSize
{
    CGFloat scaleFactor = image.size.width / cropSize.width;
    
    CGFloat centerX = image.size.width / 2;
    CGFloat centerY = image.size.height / 2;
    
    CGFloat cropX = centerX - ((cropSize.width / 2) * scaleFactor);
    CGFloat cropY = centerY - ((cropSize.height / 2) * scaleFactor);
    
    CGRect cropRect = CGRectMake(cropX, cropY, (cropSize.width * scaleFactor), (cropSize.height * scaleFactor));
    
    CGAffineTransform rectTransform;
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(M_PI_2), 0, -image.size.height);
            break;
            
        case UIImageOrientationRight:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI_2), -image.size.width, 0);
            break;
            
        case UIImageOrientationDown:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI), -image.size.width, -image.size.height);
            break;
            
        default:
            rectTransform = CGAffineTransformIdentity;
            break;
    }
    rectTransform = CGAffineTransformScale(rectTransform, image.scale, image.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectApplyAffineTransform(cropRect, rectTransform));
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    
    CGRect scaledImgRect = CGRectMake(0, 0, (cropSize.width * 2), (cropSize.height * 2));
    UIGraphicsBeginImageContextWithOptions(scaledImgRect.size, NO, [UIScreen mainScreen].scale);
    
    [result drawInRect:scaledImgRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
