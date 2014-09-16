//
//  TGPhotoViewController.h
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import UIKit;
#import "TGCamera.h"

@interface TGPhotoViewController : UIViewController

- (instancetype) init __attribute__
((unavailable("[-init] is not allowed, use [-initWithDelegate:photo:]")));

+ (instancetype)new __attribute__
((unavailable("[-init] is not allowed, use [-initWithDelegate:photo:]")));

+ (instancetype)newWithDelegate:(id<TGCameraDelegate>)delegate photo:(UIImage *)photo;

@end