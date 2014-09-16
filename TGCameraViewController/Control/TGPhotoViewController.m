//
//  TGPhotoViewController.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

#import "TGPhotoViewController.h"
#import "TGFilterView.h"
#import "UIImage+CameraFilters.h"
#import "UIView+CameraAnimations.h"



@interface TGPhotoViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet TGFilterView *filterView;

@property (weak) id<TGCameraDelegate> delegate;
@property (strong, nonatomic) UIImage *photo;

- (IBAction)backTapped;
- (IBAction)cancelTapped;
- (IBAction)confirmTapped;
- (IBAction)filtersTapped;

- (IBAction)defaultFilterTapped;
- (IBAction)satureFilterTapped;
- (IBAction)curveFilterTapped;
- (IBAction)vignetteFilterTapped;


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
#pragma mark - Controller actions

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
        _photo = _photoView.image;
        [_delegate cameraImage:_photo];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)filtersTapped
{
    if ([_filterView isDescendantOfView:self.view]) {
        [_filterView removeFromSuperviewAnimated];
    } else {
        [_filterView addToView:self.view aboveView:_bottomView];
        [self.view sendSubviewToBack:_filterView];
        [self.view sendSubviewToBack:_photoView];
    }
}

#pragma mark -
#pragma mark - Filter view actions

- (IBAction)defaultFilterTapped
{
    _photoView.image = _photo;
}

- (IBAction)satureFilterTapped
{
    _photoView.image = [_photo saturateImage:1.8 withContrast:1];
}

- (IBAction)curveFilterTapped
{
    _photoView.image = [_photo curveFilter];
}

- (IBAction)vignetteFilterTapped
{
    _photoView.image = [_photo vignetteWithRadius:0 intensity:6];
}

#pragma mark -
#pragma mark - Private methods

+ (instancetype)newController
{
    return [super new];
}

@end