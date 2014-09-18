//
//  TGCameraSlideDownView.m
//  TGCameraViewController
//
//  Created by Bruno Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraSlideDownView.h"

@interface TGCameraSlideDownView () <TGCameraSlideViewProtocol>

@end



@implementation TGCameraSlideDownView
 
#pragma mark -
#pragma mark - TGCameraSlideViewProtocol

- (CGFloat)originYInitialShow:(UIView *)view
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)originYEndShow:(UIView *)view
{
    return CGRectGetHeight(view.frame)/2;
}

- (CGFloat)originYInitialHide:(UIView *)view
{
    return CGRectGetHeight(view.frame)/2;
}

- (CGFloat)originYEndHide
{
    return CGRectGetMaxY(self.frame);
}

@end