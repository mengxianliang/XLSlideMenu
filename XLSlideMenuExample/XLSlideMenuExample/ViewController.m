//
//  ViewController.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "ViewController.h"
#import "XLSlideMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息";
    
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    headerImageView.layer.cornerRadius = headerImageView.bounds.size.width/2.0f;
    headerImageView.layer.masksToBounds = true;
    headerImageView.image = [UIImage imageNamed:@"header"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLeft)];
    [headerImageView addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:headerImageView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showRight)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    imageView.image = [UIImage imageNamed:@"QQChatList"];
    [self.view addSubview:imageView];
}

-(void)showLeft{
    [self.xl_sldeMenu showLeftViewControllerAnimated:true];
}

-(void)showRight{
    [self.xl_sldeMenu showRightViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
