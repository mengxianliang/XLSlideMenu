//
//  RightViewController.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "RightViewController.h"
#import "UIViewController+XLSlideMenu.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.xl_sldeMenu.emptyWidth, 0, self.xl_sldeMenu.menuWidth, self.view.bounds.size.height)];
    imageView.image = [UIImage imageNamed:@"QQLeftMenu"];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
