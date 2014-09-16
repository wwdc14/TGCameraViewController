//
//  TGPhotoViewController.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGPhotoViewController.h"
#import "UIImage+CameraFilters.h"

@interface TGPhotoViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *photoView;

@property (weak) id<TGCameraDelegate> delegate;
@property (strong, nonatomic) UIImage *photo;

- (IBAction)backTapped;
- (IBAction)resetTapped;
- (IBAction)cancelTapped;
- (IBAction)confirmTapped;
- (IBAction)filtersTapped;

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

- (IBAction)resetTapped
{
    _photoView.image = _photo;
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

- (IBAction)filtersTapped
{
    // effect 1
    //_photoView.image = [_photoView.image saturateImage:1.8 withContrast:1];
    
    // effect 2
    //_photoView.image = [_photoView.image saturateImage:0 withContrast:1.05];
    
    // effect 3
    //_photoView.image = [_photoView.image vignetteWithRadius:0 intensity:6];
    
    // effect 4
    //_photoView.image = [_photoView.image curveFilter];
}

#pragma mark -
#pragma mark - Private methods

+ (instancetype)newController
{
    return [super new];
}

@end