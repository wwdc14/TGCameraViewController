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

- (CGFloat)originYInitialShow:(UIView *)view
{
    return -CGRectGetHeight(self.frame);
}

- (CGFloat)originYEndShow:(UIView *)view
{
    return 0;
}

- (CGFloat)originYInitialHide:(UIView *)view
{
    return 0;
}

- (CGFloat)originYEndHide
{
    return -CGRectGetHeight(self.frame);
}

@end