//
//  customTextView.h
//  Yjyx
//
//  Created by yjyx on 16/9/24.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UITextView
/**
 Set textView's placeholder text. Default is nil.
 */
@property(nullable, nonatomic,copy)   NSString*placeholder;

@property(nullable, nonatomic,strong) UILabel *placeHolderLabel;

@end
