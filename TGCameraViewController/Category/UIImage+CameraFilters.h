//
//  UIImage+CameraFilters.h
//  TGCameraViewController
//
//  Created by Bruno Furtado on 16/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import UIKit;

@interface UIImage (CameraFilters)

- (UIImage *)curveFilter;
- (UIImage *)saturateImage:(CGFloat)saturation withContrast:(CGFloat)contrast;
- (UIImage *)vignetteWithRadius:(CGFloat)radius intensity:(CGFloat)intensity;

@end