//
//  TGCameraAuthorizationViewController.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 20/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraAuthorizationViewController.h"

@interface TGCameraAuthorizationViewController ()

- (IBAction)closeTapped;

@end



@implementation TGCameraAuthorizationViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -
#pragma mark - Actions

- (IBAction)closeTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end