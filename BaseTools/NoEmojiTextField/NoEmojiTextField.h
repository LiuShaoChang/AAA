//
//  NoEmojiTextField.h
//  YjyxTeacher
//
//  Created by Yun Chen on 2016/11/22.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoEmojiTextField : UITextField {
    NSString *previousText;
}

@property (nonatomic,assign) BOOL limitsChinese;

@end
