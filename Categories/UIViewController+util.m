//
//  UIViewController+util.m
//  IM
//
//  Created by 王越 on 15/9/7.
//  Copyright © 2015年 VRV. All rights reserved.
//

#import "UIViewController+util.h"


@implementation UIViewController (util)

- (void)loadBackBtn{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(-3, -16, 0, 0);
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"nav_btn_back_black"] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem; 
}

- (void)goBack
{
    [self.view hideKeyboard];
    [APP_WINDOW hideToastActivity];
    if ([self.navigationController popViewControllerAnimated:YES] == nil) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end


@implementation NavRootViewController
-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    NavRootViewController* nvc = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.delegate = (id)self;
    nvc.delegate = (id)self;
    return nvc;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController); //the most important
    }
    return YES;
}

@end
