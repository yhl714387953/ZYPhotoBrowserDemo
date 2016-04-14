//
//  ZYPhotoCell.m
//  嘴爷照片查看器
//
//  Created by Mac on 16/3/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ZYPhotoCell.h"
#import "UIImageView+WebCache.h"

@implementation ZYPhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
//    [self.contentView addSubview:self.circleBar];
//    [self.contentView addSubview:self.circleView];
    [self.contentView addSubview:self.loadingLabel];
    
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.contentView addGestureRecognizer:longPress];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    self.scrollView.zoomScale = 1.0f;
    self.imageView.frame = self.scrollView.bounds;
    self.imageView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);

    self.loadingLabel.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    self.imageView.backgroundColor = [UIColor colorWithRed:2 / 255.0 green:2 / 255.0 blue:2 / 255.0 alpha:1];
    
//    [self.imageView sd_setImageWithURL:self.url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
////        重置imageView大小
//        if (image.size.height > 1) {
//            [self resetImageViewFrame:image.size];
//        }
//        
//    }];
    

    self.loadingLabel.hidden = NO;
    [self.imageView sd_setImageWithURL:self.url placeholderImage:nil options:(SDWebImageRefreshCached) progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        NSLog(@"下载进度：%ld   图片总大小%ld", (long)receivedSize, (long)expectedSize);
        dispatch_async(dispatch_get_main_queue(), ^{
  
//            [self.circleBar setProgress:(CGFloat)receivedSize / (CGFloat)expectedSize animated:NO];
        });
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (error) {
            NSLog(@"%@", error);
        }
        
        self.loadingLabel.hidden = YES;
        //        重置imageView大小
        if (image.size.height > 1) {
            [self resetImageViewFrame:image.size];
        }
        
        
    }];
    
}

-(void)resetImageViewFrame:(CGSize)imageSize{
    CGFloat imageScale = imageSize.width / imageSize.height;
    CGFloat scrollViewScale = self.scrollView.frame.size.width / self.scrollView.frame.size.height;
    
    CGFloat width = 0;
    CGFloat height = 0;
    if (imageScale > scrollViewScale) { //图片宽特别长的时候，那就用scrollView的宽为基础宽度
        width = self.scrollView.frame.size.width;
        height = width / imageScale;
    }else{//图片宽特别高的时候，那就用scrollView的高为基础高度
        height = self.scrollView.frame.size.height;
        width = height * imageScale;
    }
    
    self.imageView.frame = CGRectMake(0, 0, width, height);
    self.imageView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
}


#pragma mark -
#pragma mark - tapAction
-(void)handSingleTap:(UITapGestureRecognizer*)tap{
    if (self.delgate && [self.delgate respondsToSelector:@selector(zyPhotoCell:tapType:)]) {
        [self.delgate zyPhotoCell:self tapType:(PhotoBrowserTapTypeSingle)];
    }
}

-(void)handDoubleTap:(UITapGestureRecognizer*)tap{
    
    CGFloat zoomScale = self.scrollView.zoomScale > 2 ? 1 : 3;
    
//    CGRect zoomRect = [self zoomRectForScale:zoomScale withCenter:[tap locationInView:tap.view]];
//    [self.scrollView zoomToRect:zoomRect animated:YES];
    
    
    [self.scrollView setZoomScale:zoomScale animated:YES];
    if (self.delgate && [self.delgate respondsToSelector:@selector(zyPhotoCell:tapType:)]) {
        [self.delgate zyPhotoCell:self tapType:(PhotoBrowserTapTypeDouble)];
    }
}

-(void)longPress:(UILongPressGestureRecognizer*)longPress{
    if (self.delgate && [self.delgate respondsToSelector:@selector(zyPhotoCell:tapType:)]) {
        [self.delgate zyPhotoCell:self tapType:(PhotoBrowserTapTypeLongPress)];
    }
}

#pragma mark - CommonMethods
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height =self.frame.size.height / scale;
    zoomRect.size.width  =self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  /2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height /2.0);
    return zoomRect;
}

#pragma mark -
#pragma mark - getter
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handSingleTap:)];
        
        UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [_imageView addGestureRecognizer:singleTap];
        [_imageView addGestureRecognizer:doubleTap];
        
        
    }

    return _imageView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.maximumZoomScale = 3;
        _scrollView.minimumZoomScale = 1;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handSingleTap:)];
        [_scrollView addGestureRecognizer:singleTap];
    }
    
    return _scrollView;
}

-(UILabel *)loadingLabel{
    if (!_loadingLabel) {
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 14)];
        _loadingLabel.textColor = [UIColor whiteColor];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.text = @"加载中…";
        _loadingLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    
    return _loadingLabel;
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    self.imageView.center = CGPointMake(xcenter, ycenter);
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
//    NSLog(@"%@  \n\n\n\n  %f", view, scale);
}


@end
