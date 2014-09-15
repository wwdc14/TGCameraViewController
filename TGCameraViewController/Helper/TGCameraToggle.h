//
//  TGCameraToggle.h
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 14/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import Foundation;
@import AVFoundation;

@interface TGCameraToggle : NSObject

+ (void)toogleWithCaptureSession:(AVCaptureSession *)session;

@end