##菜鸟一枚 给大家做一次分享
***
用环信做个聊天，图片查看的效果跟设计的差了一些，就自己写了一个！
如果欢迎大家给我指点，在这里谢过了！

<img src="picture/pic1.jpg" width = "320">
<img src="picture/pic2.jpg" width = "320">

***
###使用方法
#####一个参数是当前索引，一个参数是数据源

```objc
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

```