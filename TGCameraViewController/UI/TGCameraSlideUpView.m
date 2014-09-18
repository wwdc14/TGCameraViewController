//
//  TGCameraSlideUpView.m
//  TGCameraViewController
//
//  Created by Bruno Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraSlideUpView.h"

@interface TGCameraSlideUpView () <TGCameraSlideViewProtocol>

@end



@implementation TGCameraSlideUpView
 
#pragma mark -
#pragma mark - TGCameraSlideViewProtocol

- (void)addSlideToView:(UIView *)view
{
    CGFloat width = CGRectGetWidth(view.frame);
    CGFloat height = CGRectGetHeight(view.frame)/2;
    
    CGFloat originY = -CGRectGetMinY(view.frame)/2;
    originY += CGRectGetMinY(view.frame)/4;
    
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
    frame.origin.y -= CGRectGetHeight(self.frame);
    
    [UIView animateWithDuration:.5f animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end