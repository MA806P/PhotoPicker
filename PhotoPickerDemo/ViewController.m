//
//  ViewController.m
//  PhotoPickerDemo
//
//  Created by 159CaiMini02 on 16/8/31.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@import Photos;

@interface ViewController ()

@property (nonatomic, strong) ALAssetsLibrary * assetsLibrary;

@property (nonatomic, strong) NSMutableArray * albumsArray;

@end

@implementation ViewController

- (NSMutableArray *)albumsArray
{
    if (_albumsArray == nil)
    {
        _albumsArray = [NSMutableArray array];
    }
    return _albumsArray;
}


- (void)awakeFromNib
{
//    PHFetchOptions * allPhotoOptions = [[PHFetchOptions alloc] init];
//    allPhotoOptions.sortDescriptors
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        return;
    }
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if (authStatus != ALAuthorizationStatusAuthorized)
    {
        return;
    }
    
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group)
        {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            if (group.numberOfAssets > 0)
            {
                [self.albumsArray addObject:group];
            }
        }
        else
        {
            if (self.albumsArray.count > 0)
            {
                
            }
        }
    } failureBlock:^(NSError *error) {
        
        
        
    }];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}





- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)doneButtonAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
