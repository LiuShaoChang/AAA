//
//  SLAlertView.m
//  Yjyx
//
//  Created by liushaochang on 2016/10/10.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "SLAlertView.h"

@interface SLAlertView ()


@property (weak, nonatomic) IBOutlet UIView *verticalLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet UIView *alertView;

//@property (strong, nonatomic) SelectIndexBlock selectBlock;

@end

@implementation SLAlertView


+ (SLAlertView *)alertView{

    static SLAlertView *alert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alert = [[[NSBundle mainBundle] loadNibNamed:@"SLAlertView" owner:nil options:nil] firstObject];
        // 默认样式
        alert.titleLabel.text = @"温馨提示:";
        alert.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        // message
        alert.messageLabel.text = @"您需要开通会员才能观看视频解析和文字讲解!";
        
        // description
        alert.descriptionLabel.text = @"(开通后,您与所开通的孩子共享会员功能)";
    });
    
    return alert;
}


+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message{


    static SLAlertView *alert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alert = [[[NSBundle mainBundle] loadNibNamed:@"SLAlertView" owner:nil options:nil] firstObject];
     

    });
    // 默认样式
    alert.titleLabel.text = title;
    alert.titleLabel.textAlignment = NSTextAlignmentCenter;
    //        [alert.titleLabel sizeToFit];
    // message
    alert.messageLabel.text = message;
    
    // description
    alert.descriptionLabel.text = nil;
    return alert;

}

- (void)selectClick:(SelectIndexBlock)block{

    _selectBlock = block;
}



- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.frame = [UIScreen mainScreen].bounds;
    self.alertView.layer.opacity = 0.5f;
    self.alertView.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.0);
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.alertView.layer.opacity = 1.0f;
        self.alertView.layer.transform = CATransform3DMakeScale(1.0f, 1.0f, 1.0);
    } completion:NULL];
    
}

- (void)dismiss {
    
    [self removeFromSuperview];
}

- (IBAction)cancelBtnClick:(UIButton *)sender {

    sender.tag = 0;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:buttonIndex:)]) {
        [self.delegate alertView:self buttonIndex:sender.tag];
    }
    if (_selectBlock) {
        _selectBlock(sender.tag);
    }
    [self dismiss];
}

- (IBAction)yesBtnClick:(UIButton *)sender {
    sender.tag = 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:buttonIndex:)]) {
        [self.delegate alertView:self buttonIndex:sender.tag];
    }
    if (_selectBlock) {
        _selectBlock(sender.tag);
    }
    
    [self dismiss];
    
}


- (void)setYesButtonFont:(UIFont *)yesButtonFont{
    
    _yesButtonFont = yesButtonFont;
    
    self.yesButton.titleLabel.font = yesButtonFont;
   
}

- (void)setCancelButtonFont:(UIFont *)cancelButtonFont{
    
    _cancelButtonFont = cancelButtonFont;
    
    self.cancelButton.titleLabel.font = cancelButtonFont;

}

- (void)setCancelButtonColor:(UIColor *)cancelButtonColor{

    _cancelButtonColor = cancelButtonColor;
    [self.cancelButton setTitleColor:cancelButtonColor forState:UIControlStateNormal];
}

- (void)setYesButtonColor:(UIColor *)yesButtonColor{
    
    _yesButtonColor = yesButtonColor;
    [self.yesButton setTitleColor:yesButtonColor forState:UIControlStateNormal];

}


- (void)setAttributedTitle:(NSMutableAttributedString *)attributedTitle{
    
    _attributedTitle = attributedTitle;
    
    self.titleLabel.attributedText = attributedTitle;

}

- (void)setAttributedMessage:(NSMutableAttributedString *)attributedMessage{
   
    _attributedMessage = attributedMessage;
    
    self.messageLabel.attributedText = attributedMessage;


}

- (void)setYesButtonTitle:(NSString *)yesButtonTitle{
    
    _yesButtonTitle = yesButtonTitle;
    
    [self.yesButton setTitle:yesButtonTitle forState:UIControlStateNormal];

}

- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle{
   
    _cancelButtonTitle =  cancelButtonTitle;
    
    [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
}


@end
