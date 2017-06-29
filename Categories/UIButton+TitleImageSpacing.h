//
//  UIButton+TitleImageSpacing.h
//  YjyxTeacher
//
//  Created by 刘少昌 on 2017/6/14.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SLButtonEdgeInsetsStyle{
    SLButtonEdgeInsetsStyleTop,// image在上
    SLButtonEdgeInsetsStyleLeft,// image在左
    SLButtonEdgeInsetsStyleBottom,// image在下
    SLButtonEdgeInsetsStyleRight// image在右
}SLButtonEdgeInsetsStyle;

@interface UIButton (TitleImageSpacing)

/**
 * 设置button的titleLabel和imageView的布局样式，及间距
 *
 * @param style titleLabel和imageView的布局样式
 * @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(SLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
