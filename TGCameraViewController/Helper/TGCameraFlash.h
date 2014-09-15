//
//  TGCameraFlash.h
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 14/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import Foundation;
@import AVFoundation;
@import UIKit;

@interface TGCameraFlash : NSObject

+ (void)changeModeWithCaptureSession:(AVCaptureSession *)session andButton:(UIButton *)button;
+ (void)flashModeWithCaptureSession:(AVCaptureSession *)session andButton:(UIButton *)button;

@end