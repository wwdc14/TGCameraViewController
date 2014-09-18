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

- (void)hideWithAnimationAtView:(UIView *)view
               withTimeInterval:(CGFloat)timeInterval;

- (void)removeSlideFromSuperview:(BOOL)remove
                    withDuration:(CGFloat)duration
                         originY:(CGFloat)originY;

@end



@implementation TGCameraSlideView

static NSString* const kExceptionName = @"TGCameraSlideViewException";
static NSString* const kExceptionMessage = @"Invoked abstract method";

#pragma mark -
#pragma mark - Public methods

- (void)showWithAnimationAtView:(UIView *)view
{
    [self addSlideToView:view
             withOriginY:[self finalPosition]];
    
    [self removeSlideFromSuperview:NO
                      withDuration:.15f
                           originY:[self initialPositionWithView:view]];
}

- (void)hideWithAnimationAtView:(UIView *)view
{
    [self hideWithAnimationAtView:view
                 withTimeInterval:.6];
}

#pragma mark -
#pragma mark - TGCameraSlideViewProtocol

- (CGFloat)initialPositionWithView:(UIView *)view
{
    [NSException exceptionWithName:kExceptionName
                            reason:kExceptionMessage
                          userInfo:nil];
    
    return 0.;
}

- (CGFloat)finalPosition
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

- (void)hideWithAnimationAtView:(UIView *)view withTimeInterval:(CGFloat)timeInterval
{
    [self addSlideToView:view withOriginY:[self initialPositionWithView:view]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:timeInterval];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeSlideFromSuperview:YES
                              withDuration:.5
                                   originY:[self finalPosition]];
        });
    });
}

- (void)removeSlideFromSuperview:(BOOL)remove withDuration:(CGFloat)duration originY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    
    [UIView animateWithDuration:duration animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            if (remove) {
                [self removeFromSuperview];
            }
        }
    }];
}

@end