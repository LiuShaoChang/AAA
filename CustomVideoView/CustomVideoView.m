//
//  CustomVideoView.m
//  Yjyx
//
//  Created by liushaochang on 2016/10/26.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "CustomVideoView.h"
#import "WMPlayer.h"
#import "GlobalKeys.h"

@interface CustomVideoView ()

{
    
    CGRect playerFrame;
    UIImageView *videoImage;
    UILabel *knowLabel;// 知识点
    UIButton *numButton;
    UIButton *playButton;
    CGSize size;
    UIView *bgView;// 视频序号按钮和视频名称的背景
    NSTimeInterval lastPlayingTaskInterval;
}

@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIView *playerFatherView;


@end


@implementation CustomVideoView

// 创建
+ (CustomVideoView *)videoView {

    NSError *setCategoryError = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryError]; //忽略静音按钮作用
    
    CustomVideoView *view = [[CustomVideoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    return view;

}

// 懒加载创建
- (YJZFPlayerView *)playerView {

    if (!_playerView) {
        _playerView = [[YJZFPlayerView alloc] init];
    }
    return _playerView;
}

- (ZFPlayerControlView *)controlView {

    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
        
    }
    return _controlView;
}

- (ZFPlayerModel *)playerModel {

    if (!_playerModel) {
        _playerModel = [[ZFPlayerModel alloc] init];
        _playerModel.placeholderImage = [UIImage imageNamed:@"hw_videoBg"];
        _playerModel.fatherView = self.playerFatherView;
    }
    return _playerModel;
}

- (UIView *)playerFatherView {

    if (!_playerFatherView) {
        _playerFatherView = [[UIView alloc] initWithFrame:playerFrame];
    }
    return _playerFatherView;
}

- (void)setVideoUrl:(NSString *)videoUrl
{
    _videoUrl = videoUrl;
    
}
- (void)setName:(NSString *)name
{
    _name = name;
    knowLabel.text = name;
}

// 配置视频和序号按钮
- (void)configureVideo {

    if (self.videoUrl != nil || self.videoUrl.length != 0) {
        playerFrame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH)*42/75);
        
        // 视频遮盖图
        if(videoImage == nil){
            videoImage = [[UIImageView alloc] initWithFrame:playerFrame];
            videoImage.image = [UIImage imageNamed:@"hw_videoBg"];
        }
        
        [self.playerFatherView addSubview:videoImage];
        
        // 播放按钮
         playButton.hidden = NO;
        if(playButton == nil){
            playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        [playButton setBackgroundImage:[UIImage imageNamed:@"hw_playBtn"] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        [self.playerFatherView addSubview:playButton];
        [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(videoImage);
            make.top.equalTo(videoImage.mas_top).with.offset(70);
            make.bottom.equalTo(videoImage.mas_bottom).with.offset(-70);
            make.height.mas_equalTo(playButton.mas_width).multipliedBy(1);
        }];
        [self addSubview:self.playerFatherView];
        if (bgView == nil) {
            bgView = [[UIView alloc] init];
        }
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        // 知识点视频的名字
        if (self.name.length > 0) {
            knowLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 40)];
            knowLabel.font = [UIFont systemFontOfSize:15];
            knowLabel.numberOfLines = 2;
            knowLabel.text = self.name;
            [bgView addSubview:knowLabel];
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(15, 55, SCREEN_WIDTH - 30, 1)];
            line.backgroundColor = HEXCOLOR(@"#efeff4");
            [bgView addSubview:line];
            size = CGSizeMake(10, 65);
        }else {
            size = CGSizeMake(10, 5);// 初始位置
        }

        if (self.videoUrlArr.count > 1) {
            // 多视频选择按钮

            CGFloat padding = 10;// 间距
            NSInteger num = 5;// 视频个数
            CGFloat tWidth = (SCREEN_WIDTH - 20 -(num - 1)*padding)/num;
            CGFloat tHeight = tWidth;

            for (int i = 0; i < self.videoUrlArr.count; i++) {
                CustomVideoBtn *button = [CustomVideoBtn buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(size.width, size.height, tWidth, tHeight);
                size.width += tWidth + padding;
            
                button.tag = 200 + i;
                button.tintColor = [UIColor blackColor];
                if (button.tag == 200) {
                    numButton = button;
                    button.backgroundColor = FOREGROUND_HEXCOLOR;
                    button.tintColor = [UIColor whiteColor];
                    
                }
                [button setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
                button.layer.cornerRadius = tWidth / 2;
                button.layer.masksToBounds = YES;
                button.layer.borderWidth = 1;
                button.layer.borderColor = FOREGROUND_HEXCOLOR.CGColor;
                [button addTarget:self action:@selector(microNumButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [bgView addSubview:button];
                
            }
            bgView.frame = CGRectMake(0, playerFrame.size.height, SCREEN_WIDTH, size.height + tHeight + 10);
            self.height = playerFrame.size.height + size.height + tHeight + 10;

        }else {
            bgView.frame = CGRectMake(0, playerFrame.size.height, SCREEN_WIDTH, size.height);
            self.height = playerFrame.size.height + size.height;
        }
        
        
    }
    

    
}

// 点击视频序号
- (void)microNumButtonClick:(UIButton *)sender {
    
    numButton.backgroundColor = [UIColor whiteColor];
    numButton.tintColor = [UIColor blackColor];
    numButton = sender;
    
    self.videoUrl = self.videoUrlArr[sender.tag - 200];
    
    // 防止暴力疯狂切换
    lastPlayingTaskInterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timeIntervalLocal = lastPlayingTaskInterval;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (lastPlayingTaskInterval > timeIntervalLocal) {
            NSLog(@"在狂点,只播放最后一个任务");
            return;
        }
        
        // 播放
        [self playVideo:nil];
        
    });
    
    numButton.backgroundColor = FOREGROUND_HEXCOLOR;
    numButton.tintColor = [UIColor whiteColor];
}

// 播放视频
-(void)playVideo:(UIButton *)sender
{
    // 播放
    self.playerModel.videoURL = [NSURL URLWithString:self.videoUrl];
    [self.playerView playerControlView:self.controlView playerModel:self.playerModel];
    _controlView.backBtn.hidden = YES;
    [self.playerView autoPlayTheVideo];
    
}




@end

@implementation CustomVideoBtn

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
