//
//  TGAssetImageFile.m
//  TGCameraViewController
//
//  Created by Bruno Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGAssetImageFile.h"

@implementation TGAssetImageFile

- (instancetype)initWithPath:(NSString *)path image:(UIImage *)image
{
    self = [self init];
    
    if (self) {
        self.path = path;
        self.image = image;
    }
    
    return self;
}

@end