//
//  CameraOverlayView.h
//  YjyxTeacher
//
//  Created by Yun Chen on 2017/6/14.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraOverlayView : UIView

@property(nonatomic,weak) IBOutlet UIButton *galleryButton;
@property(nonatomic,weak) IBOutlet UIButton *takePhotoButton;
@property(nonatomic,weak) IBOutlet UIButton *cancelButton;

- (void)layoutSubviewsCustomed;

@end
