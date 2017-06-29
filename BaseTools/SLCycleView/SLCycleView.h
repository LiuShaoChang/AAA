//
//  SLCycleView.h
//  YjyxTeacher
//
//  Created by liushaochang on 2016/12/15.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLCycleViewDelegate <NSObject>

@optional
- (void)didSelectAtindex:(NSInteger)index;

@end

@interface SLCycleView : UIView

@property (nonatomic, assign) NSInteger cycleType;
@property (nonatomic, weak) id<SLCycleViewDelegate> delegate;

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;




@end
