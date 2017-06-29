//
//  YjyxDrawLine.m
//  Yjyx
//
//  Created by liushaochang on 16/7/15.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "YjyxDrawLine.h"
#import "YjyxDrawlineInfo.h"

@implementation YjyxDrawLine

#pragma mark - init
static YjyxDrawLine *drawLine = nil;
+ (YjyxDrawLine *)defaultLine {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        drawLine = [[YjyxDrawLine alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
        
        drawLine.allMyDrawPaletteLineInfos = [[NSMutableArray alloc] initWithCapacity:10];
        drawLine.tempInfos = [NSMutableArray array];
        drawLine.currentPaintBrushColor = [UIColor blackColor];
        drawLine.backgroundColor = [UIColor clearColor];
        drawLine.currentPaintBrushWidth = 2.f;

    });
    
    return drawLine;

}

+ (instancetype)defaultLineWithFrame:(CGRect)frame {

    drawLine = [[YjyxDrawLine alloc] initWithFrame:frame];
    drawLine.allMyDrawPaletteLineInfos = [[NSMutableArray alloc] initWithCapacity:10];
    drawLine.tempInfos = [NSMutableArray array];
    drawLine.currentPaintBrushColor = [UIColor blackColor];
    drawLine.alpha = 0.7;
    drawLine.backgroundColor = [UIColor clearColor];
    drawLine.currentPaintBrushWidth = 0.8f;

    return drawLine;
    
}


#pragma  mark - draw event
//根据现有的线条 绘制相应的图画
- (void)drawRect:(CGRect)rect  {
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    if (_allMyDrawPaletteLineInfos.count>0) {
        for (int i=0; i<[self.allMyDrawPaletteLineInfos count]; i++) {
            YjyxDrawlineInfo *info = self.allMyDrawPaletteLineInfos[i];
            
            CGContextBeginPath(context);
            CGPoint myStartPoint=[[info.linePoints objectAtIndex:0] CGPointValue];
            CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
            
            if (info.linePoints.count>1) {
                for (int j=0; j<[info.linePoints count]-1; j++) {
                    CGPoint myEndPoint=[[info.linePoints objectAtIndex:j+1] CGPointValue];
                    CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
                }
            }else {
                CGContextAddLineToPoint(context, myStartPoint.x,myStartPoint.y);
            }
            CGContextSetStrokeColorWithColor(context, info.lineColor.CGColor);
            CGContextSetLineWidth(context, info.lineWidth+1);
            CGContextStrokePath(context);
        }
    }
}


#pragma mark draw info edite event
//在触摸开始的时候 添加一条新的线条 并初始化
- (void)drawPaletteTouchesBeganWithWidth:(float)width andColor:(UIColor *)color andBeginPoint:(CGPoint)bPoint {
    YjyxDrawlineInfo *info = [YjyxDrawlineInfo new];
    info.lineColor = color;
    info.lineWidth = width;
    
    [info.linePoints addObject:[NSValue valueWithCGPoint:bPoint]];
    
    [self.allMyDrawPaletteLineInfos addObject:info];
    self.num = self.allMyDrawPaletteLineInfos.count;
}

//在触摸移动的时候 将现有的线条的最后一条的 point增加相应的触摸过的坐标
- (void)drawPaletteTouchesMovedWithPonit:(CGPoint)mPoint {
    YjyxDrawlineInfo *lastInfo = [self.allMyDrawPaletteLineInfos lastObject];
    [lastInfo.linePoints addObject:[NSValue valueWithCGPoint:mPoint]];
    self.num = self.allMyDrawPaletteLineInfos.count;

}

// 清空
- (void)cleanAllDrawBySelf {
    if ([self.allMyDrawPaletteLineInfos count]>0)  {
        [self.allMyDrawPaletteLineInfos removeAllObjects];
        self.num = self.allMyDrawPaletteLineInfos.count;

        [self setNeedsDisplay];
    }
}

// 撤销上一步
- (void)cleanFinallyDraw {
    if ([self.allMyDrawPaletteLineInfos count]>0) {
        [self.tempInfos addObject:self.allMyDrawPaletteLineInfos.lastObject];
        [self.allMyDrawPaletteLineInfos  removeLastObject];
        self.num = self.allMyDrawPaletteLineInfos.count;

    }
    [self setNeedsDisplay];
}

// 恢复上一步
- (void)recoverFinalDraw {

    if ([self.tempInfos count] > 0) {
        [self.allMyDrawPaletteLineInfos addObject:self.tempInfos.lastObject];
        [self.tempInfos removeLastObject];
        self.num = self.allMyDrawPaletteLineInfos.count;

    }
    [self setNeedsDisplay];
}


#pragma mark - touch event
//触摸开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch=[touches anyObject];
    [self drawPaletteTouchesBeganWithWidth:self.currentPaintBrushWidth andColor:self.currentPaintBrushColor andBeginPoint:[touch locationInView:self ]];
    [self setNeedsDisplay];
    
}
//触摸移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray* MovePointArray=[touches allObjects];
    [self drawPaletteTouchesMovedWithPonit:[[MovePointArray objectAtIndex:0] locationInView:self]];
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
