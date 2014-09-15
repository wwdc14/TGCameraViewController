//
//  TGCameraFocus.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 14/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import AVFoundation;
@import UIKit;
#import "TGCameraFocus.h"

@interface TGCameraFocus ()

+ (CGPoint)pointOfInterestWithTouch:(UITouch *)touch;
+ (void)showFocusViewWithTouch:(UITouch *)touch andDevice:(AVCaptureDevice *)device;

@end



@implementation TGCameraFocus

#pragma mark -
#pragma mark - Public methods

+ (void)focusWithCaptureSession:(AVCaptureSession *)session touches:(NSSet *)touches inView:(UIView *)view
{
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        AVCaptureDevice *device = [session.inputs.lastObject device];
        
        if ([device isFocusPointOfInterestSupported]) {
            UITouch *touch = obj;
            
            if (touch.view == view) {
                [self showFocusViewWithTouch:touch andDevice:device];
                
                [device lockForConfiguration:nil];
                
                device.focusPointOfInterest =
                device.exposurePointOfInterest = [self pointOfInterestWithTouch:touch];
                
                device.focusMode = AVCaptureFocusModeAutoFocus;
                [device isExposureModeSupported:AVCaptureExposureModeAutoExpose];
                device.exposureMode = AVCaptureExposureModeAutoExpose;
                
                [device unlockForConfiguration];
            }
        }
    }];
}

#pragma mark -
#pragma mark - Private methods

+ (CGPoint)pointOfInterestWithTouch:(UITouch *)touch
{
    CGPoint touchPoint = [touch locationInView:touch.view];
    CGSize screenSize = [UIScreen.mainScreen bounds].size;
    
    CGPoint pointOfInterest;
    pointOfInterest.x = touchPoint.x / screenSize.width;
    pointOfInterest.y = touchPoint.y / screenSize.height;
    
    return pointOfInterest;
}

+ (void)showFocusViewWithTouch:(UITouch *)touch andDevice:(AVCaptureDevice *)device
{
    CGPoint touchPoint = [touch locationInView:touch.view];
    
    //
    // create view and subview to focus
    //
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    view.center = subview.center = touchPoint;
    view.layer.borderColor = subview.layer.borderColor = [UIColor orangeColor].CGColor;

    view.layer.borderWidth = 1;
    view.layer.cornerRadius = CGRectGetHeight(view.frame) / 2;
    
    subview.layer.borderWidth = 5;
    subview.layer.cornerRadius = CGRectGetHeight(subview.frame) / 2;
    
    //
    // remove old focus view and focus subview
    // if doesn't exists, ignore
    //
    
    [touch.view.subviews.lastObject removeFromSuperview];
    [touch.view.subviews.lastObject removeFromSuperview];
    
    //
    // add focus view and focus subview to touch viiew
    //
    
    [touch.view addSubview:view];
    [touch.view addSubview:subview];
    
    //
    // remove focus view and focus subview animated
    //
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:.5f];

        while ([device isAdjustingFocus] ||
               [device isAdjustingExposure] ||
               [device isAdjustingWhiteBalance]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            view.transform = subview.transform = CGAffineTransformIdentity;
        
            [UIView animateWithDuration:.25f animations:^{
                view.transform = subview.transform = CGAffineTransformScale(view.transform, .01, .01);
            } completion:^(BOOL finished) {
                if (finished) {
                    [subview removeFromSuperview];
                    [view removeFromSuperview];
                }
            }];
        });
    });
}

@end