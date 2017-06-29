//
//  SLCollectionViewCell.m
//  YjyxTeacher
//
//  Created by liushaochang on 2016/12/27.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import "SLCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "YjyxDrawLine.h"


@interface SLCollectionViewCell ()<UIScrollViewDelegate>
{
    CGSize size;
    CGFloat maxScale;
    CGFloat normalScale;
    
}

@end

@implementation SLCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self configureScrollView];
}

- (void)configureScrollView {

    maxScale = 2.0;
    normalScale = 1.0;
    _currentScale = normalScale;
    
    // ScrollView
    _scrolBgView.userInteractionEnabled = YES;
    _scrolBgView.scrollsToTop = NO;
    _scrolBgView.maximumZoomScale = maxScale;
    _scrolBgView.delegate = self;
    _scrolBgView.showsVerticalScrollIndicator = NO;
    _scrolBgView.showsHorizontalScrollIndicator = NO;
    _scrolBgView.canCancelContentTouches = YES;
    _scrolBgView.delaysContentTouches = NO;
    
    // ImageView
    _imageView = [[UIImageView alloc] init];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [_scrolBgView addSubview:_imageView];
    _imageView.center = _scrolBgView.center;
    _imageView.userInteractionEnabled = YES;
    
    // 画布
    _drawLine = [YjyxDrawLine defaultLineWithFrame:_imageView.bounds];
    [_imageView addSubview:_drawLine];
    

}


- (void)setUrl:(NSString *)url {

    _url = url;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:_placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [self checkImageSize:image];
        _imageView.frame = CGRectMake((self.bounds.size.width - size.width)/2, (self.bounds.size.height - size.height)/2, size.width, size.height);
        _drawLine.frame = _imageView.bounds;
        
    }];
    _drawLine.currentPaintBrushColor = _paintColor;
    _drawLine.currentPaintBrushWidth = _brushWidth;
    
}

- (void)setSubivewsWithDrawImage:(UIImage *)image {

    self.imageView.image = image;
    [self checkImageSize:image];
    _imageView.frame = CGRectMake((self.bounds.size.width - size.width)/2, (self.bounds.size.height - size.height)/2, size.width, size.height);
    _drawLine.frame = _imageView.bounds;
    _drawLine.currentPaintBrushColor = _paintColor;
    _drawLine.currentPaintBrushWidth = _brushWidth;
    
}


- (void)checkImageSize:(UIImage *)image {

    CGSize imageSize = image.size;
    CGFloat ratio = imageSize.width / imageSize.height;
    if (imageSize.width > SCREEN_WIDTH - 16) {
        size.width = SCREEN_WIDTH - 16;
        size.height = size.width / ratio;
    }else {
        size = imageSize;
    }
    
    if (size.height > SCREEN_HEIGHT*473/667) {
        size.height = SCREEN_HEIGHT*473/667;
        size.width = size.height * ratio;
    }
}


#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    _currentScale = scale;
    // 保持在中心点
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    [_imageView setCenter:CGPointMake(xcenter, ycenter)];
    
}

#pragma mark - 画图

// 撤销上一步
- (void)deleteLastLine {
    [_drawLine cleanFinallyDraw];
}

// 恢复撤销操作（上一步）
- (void)recoverLastDelete {
    [_drawLine recoverFinalDraw];
}

// 撤销所有画图
- (void)removeAllLine {

    [_drawLine cleanAllDrawBySelf];
}





- (void)layoutSubviews {
    [super layoutSubviews];
//    CGRect frame;
//    frame.size = size;
//    self.imageView.frame = frame;
//    self.imageView.center = _scrolBgView.center;
////    self.imageView.frame = self.bounds;
//    self.drawLine.frame = self.imageView.bounds;
}



@end
