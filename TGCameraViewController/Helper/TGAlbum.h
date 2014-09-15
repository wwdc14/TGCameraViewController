//
//  TGAlbum.h
//  TGCameraViewController
//
//  Created by Bruno Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface TGAlbum : NSObject

+ (BOOL)isAvailable;

+ (UIImage *)imageWithMediaInfo:(NSDictionary *)info;
+ (UIImagePickerController *)imagePickerControllerWithDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate;

@end