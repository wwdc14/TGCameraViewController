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

- (CGFloat)initialOriginY:(UIView *)view
{
    return CGRectGetHeight(view.frame)/2;
}

- (CGFloat)endOriginY
{
    return CGRectGetMaxY(self.frame);
}

@end