//
//  CustomVideoView.h
//  Yjyx
//
//  Created by liushaochang on 2016/10/26.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZFPlayer.h"
#import "YJZFPlayerView.h"
@interface CustomVideoView : UIView


@property (nonatomic, strong) NSString *videoUrl;// 播放连接
@property (nonatomic, strong) NSMutableArray *videoUrlArr;// 多视频连接
@property (nonatomic, strong) NSString *name;// 知识点
@property (nonatomic, assign) CGFloat height;// 总高度
@property (nonatomic, strong) YJZFPlayerView *playerView;


+ (CustomVideoView *)videoView;

- (void)configureVideo;


@end
@interface CustomVideoBtn : UIButton

@end
