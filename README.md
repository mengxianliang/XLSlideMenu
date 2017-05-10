# XLSlideMenu

## 实现功能

- [x] 滑动显示左右菜单
- [x] 手动显示左右菜单

## 显示效果

<img src="https://github.com/mengxianliang/XLSlideMenu/blob/master/GIF/1.gif" width=300 height=538 />

## 使用方法

### 1、创建方法：

#### (1)、导入头文件：

```objc
#import "XLSlideMenu.h"
```

#### (2)、创建菜单并设置成window的rootviewControler

```objc
XLSlideMenu *slideMenu = [[XLSlideMenu alloc] initWithRootViewController:rootNav];
//设置左右菜单
slideMenu.leftViewController = leftVC;
slideMenu.rightViewController = rightVC;
self.window.rootViewController = slideMenu;
```

### 2、使用方法：

#### (1)、显示左菜单

```objc
[self.xl_sldeMenu showLeftViewControllerAnimated:true];
```

#### (2)、显示右菜单

```objc
[self.xl_sldeMenu showRightViewControllerAnimated:true];
```

#### (3)、显示主界面

```objc
[self.xl_sldeMenu showRootViewControllerAnimated:true];
```

#### (4)、获取菜单宽度

```objc
self.xl_sldeMenu.menuWidth
```

#### (5)、获取留白宽度

```objc
self.xl_sldeMenu.emptyWidth
```

#### (6)、关闭滑动功能

```objc
self.xl_sldeMenu.slideEnabled = false;
```

#### (7)、跳转新界面

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
