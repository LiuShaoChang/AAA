//
//  SLWaterFlowLayout.m
//  WaterFlowTest
//
//  Created by liushaochang on 2017/6/27.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import "SLWaterFlowLayout.h"

@interface SLWaterFlowLayout ()

/** 布局属性数组*/
@property (nonatomic,strong) NSMutableArray *attributesArray;

/** 存放所有列的当前高度*/
@property (nonatomic,strong) NSMutableArray *columnHeights;

@end

@implementation SLWaterFlowLayout

static const CGFloat defaultColumCount = 3;
static const CGFloat defaultColumMargin = 10;
static const CGFloat defaultRowMargin = 10;
static const UIEdgeInsets defaultEdgeInsets = {10,10,10,10};

#pragma mark - Lazy Method
- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

#pragma mark - Overriding Method
// 初始化
- (void)prepareLayout {

    [super prepareLayout];
    // 清空高度
    [self.columnHeights removeAllObjects];
    // 初始高度
    for (int i = 0; i < self.columCount; i++) {
        [self.columnHeights addObject:@(defaultEdgeInsets.top)];
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    [self.attributesArray removeAllObjects];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.attributesArray addObject:attribute];
    }
    
}

// 布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 找到高度最短的列
    NSInteger theLowestColum = 0;
    CGFloat theLowestHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 0; i < self.columCount; i++) {
        CGFloat colunmHeight = [self.columnHeights[i] doubleValue];
        if (theLowestHeight > colunmHeight) {
            theLowestHeight = colunmHeight;
            theLowestColum = i;
        }
    }
    
    // cell布局属性,位置,宽高
    // cell宽度
    CGFloat w = (self.collectionView.frame.size.width - self.wEdgeInsets.left - self.wEdgeInsets.right - (self.columCount - 1) * self.columMargin)/self.columCount;
    // cell高度
    CGFloat h = [self.waterFlowLayoutDelegate flowLayout:self heightForRowAtIndex:indexPath.item itemWidth:w];
    CGFloat x = self.wEdgeInsets.left + theLowestColum *(w + self.columMargin);
    CGFloat y = theLowestHeight;
    
    if (y != self.wEdgeInsets.top) {
        y += self.rowMargin;
    }
    attributes.frame = CGRectMake(x, y, w, h);
    // 更新高度
    self.columnHeights[theLowestColum] = @(y + h);
    
    return attributes;
}

// cell排列
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

// 滚动范围
- (CGSize)collectionViewContentSize {
    CGFloat maxHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 0; i < self.columCount; i++) {
        CGFloat colunmHeight = [self.columnHeights[i] doubleValue];
        if (colunmHeight > maxHeight) {
            maxHeight = colunmHeight;
        }
    }
    return CGSizeMake(0, maxHeight + self.wEdgeInsets.bottom);
}

#pragma mark - GET
- (NSInteger)columCount {
    if (self.waterFlowLayoutDelegate && [self.waterFlowLayoutDelegate respondsToSelector:@selector(numberOfColumsInLayout:)]) {
        return [self.waterFlowLayoutDelegate numberOfColumsInLayout:self];
    }else {
        if (!_columCount) {
            _columCount = defaultColumCount;
        }
        return _columCount;
    }
}
- (CGFloat)columMargin {
    if (self.waterFlowLayoutDelegate && [self.waterFlowLayoutDelegate respondsToSelector:@selector(columMarginInLayout:)]) {
        return [self.waterFlowLayoutDelegate columMarginInLayout:self];
    }else {
        if (!_columMargin) {
            _columMargin = defaultColumMargin;
        }
        return _columMargin;
    }
    
}
- (CGFloat)rowMargin {

    if (self.waterFlowLayoutDelegate && [self.waterFlowLayoutDelegate respondsToSelector:@selector(rowMarginInLayout:)]) {
        return [self.waterFlowLayoutDelegate rowMarginInLayout:self];
    }else {
        if (!_rowMargin) {
            _rowMargin = defaultRowMargin;
        }
        return _rowMargin;
    }
    
}
- (UIEdgeInsets)wEdgeInsets {
    if (self.waterFlowLayoutDelegate && [self.waterFlowLayoutDelegate respondsToSelector:@selector(edgeInsetsInLayout:)]) {
        return [self.waterFlowLayoutDelegate edgeInsetsInLayout:self];
    }else {
        NSString *insetsString = NSStringFromUIEdgeInsets(_wEdgeInsets);
        if (!insetsString) {
            _wEdgeInsets = defaultEdgeInsets;
        }
        return _wEdgeInsets;
    }
}

@end
