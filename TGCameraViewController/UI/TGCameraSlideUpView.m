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

- (CGFloat)initialPositionWithView:(UIView *)view
{
    return 0;
}

- (CGFloat)finalPosition
{
    return -CGRectGetHeight(self.frame);
}

@end