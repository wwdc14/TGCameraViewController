//
//  TGCameraColor.m
//  TGCameraViewController
//
//  Created by Bruno Furtado on 16/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGCameraColor.h"

@interface TGCameraColor()

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end



@implementation TGCameraColor

+ (UIColor *)orangeColor
{
    return [self colorWithRed:255 green:91 blue:1];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    CGFloat divisor = 255.f;
    return [self colorWithRed:red/divisor green:green/divisor blue:blue/divisor alpha:1];
}

@end