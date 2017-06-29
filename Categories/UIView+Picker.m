//
//  UIView+Picker.m
//  YjyxTeacher
//
//  Created by Yun Chen on 2016/11/29.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import "UIView+Picker.h"
#import "UIView+LineDrawing.h"

@implementation UIView (Picker)

//字符串选择器
- (void)showPickerWithTitle:(NSString *)title rows:(NSArray *)strings initialSelection:(NSInteger)index doneBlock:(ActionStringDoneBlock)doneBlock cancelBlock:(ActionStringCancelBlock)cancelBlock {
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:title rows:strings initialSelection:index doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        doneBlock(picker, selectedIndex, selectedValue);
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        cancelBlock(picker);
    } origin:self];
    
    [self customPickerBeforeShowing:picker];
    [picker showActionSheetPicker];
    [self customPickerAfterShowing:picker];
}

//日期选择器
- (void)showDatePickerWithTitle:(NSString *)title
                 datePickerMode:(UIDatePickerMode)datePickerMode
                   selectedDate:(NSDate *)selectedDate
                      doneBlock:(ActionDateDoneBlock)doneBlock
                    cancelBlock:(ActionDateCancelBlock)cancelBlock{
    
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        doneBlock(datePicker,selectedDate,self);
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        cancelBlock(datePicker);
    } origin:self];
    
    [self customPickerBeforeShowing:datePicker];
    [datePicker showActionSheetPicker];
    [self customPickerAfterShowing:datePicker];
}



- (void)customPickerBeforeShowing:(AbstractActionSheetPicker *)picker {
    picker.toolbarBackgroundColor = LIGHT_GRAY_BAR_BACKGROUND_COLOR;
    picker.pickerBackgroundColor = [UIColor whiteColor];
    NSMutableParagraphStyle *labelParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    labelParagraphStyle.alignment = NSTextAlignmentCenter;
    picker.pickerTextAttributes = [NSMutableDictionary dictionaryWithDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:21],NSParagraphStyleAttributeName:labelParagraphStyle}];
    
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] init];
    doneButtonItem.title = @"完成";
    doneButtonItem.tintColor = TEACHERCOLOR;
    [picker setDoneButton:doneButtonItem];
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] init];
    cancelButtonItem.title = @"取消";
    cancelButtonItem.tintColor = DARK_GRAY_TEXT_COLOR;
    [picker setCancelButton:cancelButtonItem];
}

- (void)customPickerAfterShowing:(AbstractActionSheetPicker *)picker {
    [picker.pickerView addHorizontalLine:CGPointMake(0.0, 2.0) length:picker.pickerView.frame.size.width lineHeight:1.0 color:LIGHT_GRAY_LINE_COLOR];
}

@end
