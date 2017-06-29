//
//  UIFont+Setting.m
//  YjyxStudent
//
//  Created by 刘少昌 on 2017/6/13.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import "UIFont+Setting.h"

@implementation UIFont (Setting)


/** 设置平方字体 */
+ (UIFont *)fontWithPingFang:(PingFang_Type)PingFang_Type Size:(CGFloat)size {

    UIFont *font;
    if (SYS_VERSION >= 8.2) {
        switch (PingFang_Type) {
            case PingFang_SC_Regular:
                font = [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
                break;
            case PingFang_SC_Medium:
                font = [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
                break;
            case PingFang_SC_Bold:// pingfang没有bold样式,采用系统字体样式
                font = [UIFont systemFontOfSize:size weight:UIFontWeightBold];
                break;
            default:
                break;
        }

    }else {
        font = [UIFont systemFontOfSize:size];
    }
    
    return font;
}

@end
