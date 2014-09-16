//
//  TGPhotoViewController.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGPhotoViewController.h"

@interface TGPhotoViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *photoView;

@property (weak) id<TGCameraDelegate> delegate;
@property (strong, nonatomic) UIImage *photo;

- (IBAction)backTapped;
- (IBAction)cancelTapped;
- (IBAction)confirmTapped;

+ (instancetype)newController;

@end



@implementation TGPhotoViewController

+ (instancetype)newWithDelegate:(id<TGCameraDelegate>)delegate photo:(UIImage *)photo
{
    TGPhotoViewController *viewController = [TGPhotoViewController newController];
    
    if (viewController) {
        viewController.delegate = delegate;
        viewController.photo = photo;
    }
    
    return viewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    _photoView.image = _photo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -
#pragma mark - Actions

- (IBAction)backTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirmTapped
{
    if ([_delegate respondsToSelector:@selector(cameraImage:)]) {
        [_delegate cameraImage:_photo];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark - Private methods

+ (instancetype)newController
{
    return [super new];
}

@end