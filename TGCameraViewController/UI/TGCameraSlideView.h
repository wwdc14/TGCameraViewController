//
//  TGCameraSlideView.h
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import UIKit;

@protocol TGCameraSlideViewProtocol;



@interface TGCameraSlideView : UIView

- (void)showWithAnimationAtView:(UIView *)view;
- (void)hideWithAnimationAtView:(UIView *)view;

@end



@protocol TGCameraSlideViewProtocol <NSObject>

- (CGFloat)originYInitialShow:(UIView *)view;
- (CGFloat)originYEndShow:(UIView *)view;

- (CGFloat)originYInitialHide:(UIView *)view;
- (CGFloat)originYEndHide;

@end