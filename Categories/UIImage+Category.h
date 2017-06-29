//
//  UIImage+Category.h
//  YjyxTeacher
//
//  Created by Yun Chen on 2016/12/7.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (category)

/**
 * 通过颜色和大小生成纯色图片
 * @param       color 图片的颜色
 * @param       bounds 图片大小
 * @returned    纯色图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size;

/**
 * 拍摄图片压缩后进行旋转处理
 * @param       iWidth 缩放适应的宽度
 * @param       isClip 超过宽度是否裁剪
 * @returned    纯色图片
 */
- (UIImage *)scaleSuit:(CGFloat)iWidth clip:(BOOL)isClip;

/**
 * 图片圆角
 * @param       radius 圆角半径
 * @returned    圆角图片
 */
- (UIImage *)pruning:(float)radius;

/**
 * 生成图片的遮罩图片
 * @returned    添加遮罩后的图片
 */
- (UIImage *)maskImage;

/**
 * 图片等比缩放
 * @param       size 缩放的相对大小
 * @returned    缩放后的图片
 */
- (UIImage*)zoom:(CGSize)size;

/** 
 * 图片压缩
 * @param       compressionSize 缩放的比例(0~1)
 * @param       compressionQuality 压缩系数(0~1)
 * @returned    压缩后的图片
 */
- (UIImage *)zoom:(CGFloat)compressionSize compressionQuality:(CGFloat)compressionQuality;

/**
 * 图片裁剪
 * @param       size 裁剪后图片大小
 * @param       rect 裁剪区域
 * @returned    裁剪后的图片
 */
- (UIImage*)trim:(CGSize)size inRect:(CGRect)rect;

/**
 * 图片玻璃效果
 * @param       radius圆角
 * @param       iterations阴影长度
 * @param       tintColor模糊效果颜色
 * @returned    玻璃效果处理后的图片
 */
- (UIImage *)blurredWithRadius:(CGFloat)radius
                    iterations:(NSUInteger)iterations
                     tintColor:(UIColor *)tintColor;

/**
 * 图片圆角
 * @param       处理图片
 * @returned    转正后的图片
 */
- (UIImage *)fixOrientation;

@end
