//
//  CameraResultOverlayView.m
//  YjyxTeacher
//
//  Created by Yun Chen on 2017/6/15.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import "CameraResultOverlayView.h"

@implementation CameraResultOverlayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviewsCustomed {
    float aspectRatio = 4.0 / 3.0;
    float cameraWidthLandscape = floorf(self.frame.size.height * aspectRatio);
    
    self.photoContainerView.frame = CGRectMake(0, 0, cameraWidthLandscape, self.frame.size.height);
    self.photoImageView.frame = self.photoContainerView.bounds;
    self.controlsContainerView.frame = CGRectMake(cameraWidthLandscape, 0, self.frame.size.width - cameraWidthLandscape, self.frame.size.height);
    
    CGFloat centerX = self.controlsContainerView.frame.size.width / 2.0;
    self.useButton.center = CGPointMake(centerX, 50);
    self.cancelButton.center = CGPointMake(centerX, self.controlsContainerView.frame.size.height - 50);
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.photoImageView;
}

@end
