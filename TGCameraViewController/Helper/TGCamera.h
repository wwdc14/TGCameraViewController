//
//  TGCamera.h
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 14/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import Foundation;
@import UIKit;



@protocol TGCameraDelegate;



@interface TGCamera : NSObject

- (instancetype) init __attribute__
((unavailable("[-init] is not allowed, use [+cameraWithRootView:andCaptureView]")));

+ (instancetype)new __attribute__
((unavailable("[-init] is not allowed, use [+cameraWithRootView:andCaptureView]")));

+ (instancetype)cameraWithDelegate:(id<TGCameraDelegate>)delegate
                          rootView:(UIView *)rootView
                       captureView:(UIView *)captureView
                       flashButton:(UIButton *)flashButton;

- (void)startRunning;
- (void)stopRunning;

- (void)changeFlashModeWithButton:(UIButton *)button;

- (void)focusTouches:(NSSet *)touches inView:(UIView *)view;

- (void)takePhotoWithCaptureView:(UIView *)captureView;

- (void)toogleWithFlashButton:(UIButton *)flashButton;

@end



@protocol TGCameraDelegate <NSObject>

- (void)cameraImage:(UIImage *)image;

@end