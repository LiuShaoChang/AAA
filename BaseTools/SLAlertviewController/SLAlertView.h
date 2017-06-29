//
//  SLAlertView.h
//  Yjyx
//
//  Created by liushaochang on 2016/10/10.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

// ***************使*用*说*明****************
// 自定义警示框
// 该警示框分为标题(title),信息(message),说明(description),按钮事件(button)四部分
// 类方法创建
// 如果想修改title,message,description,button上的字体样式,颜色,大小等,直接修改对象属性即可
//

#import <UIKit/UIKit.h>
typedef void (^SelectIndexBlock)(NSInteger index);

@class SLAlertView;

@protocol SLAlertViewDelegate <NSObject>

- (void)alertView:(SLAlertView *)alertView buttonIndex:(NSInteger)buttonIndex;

@end

@interface SLAlertView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;


@property(strong,nonatomic)UIFont *cancelButtonFont;

@property(strong,nonatomic)UIFont *yesButtonFont;

@property(strong,nonatomic)UIColor *cancelButtonColor;

@property(nonatomic,strong)UIColor *yesButtonColor;

@property(nonatomic,copy)NSString *cancelButtonTitle;

@property(nonatomic,copy)NSString *yesButtonTitle;

@property (weak, nonatomic) id<SLAlertViewDelegate> delegate;
@property (copy, nonatomic) SelectIndexBlock selectBlock;

@property(strong, nonatomic)NSMutableAttributedString *attributedTitle;

@property(strong, nonatomic)NSMutableAttributedString *attributedMessage;


/**
 * 初始化方法
 */
+ (SLAlertView *)alertView;


+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message;


//点击按钮回调
- (void)selectClick:(SelectIndexBlock)block;


/**
 * 弹出
 */
- (void)show;

/**
 * 消失
 */
- (void)dismiss;



@end
