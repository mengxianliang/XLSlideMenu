//
//  XLSlideMenu.h
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XLSlideDirection){
    XLSlideDirectionNone = 0,
    XLSlideDirectionLeft = 1,
    XLSlideDirectionRight = 2,
};

@interface XLSlideMenu : UIViewController
//主视图
@property (nonatomic, strong) UIViewController *rootViewController;
//左侧视图
@property (nonatomic, strong) UIViewController *leftViewController;
//右侧视图
@property (nonatomic, strong) UIViewController *rightViewController;

//创建方法
-(instancetype)initWithRootViewController:(UIViewController*)rootViewController;

//显示主视图
-(void)showRootViewController;
//显示左侧菜单
-(void)showLeftViewController;
//显示右侧菜单
-(void)showRightViewController;

@end
