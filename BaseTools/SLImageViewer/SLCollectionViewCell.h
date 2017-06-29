//
//  SLCollectionViewCell.h
//  YjyxTeacher
//
//  Created by liushaochang on 2016/12/27.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLScrollView.h"
@class YjyxDrawLine;

@interface SLCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (assign, nonatomic) CGFloat WIDTH;
@property (assign, nonatomic) CGFloat HEIGHT;
@property (assign, nonatomic) CGFloat currentScale;
@property (weak, nonatomic) IBOutlet SLScrollView *scrolBgView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIColor *paintColor;//笔刷颜色
@property (assign, nonatomic) CGFloat brushWidth;//笔刷粗细
@property (strong, nonatomic) YjyxDrawLine *drawLine;

- (void)setSubivewsWithDrawImage:(UIImage *)image;

/** 撤销上一步 */
- (void)deleteLastLine;
/** 恢复撤销操作（上一步） */
- (void)recoverLastDelete;
/** 撤销所有画图 */
- (void)removeAllLine;

@end
