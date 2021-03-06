//
//  ZYPhotoCell.h
//  嘴爷照片查看器
//
//  Created by Mac on 16/3/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PhotoBrowserTapType) {
    PhotoBrowserTapTypeDefault = 0,
    /** 单击手势*/
    PhotoBrowserTapTypeSingle,
    /** 双击手势*/
    PhotoBrowserTapTypeDouble,
    /** 长按手势*/
    PhotoBrowserTapTypeLongPress
};


@class ZYPhotoCell;
@protocol ZYPhotoCellDelegate <NSObject>
@optional
/**
 *  @author 嘴爷, 2016-03-30 16:03:35
 *
 *  @brief 单击或者双击图片的时候
 *
 *  @param cell ZYPhotoCell
 *  @param count 点击的时候几个手势
 */
-(void)zyPhotoCell:(ZYPhotoCell*)cell tapType:(PhotoBrowserTapType)type;

@end

@interface ZYPhotoCell : UICollectionViewCell<UIScrollViewDelegate>

@property (nonatomic, weak) id<ZYPhotoCellDelegate> delgate;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) NSURL* url;
@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, strong) UILabel* loadingLabel;

@end
