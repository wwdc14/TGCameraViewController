//
//  TGCameraShot.m
//  TGCameraViewController
//
//  Created by Bruno Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraShot.h"

@implementation TGCameraShot

+ (void)takePhotoCaptureView:(UIView *)captureView stillImageOutput:(AVCaptureStillImageOutput *)stillImageOutput effectiveScale:(NSInteger)effectiveScale completion:(void (^)(UIImage *))completion
{
    [self showAnimationWithCaptureView:captureView];
    
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
    
    [videoConnection setVideoScaleAndCropFactor:effectiveScale];
    
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
    completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            completion(image);
        }
    }];
}

+ (void)showAnimationWithCaptureView:(UIView *)captureView
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(captureView.frame), CGRectGetHeight(captureView.frame));
   
    UIView *animatedView = [[UIView alloc] initWithFrame:frame];
    animatedView.alpha = 0;
    animatedView.backgroundColor = [UIColor whiteColor];
    
    [captureView addSubview:animatedView];
    
    [UIView animateWithDuration:.1f animations:^{
        animatedView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:.06f animations:^{
                animatedView.alpha = 0;
            } completion:^(BOOL finished) {
                [animatedView removeFromSuperview];
            }];
        }
    }];
}

@end
