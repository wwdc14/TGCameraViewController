//
//  TGCamera.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 14/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import AVFoundation;
#import "TGCamera.h"
#import "TGCameraFlash.h"
#import "TGCameraFocus.h"
#import "TGCameraShot.h"
#import "TGCameraToggle.h"



@interface TGCamera ()

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;

+ (instancetype)newCamera;

- (void)setupWithRootView:(UIView *)rootView
              captureView:(UIView *)captureView
              flashButton:(UIButton *)flashButton;

@end



@implementation TGCamera

+ (instancetype)cameraWithRootView:(UIView *)rootView captureView:(UIView *)captureView flashButton:(UIButton *)flashButton
{
    TGCamera *camera = [TGCamera newCamera];
    [camera setupWithRootView:rootView captureView:captureView flashButton:flashButton];
    
    return camera;
}

#pragma mark -
#pragma mark - Public methods

- (void)startRunning
{
    [_session startRunning];
}

- (void)stopRunning
{
    [_session stopRunning];
}

- (void)changeFlashModeWithButton:(UIButton *)button
{
    [TGCameraFlash changeModeWithCaptureSession:_session andButton:button];
}

- (void)focusTouches:(NSSet *)touches inView:(UIView *)view
{
    [TGCameraFocus focusWithCaptureSession:_session touches:touches inView:view];
}

- (void)takePhotoWithCaptureView:(UIView *)captureView completion:(void (^)(UIImage *))completion
{
    [TGCameraShot takePhotoCaptureView:captureView stillImageOutput:_stillImageOutput completion:^(UIImage *photo) {
        completion(photo);
    }];
}

- (void)toogleWithFlashButton:(UIButton *)flashButton
{
    [TGCameraToggle toogleWithCaptureSession:_session];
    [TGCameraFlash flashModeWithCaptureSession:_session andButton:flashButton];
}

#pragma mark -
#pragma mark - Private methods

+ (instancetype)newCamera
{
    return [super new];
}

- (void)setupWithRootView:(UIView *)rootView captureView:(UIView *)captureView flashButton:(UIButton *)flashButton
{
    //
    // create session
    //
    
    _session = [AVCaptureSession new];
    _session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    //
    // add input to session
    //
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    [_session addInput:deviceInput];
    
    //
    // insert sublayer for camera preview
    //
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    CALayer *rootLayer = [rootView layer];
    rootLayer.masksToBounds = YES;
    
    CGRect frame = captureView.frame;
    previewLayer.frame = frame;
    
    [rootLayer insertSublayer:previewLayer atIndex:0];
    
    //
    // add output to session
    //
    
    NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    
    _stillImageOutput = [AVCaptureStillImageOutput new];
    _stillImageOutput.outputSettings = outputSettings;
    
    [_session addOutput:_stillImageOutput];
    
    //
    // setup flash button
    //
    
    [TGCameraFlash flashModeWithCaptureSession:_session andButton:flashButton];
}

@end