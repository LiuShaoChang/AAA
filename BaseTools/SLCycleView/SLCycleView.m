//
//  SLCycleView.m
//  YjyxTeacher
//
//  Created by liushaochang on 2016/12/15.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import "SLCycleView.h"
#import "iCarousel.h"
#import "NoticeModel.h"
#import "UIImageView+WebCache.h"
#import "NSObject+category.h"


@interface SLCycleView ()<iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) iCarousel *iCarousel;
@property (strong, nonatomic) NSArray *dataArr;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation SLCycleView


- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource {

    self = [super init];
    if (self) {
        
        // 添加子控件
        self.iCarousel = [[iCarousel alloc] initWithFrame:frame];
        self.iCarousel.type = self.cycleType;
        self.iCarousel.scrollSpeed = 6;
        self.iCarousel.pagingEnabled = YES;
        [self addSubview:self.iCarousel];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
        self.pageControl.numberOfPages = dataSource.count;
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        
        [self addSubview:self.pageControl];
        
        self.dataArr = dataSource;
        
        [self addTimer];
        
        
        
    }
    return self;
    
}

- (void)setDataArr:(NSArray *)dataArr {

    _dataArr = dataArr;
    self.iCarousel.delegate = self;
    self.iCarousel.dataSource = self;
    [self.iCarousel reloadData];
    
}

// 定时器
- (void)addTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    //添加到runloop中
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
// 移除定时器
- (void)removeTimer {
    
    [self.timer invalidate];
}

- (void)nextImage
{
    
    NSInteger index = self.iCarousel.currentItemIndex + 1;
    if (index == _dataArr.count ) {
        index = 0;
    }
    [self.iCarousel scrollToItemAtIndex:index animated:YES];
    
}

#pragma mark - iCarousel datasource and delegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
    return self.dataArr.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    if (view == nil) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:carousel.bounds];
        NSString *urlString = _dataArr[index];
        [image sd_setImageWithURL:[NSURL URLWithString:urlString]];
        view = image;
        return view;
    }else {
        return view;
    }
    
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {

    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectAtindex:)]) {
        [self.delegate didSelectAtindex:index];
    }
    
}

- (void)carouselDidScroll:(iCarousel *)carousel {
    self.pageControl.currentPage = carousel.currentItemIndex;
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel {
    [self removeTimer];
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate {
    //    开启定时器
    [self addTimer];
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
