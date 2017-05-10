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
    
    //左
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
    headerImageView.layer.cornerRadius = headerImageView.bounds.size.width/2.0f;
    headerImageView.layer.masksToBounds = true;
    headerImageView.image = [UIImage imageNamed:@"header"];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLeft)];
    [headerImageView addGestureRecognizer:tap1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:headerImageView];
    
    //右
    UIImageView *moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    moreImageView.image = [UIImage imageNamed:@"more"];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRight)];
    [moreImageView addGestureRecognizer:tap2];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreImageView];
    
    
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
