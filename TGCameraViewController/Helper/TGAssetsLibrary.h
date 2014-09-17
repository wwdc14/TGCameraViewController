//
//  TGAssetsLibrary.h
//  TGCameraViewController
//
//  Created by Bruno Furtado on 17/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import AssetsLibrary;
#import "TGAssetImageFile.h"

typedef void(^TGAssetsSaveImageCompletion)(NSError* error);
typedef void(^TGAssetsLoadImagesCompletion)(NSArray *items, NSError *error);



@interface TGAssetsLibrary : ALAssetsLibrary

- (instancetype) init __attribute__
((unavailable("[-init] is not allowed, use [+defaultAssetsLibrary]")));

+ (instancetype) new __attribute__
((unavailable("[+new] is not allowed, use [+defaultAssetsLibrary]")));

+ (TGAssetsLibrary *)defaultAssetsLibrary;

- (void)deleteFile:(TGAssetImageFile *)file;

- (NSArray *)loadImagesFromDocumentDirectory;
- (void)loadImagesFromAlbum:(NSString *)albumName withCallback:(TGAssetsLoadImagesCompletion)callback;

- (void)saveImage:(UIImage *)image completion:(TGAssetsSaveImageCompletion)completion;
- (void)saveImage:(UIImage *)image withAlbumName:(NSString *)albumName completion:(TGAssetsSaveImageCompletion)completion;
- (void)saveJPGImageAtDocumentDirectory:(UIImage *)image;

@end