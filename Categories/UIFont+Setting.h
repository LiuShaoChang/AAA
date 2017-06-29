//
//  UIFont+Setting.h
//  YjyxStudent
//
//  Created by 刘少昌 on 2017/6/13.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum PingFang_Type {

    PingFang_SC_Regular,
    PingFang_SC_Medium,
    PingFang_SC_Bold
}PingFang_Type;

@interface UIFont (Setting)

/** 设置平方字体 */
+ (UIFont *)fontWithPingFang:(PingFang_Type)PingFang_Type Size:(CGFloat)size;


@end
