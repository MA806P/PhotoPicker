//
//  RootViewController.m
//  PhotoPickerDemo
//
//  Created by 159CaiMini02 on 16/9/5.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "RootViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>


#define SHOWMESSAGE(title,messages) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:messages \
delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil]; \
[alert show]; \


@interface RootViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;

@end



@implementation RootViewController


- (IBAction)pickerBtnAction:(id)sender
{
    
    
    //应用名称, 提示信息里会用到
    NSDictionary * mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString * appName = [mainInfoDictionary objectForKey:@"CFBundleName"];
    
    
    UIAlertController * selectImgAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [selectImgAlert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //相机功能
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            SHOWMESSAGE(@"提示", @"该设备不支持相机功能");
            return;
        }
        
        //是否授权使用相机
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusDenied)
        {
            NSString * title = [NSString stringWithFormat:@"%@没有权限访问相机", appName];
            NSString * message = [NSString stringWithFormat:@"请进入系统 设置>隐私>相机 允许\"%@\"访问您的相机",appName];
            SHOWMESSAGE(title, message);
            return;
        }
        
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        [self presentViewController:pickerImage animated:YES completion:nil];
        
    }]];
    
    
    [selectImgAlert addAction:[UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //是否支持相册功能
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            SHOWMESSAGE(@"提示", @"该设备不支持相册功能");
            return;
        }
        
        //是否授权访问照片
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusDenied)
        {
            NSString * title = [NSString stringWithFormat:@"%@没有权限访问照片", appName];
            NSString * message = [NSString stringWithFormat:@"请进入系统 设置>隐私>照片 允许\"%@\"访问您的照片",appName];
            SHOWMESSAGE(title, message);
            return;
        }
        
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        [self presentViewController:pickerImage animated:YES completion:nil];
        
    }]];
    
    [selectImgAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){}]];
    
    //selectImgAlert.view.tintColor = [UIColor redColor];
    [self presentViewController:selectImgAlert animated:YES completion:nil];
    
}


#pragma mark - Imagepicker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        self.userImgView.image = image;
    }];
    
    
    //    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //    NSString * imageName1 = [[paths firstObject] stringByAppendingString:@"/userHeadImage.jpg"];
    //    [headImageData writeToFile:imageName1 atomically:YES];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        NSFileManager * fileManager = [NSFileManager defaultManager];
    //        unsigned long long fileSize1 = [[fileManager attributesOfItemAtPath:imageName1 error:nil] fileSize] ;
    //        NSString * cacheSizeStr1 = [NSString stringWithFormat:@"%.2fk",fileSize1/(1024.0)];
    //        NSLog(@" 1 - %@  ", cacheSizeStr1);
    //    });
    
    
}





//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//    
//    UIImage * originImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    
//    
//    
//    //    CGFloat cutImgW = self.userImgView.frame.size.width;
//    //    CGFloat cutImgH = self.userImgView.frame.size.height;
//    //    CGFloat cutImgX = (originImage.size.width - cutImgW) * 0.5;
//    //    CGFloat cutImgY = (originImage.size.height - cutImgH) * 0.5;
//    //
//    //
//    //
//    //    UIGraphicsBeginImageContextWithOptions(CGSizeMake(cutImgW, cutImgH), NO, 0);
//    //    [originImage drawInRect:CGRectMake(-cutImgX, -cutImgY, cutImgW, cutImgH)];
//    
//    
//    CGFloat imageW = originImage.size.width;
//    CGFloat imageH = originImage.size.height;
//    CGFloat imageX;
//    CGFloat imageY;
//    CGFloat equalWH;
//    if (imageW >= imageH)
//    {
//        equalWH = imageH;
//        imageX = -(imageW - imageH)*0.5;
//        imageY = 0;
//    }
//    else
//    {
//        equalWH = imageW;
//        imageX = 0;
//        imageY = -(imageH - imageW)*0.5;
//    }
//    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(equalWH, equalWH), NO, 0);
//    [originImage drawInRect:CGRectMake(imageX, imageY, originImage.size.width, originImage.size.height)];
//    UIImage * cutImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    
//    self.userImgView.image = originImage;
//    NSLog(@" %@  %@ ", NSStringFromCGSize(originImage.size), NSStringFromCGSize(cutImage.size));
//    
//    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString * imageName1 = [[paths firstObject] stringByAppendingString:@"/1-0.jpg"];
//    NSString * imageName2 = [[paths firstObject] stringByAppendingString:@"/1-1.jpg"];
//    
//    [UIImageJPEGRepresentation(originImage, 0.2) writeToFile:imageName1 atomically:YES];
//    [UIImageJPEGRepresentation(cutImage, 0.2) writeToFile:imageName2 atomically:YES];
//    
//    
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        NSFileManager * fileManager = [NSFileManager defaultManager];
//        unsigned long long fileSize1 = [[fileManager attributesOfItemAtPath:imageName1 error:nil] fileSize] ;
//        unsigned long long fileSize2 = [[fileManager attributesOfItemAtPath:imageName2 error:nil] fileSize] ;
//        NSString * cacheSizeStr1 = [NSString stringWithFormat:@"%.2fk",fileSize1/(1024.0)];
//        NSString * cacheSizeStr2 = [NSString stringWithFormat:@"%.2fk",fileSize2/(1024.0)];
//        NSLog(@" 1 - %@    2 - %@", cacheSizeStr1, cacheSizeStr2);
//        
//    });
//    
//    
//}

@end
