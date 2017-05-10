//
//  UIViewController+XLSlideMenu.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//  GitHub:https://github.com/mengxianliang/XLSlideMenu

#import "UIViewController+XLSlideMenu.h"
#import "XLSlideMenu.h"

@implementation UIViewController (XLSlideMenu)

-(XLSlideMenu *)xl_sldeMenu{
    UIViewController *sldeMenu = self.parentViewController;
    while (sldeMenu) {
        if ([sldeMenu isKindOfClass:[XLSlideMenu class]]) {
            return (XLSlideMenu *)sldeMenu;
        } else if (sldeMenu.parentViewController && sldeMenu.parentViewController != sldeMenu) {
            sldeMenu = sldeMenu.parentViewController;
        } else {
            sldeMenu = nil;
        }
    }
    return nil;
}


@end
