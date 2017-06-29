//
//  NoEmojiTextField.m
//  YjyxTeacher
//
//  Created by Yun Chen on 2016/11/22.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import "NoEmojiTextField.h"

@implementation NoEmojiTextField

static NSString *const kCommonCharacters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz0123456789.@+-(),_#%|?/<>~";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customedInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customedInit];
    }
    return self;
}

- (void)customedInit {
    [self addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
}

-(void) editingChanged:(id)sender {
    NSString *textWithoutEmoji = [self filterEmojis:self.text];
    if (![textWithoutEmoji isEqualToString:self.text]) {
        self.text = textWithoutEmoji;
        [[self getTopSuperviewOfView:self] makeToast:@"不能添加表情符号" duration:1.0 position:SHOW_CENTER complete:nil];
    }
    
    if (self.limitsChinese) {
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:kCommonCharacters] invertedSet];
        
        NSString *filtered = [[self.text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        BOOL canChange = [self.text isEqualToString:filtered];
        if (!canChange) {
            [[self getTopSuperviewOfView:self] makeToast:@"不能输入中文" duration:1.0 position:SHOW_CENTER complete:nil];
            self.text = previousText;
            return;
        }
    }
    previousText = self.text;
}

-(UIView *)getTopSuperviewOfView:(UIView *)view {
    if (view.superview != nil) {
        return [self getTopSuperviewOfView:view.superview];
    }
    return view;
}

- (NSString *)filterEmojis:(NSString *)string{
    __block NSString *filteredString = string;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3|| ls ==0xfe0f || ls ==0xd83c) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 filteredString = [filteredString stringByReplacingOccurrencesOfString:substring withString:@""];
             }
         }
     }];
    return filteredString;
}


@end
