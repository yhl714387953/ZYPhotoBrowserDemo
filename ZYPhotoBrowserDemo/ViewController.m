//
//  ViewController.m
//  ZYPhotoBrowserDemo
//
//  Created by Mac on 16/4/12.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "ZYPhotoViewController.h"
#import "SDImageCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测试";
    
    [[SDImageCache sharedImageCache] clearDisk];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearImage:(UIButton *)sender {
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}


- (IBAction)clicked:(id)sender {
    NSMutableArray* array = [NSMutableArray array];
    for (int i= 0; i < 10 ; i++) {
        NSString* urlStr = @"";
        if (i % 4 == 0) {
            urlStr = @"http://www.33lc.com/article/UploadPic/2012-7/201272714192194886.jpg";
        }else if(i % 2 == 0){
            urlStr = @"http://img4.duitang.com/uploads/item/201510/17/20151017000316_diBQY.jpeg";
        }else{
            urlStr = @"http://img6.faloo.com/picture/0x0/0/183/183379.jpg";
            
        }
        
        [array addObject:[NSURL URLWithString:urlStr]];
        
        if (i == 0) {//本地图片
            [array addObject:[NSURL fileURLWithPath:@"/Users/mac/Downloads/dongman1.jpg"]];
        }
        
    }
    
    ZYPhotoViewController* vc = [[ZYPhotoViewController alloc] init];
    vc.imageUrls = array;
    vc.currentIndex = 2;
    
    UIViewController* preVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [preVC presentViewController:vc animated:NO completion:^{
        
    }];
}

@end
