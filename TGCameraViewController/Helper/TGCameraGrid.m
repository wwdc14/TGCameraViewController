//
//  TGCameraGrid.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 19/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraGrid.h"

@implementation TGCameraGrid

+ (void)disPlayGridView:(TGCameraGridView *)gridView
{
    NSInteger newAlpha = ([gridView alpha] == 0.) ? 1. : 0.;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        gridView.alpha = newAlpha;
    } completion:NULL];
}

@end