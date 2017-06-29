//
//  SLScrollView.m
//  YjyxTeacher
//
//  Created by liushaochang on 2016/12/29.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import "SLScrollView.h"
#import "YjyxDrawLine.h"

@interface SLScrollView ()


@end

@implementation SLScrollView


- (instancetype)initWithFrame:(CGRect)frame {

    if (self == [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)init {

    if (self == [super init]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    if (self == [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    
    if ([view isKindOfClass:[YjyxDrawLine class]]) {
        return NO;
    }
    return YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
