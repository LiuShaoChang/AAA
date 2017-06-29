//
//  customTextView.m
//  Yjyx
//
//  Created by yjyx on 16/9/24.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "CustomTextView.h"

@interface CustomTextView ()

-(void)refreshPlaceholder;

@end

@implementation CustomTextView


-(void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlaceholder) name:UITextViewTextDidChangeNotification object:self];
   
}


    
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

-(void)refreshPlaceholder
{
    if([[self text] length])
    {
        [self.placeHolderLabel setAlpha:0];
    }
    else
    {
        [self.placeHolderLabel setAlpha:1];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self refreshPlaceholder];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = self.font;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.placeHolderLabel sizeToFit];
    self.placeHolderLabel.frame = CGRectMake(4, 8, CGRectGetWidth(self.frame)-16, CGRectGetHeight(self.placeHolderLabel.frame));
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    if ( self.placeHolderLabel == nil )
    {
        self.placeHolderLabel = [[UILabel alloc] init];
        self.placeHolderLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        self.placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.placeHolderLabel.numberOfLines = 0;
        self.placeHolderLabel.font = self.font;
        self.placeHolderLabel.backgroundColor = [UIColor clearColor];
        self.placeHolderLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        self.placeHolderLabel.alpha = 0;
        [self addSubview:self.placeHolderLabel];
    }
    
    self.placeHolderLabel.text = self.placeholder;
    [self refreshPlaceholder];
}

//When any text changes on textField, the delegate getter is called. At this time we refresh the textView's placeholder
-(id<UITextViewDelegate>)delegate
{
    [self refreshPlaceholder];
    return [super delegate];
}



@end
