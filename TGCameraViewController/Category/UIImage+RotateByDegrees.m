//
//  UIImage+RotateByDegrees.m
//  TGCameraViewController
//
//  Created by Bruno Furtado on 16/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "UIImage+RotateByDegrees.h"

@implementation UIImage (RotateByDegrees)

- (UIImage *)imageRotateByDegrees:(CGFloat)degress
{
    CGRect frame;
    
    frame = CGRectMake(0, 0, self.size.width, self.size.height);
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:frame];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(degress * M_PI / 180);
    rotatedViewBox.transform = transform;
    
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    CGContextRotateCTM(bitmap, (degress * M_PI / 180));
    
    CGContextScaleCTM(bitmap, 1, -1);
    
    frame = CGRectMake(-self.size.width/2, -self.size.height/2, self.size.width, self.size.height);
    CGContextDrawImage(bitmap, frame, [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end