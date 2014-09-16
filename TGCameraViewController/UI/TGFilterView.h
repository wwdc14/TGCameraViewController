//
//  TGFilterView.h
//  TGCameraViewController
//
//  Created by Bruno Furtado on 16/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGFilterView : UIView

- (void)addToView:(UIView *)view aboveView:(UIView *)aboveView;
- (void)removeFromSuperviewAnimated;

@end