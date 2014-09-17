//
//  TGCameraZoom.m
//  TGCameraViewController
//
//  Created by Bruno Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import UIKit;
#import "TGCameraZoom.h"

@implementation TGCameraZoom

+ (NSInteger)zoomWithCaptureView:(UIView *)captureView previewLayer:(AVCaptureVideoPreviewLayer *)previewLayer stillImageOutput:(AVCaptureStillImageOutput *)stillImageOutput effectiveScale:(NSInteger)effectiveScale beginGestureScale:(NSInteger)beginGestureScale recognizer:(UIPinchGestureRecognizer *)recognizer completion:(void (^)(NSInteger))completion;
{
    NSInteger scale = effectiveScale;
    
    BOOL allTouchesAreOnThePreviewLayer = YES;
    NSInteger numberOfTouches = [recognizer numberOfTouches];
    
    for (NSInteger i = 0; i < numberOfTouches; i++) {
        CGPoint location = [recognizer locationOfTouch:i inView:captureView];
        CGPoint convertedLocation = [previewLayer convertPoint:location fromLayer:previewLayer.superlayer];
        
        if ([previewLayer containsPoint:convertedLocation] == NO) {
            allTouchesAreOnThePreviewLayer = NO;
            break;
        }
    }
    
    if (allTouchesAreOnThePreviewLayer) {
        scale = beginGestureScale * [recognizer scale];
        
        if (scale < 1.) {
            scale = 1.;
        }
        
        CGFloat maxScaleAndCropFactor = [[stillImageOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
        
        if (scale > maxScaleAndCropFactor) {
            scale = maxScaleAndCropFactor;
        }
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:.025];
        [previewLayer setAffineTransform:CGAffineTransformMakeScale(effectiveScale, effectiveScale)];
        [CATransaction commit];
    }
        
    return scale;
}

@end