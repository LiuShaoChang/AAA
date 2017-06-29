//
//  UIView+LineDrawing.m
//  YjyxTeacher
//
//  Created by Yun Chen on 2016/11/25.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import "UIView+LineDrawing.h"

@implementation UIView (LineDrawing)

- (void)addHorizontalLine:(CGPoint)startPoint length:(CGFloat)length lineHeight:(CGFloat)height color:(UIColor *)color{
    CGRect frame = CGRectMake(startPoint.x, startPoint.y, length, height);
    [self addLineLayer:frame color:color];
}

- (void)addVerticalLine:(CGPoint)startPoint length:(CGFloat)length lineWidth:(CGFloat)width color:(UIColor *)color{
    CGRect frame = CGRectMake(startPoint.x, startPoint.y, width, length);
    [self addLineLayer:frame color:color];
}

- (void)addLineLayer:(CGRect)frame color:(UIColor *)color{
    CALayer *line = [[CALayer alloc] init];
    line.frame = frame;
    
    if (color != nil) {
        line.backgroundColor = color.CGColor;
    }
    else{
        line.backgroundColor = [UIColor lightGrayColor].CGColor;
    }
    
    [self.layer addSublayer:line];
}


@end
