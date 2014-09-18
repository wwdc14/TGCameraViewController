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

+ (void)showSlideUpView:(TGCameraSlideView *)slideUpView
          slideDownView:(TGCameraSlideView *)slideDownView
                 atView:(UIView *)view
             completion:(void (^)(void))completion;

+ (void)hideSlideUpView:(TGCameraSlideView *)slideUpView
          slideDownView:(TGCameraSlideView *)slideDownView
                 atView:(UIView *)view
             completion:(void (^)(void))completion;

@end



@protocol TGCameraSlideViewProtocol <NSObject>

- (CGFloat)initialPositionWithView:(UIView *)view;
- (CGFloat)finalPosition;

@end