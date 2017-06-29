//
//  UIView+LineDrawing.h
//  YjyxTeacher
//
//  Created by Yun Chen on 2016/11/25.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LineDrawing)

- (void)addHorizontalLine:(CGPoint)startPoint length:(CGFloat)length lineHeight:(CGFloat)height color:(nullable UIColor *)color;
- (void)addVerticalLine:(CGPoint)startPoint length:(CGFloat)length lineWidth:(CGFloat)width color:(nullable UIColor *)color;
    
@end
