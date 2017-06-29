//
//  StuOneQuestionViewController.m
//  YjyxTeacher
//
//  Created by liushaochang on 2016/12/16.
//  Copyright © 2016年 YJYX. All rights reserved.
//

#import "StuOneQuestionViewController.h"

@interface StuOneQuestionViewController ()<UITableViewDelegate, UITableViewDataSource,DTCoreTextCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation StuOneQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;
}

#pragma mark - DTCoreTextCellDelegate
- (void)cellHeightDidChange:(CGFloat)height indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {

    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
