//
//  TGCameraSlideView.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraSlideView.h"



@interface TGCameraSlideView () <TGCameraSlideViewProtocol>

@end



@implementation TGCameraSlideView

static NSString* const kExceptionName = @"TGCameraSlideViewException";
static NSString* const kExceptionMessage = @"Invoked abstract method";

#pragma mark -
#pragma mark - Public methods

- (void)showWithAnimationAtView:(UIView *)view
{
    [self addSlideToView:view];
    [self performSelector:@selector(removeSlideFromSuperview) withObject:nil afterDelay:.6];
}

#pragma mark -
#pragma mark - TGCameraSlideViewProtocol

- (void)addSlideToView:(UIView *)view
{
    [NSException exceptionWithName:kExceptionName
                            reason:kExceptionMessage
                          userInfo:nil];
}

- (void)removeSlideFromSuperview
{
    [NSException exceptionWithName:kExceptionName
                            reason:kExceptionMessage
                          userInfo:nil];
}

@end