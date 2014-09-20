//
//  TGCamera.h
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 14/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import Foundation;
@import AVFoundation;
@import UIKit;



@protocol TGCameraDelegate;



@interface TGCamera : NSObject

- (instancetype) init __attribute__
((unavailable("[-init] is not allowed, use [+cameraWithRootView:andCaptureView]")));

+ (instancetype)new __attribute__
((unavailable("[-init] is not allowed, use [+cameraWithRootView:andCaptureView]")));

+ (instancetype)cameraWithFlashButton:(UIButton *)flashButton;

- (void)startRunning;
- (void)stopRunning;

- (AVCaptureVideoPreviewLayer *)previewLayer;
- (AVCaptureStillImageOutput *)stillImageOutput;

- (void)insertSublayerWithCaptureView:(UIView *)captureView atRootView:(UIView *)rootView;

- (void)disPlayGridView;

- (void)changeFlashModeWithButton:(UIButton *)button;

- (void)focusView:(UIView *)focusView inTouchPoint:(CGPoint)touchPoint;

- (void)takePhotoWithCaptureView:(UIView *)captureView
                  effectiveScale:(NSInteger)effectiveScale
                videoOrientation:(AVCaptureVideoOrientation)videoOrientation
                      completion:(void (^)(UIImage *))completion;

- (void)toogleWithFlashButton:(UIButton *)flashButton;

@end



@protocol TGCameraDelegate <NSObject>

- (void)cameraImage:(UIImage *)image;

@end