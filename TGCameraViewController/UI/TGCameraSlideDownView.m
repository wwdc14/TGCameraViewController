//
//  TGCameraSlideDownView.m
//  TGCameraViewController
//
//  Created by Bruno Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraSlideDownView.h"

@interface TGCameraSlideDownView ()

- (void)addToView:(UIView *)view;
- (void)removeFromSuperviewAnimated;

@end



@implementation TGCameraSlideDownView

#pragma mark -
#pragma mark - Public methods

- (void)showWithAnimationAtView:(UIView *)view;
{
    [self addToView:view];
    [self performSelector:@selector(removeFromSuperviewAnimated) withObject:nil afterDelay:.6];
}

#pragma mark -
#pragma mark - Private methods

- (void)addToView:(UIView *)view
{
    CGFloat width = CGRectGetWidth(view.frame);
    CGFloat height = CGRectGetHeight(view.frame)/2;
    
    CGFloat originY = CGRectGetMaxY(view.frame);
    originY -= CGRectGetHeight(self.frame) + CGRectGetMinY(view.frame);
    originY -= CGRectGetMinY(view.frame)/4;
    
    CGRect frame = self.frame;
    frame.size.width = width;
    frame.size.height = height;
    frame.origin.y = originY;
    self.frame = frame;
    
    [view addSubview:self];
}

- (void)removeFromSuperviewAnimated
{
    CGRect frame = self.frame;
    frame.origin.y = CGRectGetMaxY(self.frame);
    
    [UIView animateWithDuration:.5f animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end