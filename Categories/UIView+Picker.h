//
//  UIView+Picker.h
//  YjyxTeacher
//
//  Created by Yun Chen on 2016/11/29.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionSheetPicker.h"

@interface UIView (Picker)

//其他字符串选择器
- (void)showPickerWithTitle:(NSString *)title rows:(NSArray *)strings initialSelection:(NSInteger)index doneBlock:(ActionStringDoneBlock)doneBlock cancelBlock:(ActionStringCancelBlock)cancelBlock;


//日期选择器
- (void)showDatePickerWithTitle:(NSString *)title
datePickerMode:(UIDatePickerMode)datePickerMode
selectedDate:(NSDate *)selectedDate
doneBlock:(ActionDateDoneBlock)doneBlock
cancelBlock:(ActionDateCancelBlock)cancelBlock;



@end
