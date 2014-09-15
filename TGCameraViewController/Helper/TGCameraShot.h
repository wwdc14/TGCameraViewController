//
//  TGCameraShot.h
//  TGCameraViewController
//
//  Created by Bruno Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import Foundation;
#import "TGCamera.h"

@interface TGCameraShot : NSObject

+ (void)takePhotoWithDelegate:(id<TGCameraDelegate>)delegate
             stillImageOutput:(AVCaptureStillImageOutput *)stillImageOutput;

@end
