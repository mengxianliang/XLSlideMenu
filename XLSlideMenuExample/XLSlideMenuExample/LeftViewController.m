//
//  LeftViewController.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "LeftViewController.h"
#import "XLSlideMenu.h"
@interface LeftViewController () {
    UIImageView *_imageView;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QQLeftMenu"]];
    _imageView.frame = self.view.bounds;
    [self.view addSubview:_imageView];
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
