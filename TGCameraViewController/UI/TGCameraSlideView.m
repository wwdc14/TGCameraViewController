//
//  TGCameraSlideView.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraSlideView.h"



@interface TGCameraSlideView () <TGCameraSlideViewProtocol>

- (void)addSlideToView:(UIView *)view withOriginY:(CGFloat)originY;
- (void)removeSlideFromSuperviewWithOriginY:(CGFloat)originY;

@end



@implementation TGCameraSlideView

static NSString* const kExceptionName = @"TGCameraSlideViewException";
static NSString* const kExceptionMessage = @"Invoked abstract method";

#pragma mark -
#pragma mark - Public methods

- (void)showWithAnimationAtView:(UIView *)view
{
    [self addSlideToView:view withOriginY:[self originYInitialShow:view]];
    [self removeSlideFromSuperviewWithOriginY:[self originYEndShow:view]];
}

- (void)hideWithAnimationAtView:(UIView *)view
{
    [self addSlideToView:view withOriginY:[self originYInitialHide:view]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:.6];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeSlideFromSuperviewWithOriginY:[self originYEndHide]];
        });
    });
}

#pragma mark -
#pragma mark - TGCameraSlideViewProtocol

- (CGFloat)originYInitialShow:(UIView *)view
{
    [NSException exceptionWithName:kExceptionName
                            reason:kExceptionMessage
                          userInfo:nil];
    
    return 0.;
}

- (CGFloat)originYEndShow:(UIView *)uiview
{
    [NSException exceptionWithName:kExceptionName
                            reason:kExceptionMessage
                          userInfo:nil];
    
    return 0.;
}

- (CGFloat)originYInitialHide:(UIView *)view
{
    [NSException exceptionWithName:kExceptionName
                            reason:kExceptionMessage
                          userInfo:nil];
    
    return 0.;
}

- (CGFloat)originYEndHide
{
    [NSException exceptionWithName:kExceptionName
                            reason:kExceptionMessage
                          userInfo:nil];
    
    return 0.;
}

#pragma mark -
#pragma mark - Private methods

- (void)addSlideToView:(UIView *)view withOriginY:(CGFloat)originY
{
    CGFloat width = CGRectGetWidth(view.frame);
    CGFloat height = CGRectGetHeight(view.frame)/2;
    
    CGRect frame = self.frame;
    frame.size.width = width;
    frame.size.height = height;
    frame.origin.y = originY;
    self.frame = frame;
    
    [view addSubview:self];
}

- (void)removeSlideFromSuperviewWithOriginY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    
    [UIView animateWithDuration:2. animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end