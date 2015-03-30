//
//  TGTintedButton.m
//  TGCameraViewController
//
//  Created by Mike Sprague on 3/30/15.
//  Copyright (c) 2015 Tudo Gostoso Internet. All rights reserved.
//

#import "TGTintedButton.h"
#import "TGCameraColor.h"

@interface TGTintedButton ()

- (void)updateTintIfNeeded;

@end


@implementation TGTintedButton

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self updateTintIfNeeded];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    if (state != UIControlStateNormal) {
        return;
    }
    
    [super setBackgroundImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:state];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    if (state != UIControlStateNormal) {
        return;
    }
    
    [super setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:state];
}

- (void)updateTintIfNeeded {
    UIColor *color = self.customTintColorOverride != nil ? self.customTintColorOverride : [TGCameraColor tintColor];
    
    if(self.tintColor != color) {
        [self setTintColor:color];
        
        UIImage * __weak backgroundImage = [[self backgroundImageForState:UIControlStateNormal]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        
        UIImage * __weak image = [[self imageForState:UIControlStateNormal]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self setImage:image forState:UIControlStateNormal];
        
    }
}

@end
