//
//  AppDelegate.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "XLSlideMenu.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //主界面
    ViewController *vc = [[ViewController alloc] init];
    //配置NavigationBar
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [rootNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackImage"] forBarMetrics:UIBarMetricsDefault];
    rootNav.navigationBar.tintColor = [UIColor whiteColor];
    [rootNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    //左侧菜单
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    //右侧菜单
    RightViewController *rightVC = [[RightViewController alloc] init];
    //创建滑动菜单
    XLSlideMenu *slideMenu = [[XLSlideMenu alloc] initWithRootViewController:rootNav];
    //设置左右菜单
    slideMenu.leftViewController = leftVC;
    slideMenu.rightViewController = rightVC;
    self.window.rootViewController = slideMenu;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
