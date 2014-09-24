//
//  TGPhotoViewController.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import AssetsLibrary;
#import "TGPhotoViewController.h"
#import "TGAssetsLibrary.h"
#import "TGCameraColor.h"
#import "TGCameraFilterView.h"
#import "UIImage+CameraFilters.h"



@interface TGPhotoViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet TGCameraFilterView *filterView;
@property (strong, nonatomic) IBOutlet UIButton *defaultFilterButton;

@property (weak) id<TGCameraDelegate> delegate;
@property (strong, nonatomic) UIView *detailFilterView;
@property (strong, nonatomic) UIImage *photo;

- (IBAction)backTapped;
- (IBAction)confirmTapped;
- (IBAction)filtersTapped;

- (IBAction)defaultFilterTapped:(UIButton *)button;
- (IBAction)satureFilterTapped:(UIButton *)button;
- (IBAction)curveFilterTapped:(UIButton *)button;
- (IBAction)vignetteFilterTapped:(UIButton *)button;

- (void)addDetailViewToButton:(UIButton *)button;
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
    
    _photoView.clipsToBounds = YES;
    _photoView.image = _photo;
    
    [self addDetailViewToButton:_defaultFilterButton];
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

- (IBAction)confirmTapped
{
    if ( [_delegate respondsToSelector:@selector(cameraWillTakePhoto)]) {
        [_delegate cameraWillTakePhoto];
    }
    
    if ([_delegate respondsToSelector:@selector(cameraDidTakePhoto:)]) {
        _photo = _photoView.image;
        [_delegate cameraDidTakePhoto:_photo];
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == ALAuthorizationStatusAuthorized) {
            TGAssetsLibrary *library = [TGAssetsLibrary defaultAssetsLibrary];
            [library saveImage:_photo completion:nil];
        }
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

- (IBAction)defaultFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    _photoView.image = _photo;
}

- (IBAction)satureFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    _photoView.image = [_photo saturateImage:1.8 withContrast:1];
}

- (IBAction)curveFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    _photoView.image = [_photo curveFilter];
}

- (IBAction)vignetteFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    _photoView.image = [_photo vignetteWithRadius:0 intensity:6];
}

#pragma mark -
#pragma mark - Private methods

- (void)addDetailViewToButton:(UIButton *)button
{
    [_detailFilterView removeFromSuperview];
    
    CGFloat height = 2.5;
    
    CGRect frame = button.frame;
    frame.size.height = height;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(button.frame) - height;
    
    _detailFilterView = [[UIView alloc] initWithFrame:frame];
    _detailFilterView.backgroundColor = [TGCameraColor orangeColor];
    _detailFilterView.userInteractionEnabled = NO;
    
    [button addSubview:_detailFilterView];
}

+ (instancetype)newController
{
    return [super new];
}

@end