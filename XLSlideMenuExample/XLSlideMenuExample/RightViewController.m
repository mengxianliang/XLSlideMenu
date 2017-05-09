//
//  RightViewController.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "RightViewController.h"
#import "XLSlideMenu.h"

@interface RightViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildTable];
}

-(void)buildTable
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.xl_sldeMenu.emptyWidth, 0, self.xl_sldeMenu.menuWidth, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"点击跳转新视图";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor purpleColor];
    vc.title = @"测试视图";
    UINavigationController *nav = (UINavigationController*)self.xl_sldeMenu.rootViewController;
    [nav pushViewController:vc animated:false];
    [self.xl_sldeMenu showRootViewControllerAnimated:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
