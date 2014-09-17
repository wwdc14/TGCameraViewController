//
//  TGCameraShot.h
//  TGCameraViewController
//
//  Created by Bruno Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import Foundation;
@import AVFoundation;
@import UIKit;

@interface TGCameraShot : NSObject

+ (void)takePhotoCaptureView:(UIView *)captureView
            stillImageOutput:(AVCaptureStillImageOutput *)stillImageOutput
              effectiveScale:(NSInteger)effectiveScale
            videoOrientation:(AVCaptureVideoOrientation)videoOrientation
                  completion:(void (^)(UIImage *photo))completion;

@end
