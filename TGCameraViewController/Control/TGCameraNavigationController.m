//
//  TGCameraNavigationController.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 20/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import AVFoundation;
#import "TGCameraAuthorizationViewController.h"
#import "TGCameraNavigationController.h"
#import "TGCameraViewController.h"

@interface TGCameraNavigationController ()

- (void)setupAuthorizedWithDelegate:(id<TGCameraDelegate>)delegate;
- (void)setupDenied;
- (void)setupNotDeterminedWithDelegate:(id<TGCameraDelegate>)delegate;

@end



@implementation TGCameraNavigationController

+ (instancetype)newWithCameraDelegate:(id<TGCameraDelegate>)delegate
{
    TGCameraNavigationController *navigationController = [super new];
    navigationController.navigationBarHidden = YES;
    
    if (navigationController) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

        switch (status) {
            case AVAuthorizationStatusAuthorized:
                [navigationController setupAuthorizedWithDelegate:delegate];
                break;
                
            case AVAuthorizationStatusRestricted:
            case AVAuthorizationStatusDenied:
                [navigationController setupDenied];
                break;
                
            case AVAuthorizationStatusNotDetermined:
                [navigationController setupNotDeterminedWithDelegate:delegate];
                break;
        }
    }
    
    return navigationController;
}

#pragma mark -
#pragma mark - Private methods

- (void)setupAuthorizedWithDelegate:(id<TGCameraDelegate>)delegate
{
    TGCameraViewController *viewController = [TGCameraViewController new];
    viewController.delegate = delegate;
    
    self.viewControllers = @[viewController];
}

- (void)setupDenied
{
    UIViewController *viewController = [TGCameraAuthorizationViewController new];
    self.viewControllers = @[viewController];
}

- (void)setupNotDeterminedWithDelegate:(id<TGCameraDelegate>)delegate
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (granted) {
            [self setupAuthorizedWithDelegate:delegate];
        } else {
            [self setupDenied];
        }
    }];
}

@end