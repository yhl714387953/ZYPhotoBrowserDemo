//
//  ZYPhotoViewController.m
//  嘴爷照片查看器
//
//  Created by Mac on 16/3/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ZYPhotoViewController.h"
#import "ZYPhotoCell.h"

@interface ZYPhotoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ZYPhotoCellDelegate>
{
    BOOL _statusHidden;
    BOOL _viewIsAppear;
}
@property (nonatomic, strong) UICollectionView* collectionView;

@property (nonatomic, strong) UIPageControl* pageControl;
@end

@implementation ZYPhotoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionNone) animated:NO];
    

    
//    一张照片 pageControl隐藏
    self.pageControl.hidden = self.imageUrls.count <= 1;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.currentIndex < self.imageUrls.count) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.alpha = 1;
            
        } completion:^(BOOL finished) {
            _viewIsAppear = YES;
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
}

-(BOOL)prefersStatusBarHidden{
    if (_viewIsAppear) {
        return YES;
    }
    
    if (_statusHidden) {
        return NO;
    }
    
    return NO;
}

-(void)initUI{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[ZYPhotoCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 20)];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPage = self.currentIndex;
    self.pageControl.numberOfPages = self.imageUrls.count;
    
    [self.view addSubview:self.pageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageUrls.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZYPhotoCell* cell = (ZYPhotoCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delgate = self;

//    NSString* urlStr = @"";
//    if (indexPath.item % 4 == 0) {
//        urlStr = @"http://www.33lc.com/article/UploadPic/2012-7/201272714192194886.jpg";
//    }else if(indexPath.item % 2 == 0){
//        urlStr = @"http://pic14.nipic.com/20110601/6854365_075711249000_2.jpg";
//    }else{
//        urlStr = @"http://bizhi.33lc.com/uploadfile/2015/0928/20150928031048464.jpg";
//    }
    NSURL* url = self.imageUrls[indexPath.item];
    if ([url isKindOfClass:[NSURL class]]) cell.url = url;
    
    [cell setNeedsLayout];
    
    return cell;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / scrollView.frame.size.width);
}

#pragma mark -
#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return collectionView.frame.size;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeZero;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

#pragma mark -
#pragma mark - ZYPhotoCellDelegate
-(void)zyPhotoCell:(ZYPhotoCell *)cell tapCount:(NSInteger)count{
    if (count == 1) {
        _statusHidden = YES;
        _viewIsAppear = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        [UIView animateWithDuration:0.1 animations:^{
            self.view.alpha = 0.4;
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:^{
                
            }];
        }];
        
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
