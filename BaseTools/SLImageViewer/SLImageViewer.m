//
//  SLImageViewer.m
//  YjyxTeacher
//
//  Created by liushaochang on 2016/12/27.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import "SLImageViewer.h"
#import "SLCollectionViewCell.h"
#import "YjyxDrawLine.h"


@interface SLImageViewer ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    SLCollectionViewCell *currentCell;
    NSInteger clockCount;//旋转次数
    
}
@property (strong, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) CGSize size;
@property (strong, nonatomic) NSMutableDictionary *paintDic;

@end
#define ID @"SLCollectionViewCell"
@implementation SLImageViewer

// 初始化方法
+ (instancetype)imageViewerWithFrame:(CGRect)frame delegate:(id<SLImageViewerDelegate>)delegate placeholderImage:(UIImage *)placeholderImage {

    SLImageViewer *imageViewer = [[SLImageViewer alloc] initWithFrame:frame];
    imageViewer.delegate = delegate;
    imageViewer.placeholderImage = placeholderImage;
    [imageViewer configureMainview];
    return imageViewer;
}

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup {

    _imageURLStringsGroup = imageURLStringsGroup;
    
//    [self.collectionView reloadData];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    [self layoutIfNeeded];
    self.collectionView.contentOffset = CGPointMake(self.bounds.size.width *self.currentIndex, 0);
    currentCell = (SLCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    NSLog(@"%@", currentCell);
    currentCell.imageView.userInteractionEnabled = _isCanPaint == YES ? YES : NO;
}

- (void)configureMainview {

    _paintDic = [NSMutableDictionary dictionary];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    clockCount = 1;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollsToTop = NO;

    [self addSubview:_collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SLCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    
}

#pragma mark - UICollectionViewDataSource 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageURLStringsGroup.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
   
    cell.WIDTH = self.bounds.size.width;
    cell.HEIGHT = self.bounds.size.height;
    cell.placeholderImage = _placeholderImage;
    cell.paintColor = _paintColor;
    cell.brushWidth = _brushWidth;
    cell.imageView.userInteractionEnabled = _isCanPaint == YES ? YES : NO;
    UIImage *image = _paintDic[[NSString stringWithFormat:@"%ld", indexPath.item]];
    if (image) {
        [cell setSubivewsWithDrawImage:image];
    }else {
        if ([_imageURLStringsGroup[indexPath.item] isKindOfClass:[UIImage class]]) {
            [cell setSubivewsWithDrawImage:_imageURLStringsGroup[indexPath.item]];
        }else {
            cell.url = _imageURLStringsGroup[indexPath.item];
            NSLog(@"%@", cell.url);
        }
    }
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    SLCollectionViewCell *slCell = (SLCollectionViewCell *)cell;
    slCell.currentScale = 1.0;
    [slCell.scrolBgView setZoomScale:slCell.currentScale animated:YES];
    UIImage *image = _paintDic[[NSString stringWithFormat:@"%ld", indexPath.item]];
    if (image) {
        [slCell setSubivewsWithDrawImage:image];
    }else {
        if (indexPath.item >= _imageURLStringsGroup.count) {
            return;
        }
        slCell.url = _imageURLStringsGroup[indexPath.item];
    }

}

#pragma mark - 私有方法
// 往前滚动
- (void)scrollForward {
    
    if (_currentIndex == _imageURLStringsGroup.count - 1) {
        [self makeToast:@"当前图片已经是最后一张了" duration:1.0 position:SHOW_CENTER complete:nil];
    }else {
        [self imageWithDraw];
        // 清空画布信息
        [self removeAllLine];
        _currentIndex += 1;
        [self layoutIfNeeded];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
    
}
// 往后滚动
- (void)scrollBack {
    
    if (_currentIndex == 0) {
        [self makeToast:@"当前图片已经是第一张了" duration:1.0 position:SHOW_CENTER complete:nil];
    }else {
        [self imageWithDraw];
        // 清空画布信息
        [self removeAllLine];
        _currentIndex -= 1;
        [self layoutIfNeeded];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self currentIndexChanged];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    [self currentIndexChanged];
}

- (void)currentIndexChanged {
    
    NSInteger index = _collectionView.contentOffset.x/self.bounds.size.width;
    if (index != _currentIndex) {
        [self imageWithDraw];
        // 清空画布信息
        [self removeAllLine];
        _currentIndex = index;
    }
    currentCell = (SLCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0]];
    [self changeValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewerScrollAtIndex:)]) {
        [self.delegate imageViewerScrollAtIndex:_currentIndex];
    }
    
    
}



// 顺时针旋转
- (void)clockwise {
    if (currentCell == nil) {
        [self getCurrentCell];
    }
    CGAffineTransform transform = CGAffineTransformMakeRotation(90 *clockCount* M_PI/180.0);
    if (clockCount == 4) {
        clockCount = 1;
    }else {
        clockCount += 1;
    }
    [currentCell.scrolBgView setTransform:transform];
    
    
}

- (void)getCurrentCell {
    currentCell = (SLCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0]];
}

// 删除上一条线
- (void)deleteLastLine {
    if (currentCell == nil) {
        [self getCurrentCell];
    }
    [currentCell deleteLastLine];
}
// 恢复上一步操作（如果全部删除，不恢复）
- (void)recoverLastDelete {
    if (currentCell == nil) {
        [self getCurrentCell];
    }
    [currentCell recoverLastDelete];

}
// 清除全部涂鸦
- (void)removeAllLine {
    if (currentCell == nil) {
        [self getCurrentCell];
    }
    [currentCell removeAllLine];

}

- (void)changeValue {
    if (currentCell == nil) {
        [self getCurrentCell];
    }
    [currentCell.imageView setUserInteractionEnabled:_isCanPaint];
    [_collectionView setScrollEnabled:!_isCanPaint];
    [currentCell.drawLine setCurrentPaintBrushColor:_paintColor];
    [currentCell.drawLine setCurrentPaintBrushWidth:_brushWidth];
    

}

#pragma mark - 生成图片
- (void)imageWithDraw {
    if (currentCell == nil) {
        [self getCurrentCell];
    }
    if (currentCell.drawLine.allMyDrawPaletteLineInfos.count != 0) {
        // 生成图片
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(currentCell.imageView.bounds.size.width, currentCell.imageView.bounds.size.height), NO, 0);
        [currentCell.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 保存
        [_paintDic setObject:uiImage forKey:[NSString stringWithFormat:@"%ld", _currentIndex]];
        
        
    }
    
    
}

- (NSMutableDictionary *)getThePaintInfo {

    [self imageWithDraw];
    [self removeAllLine];
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:_currentIndex inSection:0];
    [self.collectionView reloadItemsAtIndexPaths:@[indexpath]];
    currentCell = nil;
    return _paintDic;
}

- (void)removeAllTheSaveDic {

    [_paintDic removeAllObjects];
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"SLImageViewer销毁了");
}




@end
