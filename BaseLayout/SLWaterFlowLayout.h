//
//  SLWaterFlowLayout.h
//  WaterFlowTest
//
//  Created by liushaochang on 2017/6/27.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

// 仿照UICollectionViewFlowLayout写的瀑布流

@class SLWaterFlowLayout;
@protocol SLWaterFlowLayoutDelegate <NSObject>

@required
// cell高度
- (CGFloat)flowLayout:(SLWaterFlowLayout *)flowLayout heightForRowAtIndex:(NSInteger)index itemWidth:(CGFloat)width;

@optional
// 返回多少列
- (NSInteger)numberOfColumsInLayout:(SLWaterFlowLayout *)flowLayout;
// cell列间距
- (CGFloat)columMarginInLayout:(SLWaterFlowLayout *)flowLayout;
// cell行间距
- (CGFloat)rowMarginInLayout:(SLWaterFlowLayout *)flowLayout;
// 边缘距离
- (UIEdgeInsets)edgeInsetsInLayout:(SLWaterFlowLayout *)flowLayout;



@end


@interface SLWaterFlowLayout : UICollectionViewLayout

@property (weak, nonatomic) id<SLWaterFlowLayoutDelegate> waterFlowLayoutDelegate;

@property (assign, nonatomic) NSInteger columCount;
@property (assign, nonatomic) CGFloat columMargin;
@property (assign, nonatomic) CGFloat rowMargin;
@property (assign, nonatomic) UIEdgeInsets wEdgeInsets;


@end
