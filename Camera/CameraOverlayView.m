//
//  CameraOverlayView.m
//  YjyxTeacher
//
//  Created by Yun Chen on 2017/6/14.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import "CameraOverlayView.h"

@implementation CameraOverlayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviewsCustomed {
    CGFloat centerX = self.frame.size.width / 2.0;
    self.galleryButton.center = CGPointMake(centerX, 50);
    self.takePhotoButton.center = CGPointMake(centerX, self.frame.size.height / 2.0);
    self.cancelButton.center = CGPointMake(centerX, self.frame.size.height - 50);
}

@end
