//
//  TGCameraViewController.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 13/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraViewController.h"
#import "TGPhotoViewController.h"
#import "TGCameraSlideView.h"



@interface TGCameraViewController ()

@property (strong, nonatomic) IBOutlet UIView *captureView;
@property (strong, nonatomic) IBOutlet UIButton *toggleButton;
@property (strong, nonatomic) IBOutlet UIButton *flashButton;
@property (strong, nonatomic) IBOutlet TGCameraSlideView *slideUpView;
@property (strong, nonatomic) IBOutlet TGCameraSlideView *slideDownView;

@property (strong, nonatomic) TGCamera *camera;
@property (nonatomic) CGFloat beginPinchGestureScale;
@property (nonatomic) CGFloat effectiveScale;
@property (nonatomic) BOOL wasLoaded;

- (IBAction)closeTapped;
- (IBAction)flashTapped;
- (IBAction)shotTapped:(UIButton *)button;
- (IBAction)toggleTapped;
- (IBAction)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer;
- (IBAction)handleTapGesture:(UITapGestureRecognizer *)recognizer;

- (AVCaptureVideoOrientation)videoOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation;
- (void)zoomWithRecognizer:(UIPinchGestureRecognizer *)recognizer;

@end



@implementation TGCameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _camera = [TGCamera cameraWithFlashButton:_flashButton];
    _captureView.backgroundColor = [UIColor clearColor];
    _effectiveScale = 1.;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChangeNotification)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    [_camera startRunning];
    
    if (_wasLoaded == NO) {
        [_slideUpView hideWithAnimationAtView:_captureView];
        [_slideDownView hideWithAnimationAtView:_captureView];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self deviceOrientationDidChangeNotification];
    
    if (_wasLoaded == NO) {
        _wasLoaded = YES;
        [_camera insertSublayerWithCaptureView:_captureView atRootView:self.view];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_camera stopRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
        _beginPinchGestureScale = _effectiveScale;
    }
    
    return YES;
}

#pragma mark -
#pragma mark - Actions

- (IBAction)closeTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)flashTapped
{
    [_camera changeFlashModeWithButton:_flashButton];
}

- (IBAction)shotTapped:(UIButton *)button
{
    button.enabled = NO;
    
    [_slideUpView showWithAnimationAtView:_captureView];
    [_slideDownView showWithAnimationAtView:_captureView];
    [_slideUpView hideWithAnimationAtView:_captureView];
    [_slideDownView hideWithAnimationAtView:_captureView];
    
    /*
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    AVCaptureVideoOrientation videoOrientation = [self videoOrientationForDeviceOrientation:deviceOrientation];
    
    [_camera takePhotoWithCaptureView:_captureView effectiveScale:_effectiveScale videoOrientation:videoOrientation completion:^(UIImage *photo) {
        TGPhotoViewController *viewController = [TGPhotoViewController newWithDelegate:_delegate photo:photo];
        [self.navigationController pushViewController:viewController animated:YES];
        button.enabled = YES;
    }];
    */
}

- (IBAction)toggleTapped
{
    [_camera toogleWithFlashButton:_flashButton];
}

- (IBAction)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    [self zoomWithRecognizer:recognizer];
}

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    CGPoint touchPoint = [recognizer locationInView:_captureView];
    [_camera focusView:_captureView inTouchPoint:touchPoint];
}

#pragma mark -
#pragma mark - Private methods

- (void)deviceOrientationDidChangeNotification
{
    UIDeviceOrientation orientation = [UIDevice.currentDevice orientation];
    NSInteger degress;
    
    switch (orientation) {
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationUnknown:
            degress = 0;
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            degress = 90;
            break;
            
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationPortraitUpsideDown:
            degress = 180;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            degress = 270;
            break;
    }
    
    CGFloat radians = degress * M_PI / 180;
    CGAffineTransform transform = CGAffineTransformMakeRotation(radians);
    
    [UIView animateWithDuration:.5f animations:^{
        _flashButton.transform =
        _toggleButton.transform = transform;
    }];
}

- (AVCaptureVideoOrientation)videoOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation) deviceOrientation;
    
    switch (deviceOrientation) {
        case UIDeviceOrientationLandscapeLeft:
            result = AVCaptureVideoOrientationLandscapeRight;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            result = AVCaptureVideoOrientationLandscapeLeft;
            break;
            
        default:
            break;
    }
    
    return result;
}

- (void)zoomWithRecognizer:(UIPinchGestureRecognizer *)recognizer
{
    BOOL allTouchesAreOnThePreviewLayer = YES;
    NSInteger numberOfTouches = [recognizer numberOfTouches];
    
    AVCaptureVideoPreviewLayer *previewLayer = [_camera previewLayer];
    
    for (NSInteger i = 0; i < numberOfTouches; i++) {
        CGPoint location = [recognizer locationOfTouch:i inView:_captureView];
        CGPoint convertedLocation = [previewLayer convertPoint:location fromLayer:previewLayer.superlayer];
        
        if ([previewLayer containsPoint:convertedLocation] == NO) {
            allTouchesAreOnThePreviewLayer = NO;
            break;
        }
    }
    
    if (allTouchesAreOnThePreviewLayer) {
        _effectiveScale = _beginPinchGestureScale * [recognizer scale];
        
        if (_effectiveScale < 1.) {
            _effectiveScale = 1.;
        }
        
        AVCaptureStillImageOutput *stillImageOutput = [_camera stillImageOutput];
        CGFloat maxScaleAndCropFactor = [[stillImageOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
        
        if (_effectiveScale > maxScaleAndCropFactor) {
            _effectiveScale = maxScaleAndCropFactor;
        }
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:.025];
        [previewLayer setAffineTransform:CGAffineTransformMakeScale(_effectiveScale, _effectiveScale)];
        [CATransaction commit];
    }
}

@end