//
//  CameraResultOverlayView.h
//  YjyxTeacher
//
//  Created by Yun Chen on 2017/6/15.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraResultOverlayView : UIView<UIScrollViewDelegate,UIGestureRecognizerDelegate> {
}

@property(nonatomic,weak) IBOutlet UIScrollView *photoContainerView;
@property(nonatomic,weak) IBOutlet UIImageView *photoImageView;
@property(nonatomic,weak) IBOutlet UIView *controlsContainerView;
@property(nonatomic,weak) IBOutlet UIButton *useButton;
@property(nonatomic,weak) IBOutlet UIButton *cancelButton;

- (void)layoutSubviewsCustomed;

@end
