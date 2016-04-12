//
//  ZYPhotoViewController.h
//  嘴爷照片查看器
//
//  Created by Mac on 16/3/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYPhotoViewController : UIViewController
@property (nonatomic, strong) NSMutableArray<NSURL*>* imageUrls;
@property (nonatomic) NSInteger currentIndex;
//待重构  实现缩放
@property (nonatomic, strong) UIView* fromView;
@end
