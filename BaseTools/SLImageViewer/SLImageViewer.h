//
//  SLImageViewer.h
//  YjyxTeacher
//
//  Created by liushaochang on 2016/12/27.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLImageViewerDelegate <NSObject>

@optional
// 滚动至第几张图片
- (void)imageViewerScrollAtIndex:(NSInteger)index;
// 保存并上传图片
- (void)saveAndUploadimage:(NSDictionary *)paintDic;

@end

@interface SLImageViewer : UIView

@property (weak, nonatomic) id<SLImageViewerDelegate> delegate;
/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;
/** 网络图片 url string 数组 */
@property (nonatomic, strong) NSArray *imageURLStringsGroup;

/** 是否支持,开启后图片将支持涂鸦*/
@property (nonatomic, assign) BOOL isCanPaint;
/** 笔刷颜色, 默认黑色 */
@property (nonatomic, strong) UIColor *paintColor;
/** 笔刷粗细，默认1.f */
@property (nonatomic, assign) CGFloat brushWidth;
/** 要显示到首张图片的位置 */
@property (nonatomic, assign) NSInteger currentIndex;

/**----------- 以下属性，如果作为轮播器，可以用到（暂时没有实现，预留，有空再添加）---------- **/

/** 自动滚动 */
@property (nonatomic, assign) BOOL autoScroll;
/** 是否显示pageContol */
@property (nonatomic, assign) BOOL isShowPageControl;
/** 是否显示文字描述 */
@property (nonatomic, assign) BOOL isShowDescription;


/** 初始化方法 */
+ (instancetype)imageViewerWithFrame:(CGRect)frame delegate:(id<SLImageViewerDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;

/** 往前滚动 */
- (void)scrollForward;

/** 往后滚动 */
- (void)scrollBack;

/** 顺时针转动 */
- (void)clockwise;

/** 撤销上一步 */
- (void)deleteLastLine;

/** 恢复撤销操作（上一步） */
- (void)recoverLastDelete;

/** 撤销所有画图 */
- (void)removeAllLine;

/** 画笔颜色等改变时调用 */
- (void)changeValue;

/** 生成图片,返回的字典的key,是图片的序号 */
- (NSMutableDictionary *)getThePaintInfo;

/** 清空保存数据 */
- (void)removeAllTheSaveDic;

@end
