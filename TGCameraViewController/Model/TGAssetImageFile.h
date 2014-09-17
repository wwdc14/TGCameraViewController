//
//  TGAssetImageFile.h
//  TGCameraViewController
//
//  Created by Bruno Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface TGAssetImageFile : NSObject

@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *title;

- (instancetype)initWithPath:(NSString *)path image:(UIImage *)image;

@end