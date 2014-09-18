//
//  TGCameraSlideView.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraSlideView.h"



@interface TGCameraSlideView () <TGCameraSlideViewProtocol>

- (void)addSlideToView:(UIView *)view;
- (void)removeSlideFromSuperview;;

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

- (CGFloat)initialOriginY:(UIView *)view
{
    [NSException exceptionWithName:kExceptionName
                            reason:kExceptionMessage
                          userInfo:nil];
    
    return 0.;
}

- (CGFloat)endOriginY
{
    [NSException exceptionWithName:kExceptionName
                            reason:kExceptionMessage
                          userInfo:nil];
    
    return 0.;
}

#pragma mark -
#pragma mark - Private methods

- (void)addSlideToView:(UIView *)view
{
    CGFloat width = CGRectGetWidth(view.frame);
    CGFloat height = CGRectGetHeight(view.frame)/2;
    CGFloat originY = [self initialOriginY:view];
    
    CGRect frame = self.frame;
    frame.size.width = width;
    frame.size.height = height;
    frame.origin.y = originY;
    self.frame = frame;
    
    [view addSubview:self];
}

- (void)removeSlideFromSuperview
{
    CGRect frame = self.frame;
    frame.origin.y = [self endOriginY];
    
    [UIView animateWithDuration:.5f animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end