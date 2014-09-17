//
//  TGCameraZoom.h
//  TGCameraViewController
//
//  Created by Bruno Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import Foundation;
@import AVFoundation;

@interface TGCameraZoom : NSObject

+ (NSInteger)zoomWithCaptureView:(UIView *)captureView
               previewLayer:(AVCaptureVideoPreviewLayer *)previewLayer
           stillImageOutput:(AVCaptureStillImageOutput *)stillImageOutput
             effectiveScale:(NSInteger)effectiveScale
          beginGestureScale:(NSInteger)beginGestureScale
                 recognizer:(UIPinchGestureRecognizer *)recognizer
                 completion:(void (^)(NSInteger scale))completion;

@end