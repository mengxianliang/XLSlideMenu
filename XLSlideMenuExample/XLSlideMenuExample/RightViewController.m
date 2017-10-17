//
//  RightViewController.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//  GitHub:https://github.com/mengxianliang/XLSlideMenu

#import "RightViewController.h"
#import "XLSlideMenu.h"

@interface RightViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;;
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Tips";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self titles].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [self titles][indexPath.row];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:3/255.0f green:102/255.0f blue:214/255.0f alpha:1];
    cell.detailTextLabel.text = [self subTitles][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.xl_sldeMenu showRootViewControllerAnimated:true];
            break;
        case 1:
            [self.xl_sldeMenu showLeftViewControllerAnimated:true];
            break;
        case 2:
            [self.xl_sldeMenu showRightViewControllerAnimated:true];
            break;
        case 3: {
            [self.xl_sldeMenu showRootViewControllerAnimated:true];
            UIViewController *vc = [[UIViewController alloc] init];
            vc.title = @"新界面";
            vc.view.backgroundColor = [UIColor whiteColor];
            UINavigationController *nav = (UINavigationController *)self.xl_sldeMenu.rootViewController;
            [nav pushViewController:vc animated:true];
        }
            break;
        case 4:
            self.xl_sldeMenu.slideEnabled = !self.xl_sldeMenu.slideEnabled;
            [tableView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (NSArray *)titles {
    return @[@"显示主界面",@"显示左菜单",@"显示右菜单",@"Push新界面",@"设置滑动开关"];
}

- (NSArray *)subTitles {
    NSString *subTitle = self.xl_sldeMenu.slideEnabled ? @"(已打开)" : @"(已关闭)" ;
    return @[@"",@"",@"",@"",subTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
