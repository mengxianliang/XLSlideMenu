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
    UIButton *headerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
    headerButton.layer.cornerRadius = headerButton.bounds.size.width/2.0f;
    headerButton.layer.masksToBounds = true;
    [headerButton setImage:[UIImage imageNamed:@"header"] forState:UIControlStateNormal];
    [headerButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:headerButton];
    
    //右
    UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [moreButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
    
    
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
