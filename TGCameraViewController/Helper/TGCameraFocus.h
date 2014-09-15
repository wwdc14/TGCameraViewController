//
//  TGCameraFocus.h
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 14/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface TGCameraFocus : NSObject

+ (void)focusWithCaptureSession:(AVCaptureSession *)session touches:(NSSet *)touches inView:(UIView *)view;

@end