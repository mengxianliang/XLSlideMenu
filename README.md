# XLSlideMenu

## 实现功能

- [x] 滑动显示左右菜单（支持快速滑动）
- [x] 调用方法显示左右菜单
- [x] 支持UINavigationController、UItabbarController，即UIViewController及其子类作为Window的根控制器
- [x] 滑动区域为界面两侧，不会和界面中的滚动视图发生冲突，并可自定义相应区域大小
- [x] 滑动只在NavigationController的个控制器显示时才会触发，其他自控制器不会触发菜单滑动方法

## 显示效果

*示例图中的QQ界面只是截图*

<img src="https://github.com/mengxianliang/XLSlideMenu/blob/master/GIF/1.gif" width=300 height=538 />

## 使用方法

### 1、创建方法：

#### （1）、导入头文件：

```objc
#import "XLSlideMenu.h"
```

#### （2）、创建菜单并设置成window的rootviewControler

```objc
XLSlideMenu *slideMenu = [[XLSlideMenu alloc] initWithRootViewController:rootNav];
//设置左右菜单
slideMenu.leftViewController = leftVC;
slideMenu.rightViewController = rightVC;
self.window.rootViewController = slideMenu;
```

### 2、使用方法：

#### （1）、显示左菜单

```objc
[self.xl_sldeMenu showLeftViewControllerAnimated:true];
```

#### （2）、显示右菜单

```objc
[self.xl_sldeMenu showRightViewControllerAnimated:true];
```

#### （3）、显示主界面

```objc
[self.xl_sldeMenu showRootViewControllerAnimated:true];
```

#### （4）、获取菜单宽度

```objc
self.xl_sldeMenu.menuWidth
```

#### （5）、获取留白宽度

```objc
self.xl_sldeMenu.emptyWidth
```

#### （6）、关闭滑动功能

```objc
self.xl_sldeMenu.slideEnabled = false;
```

#### （7）、跳转新界面

* 判断RootViewController类型

* 第一种情况：如果是UINavigationController就直接push

```objc
UINavigationController *nav = (UINavigationController *)self.xl_sldeMenu.rootViewController;
[nav pushViewController:newVc animated:false];
```

* 第二种情况：如果是Tabbar就找到Tabbar的selectedViewController执行Push动作

```objc
UITabBarController *tabBarController = (UITabBarController *)self.xl_sldeMenu.rootViewController;
UINavigationController *nav = (UINavigationController *)tabBarController.selectedViewController;
[nav pushViewController:newVc animated:true];
```

### 个人开发过的UI工具集合 [XLUIKit](https://github.com/mengxianliang/XLUIKit)
