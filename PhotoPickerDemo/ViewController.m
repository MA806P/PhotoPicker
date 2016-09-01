//
//  ViewController.m
//  PhotoPickerDemo
//
//  Created by 159CaiMini02 on 16/8/31.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "ViewController.h"

@import Photos;

@interface ViewController ()

@end

@implementation ViewController



- (void)awakeFromNib
{
//    PHFetchOptions * allPhotoOptions = [[PHFetchOptions alloc] init];
//    allPhotoOptions.sortDescriptors
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
