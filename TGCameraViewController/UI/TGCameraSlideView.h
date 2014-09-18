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

@end



@protocol TGCameraSlideViewProtocol <NSObject>

- (void)addSlideToView:(UIView *)view;
- (void)removeSlideFromSuperview;

@end