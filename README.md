# XLSlideMenu

## 实现功能

- [x] 滑动显示左右菜单
- [x] 手动显示左右菜单

## 显示效果

![image](https://github.com/mengxianliang/XLSlideMenu/blob/master/GIF/1.gif)

## 使用方法

### 1、创建方法：

#### 导入头文件：

```objc
#import "XLSlideMenu.h"
```

#### 创建菜单并设置成window的rootviewControler

```objc
    //创建滑动菜单
    XLSlideMenu *slideMenu = [[XLSlideMenu alloc] initWithRootViewController:rootNav];
    //设置左右菜单
    slideMenu.leftViewController = leftVC;
    slideMenu.rightViewController = rightVC;
    self.window.rootViewController = slideMenu;
```

### 2、使用方法：

#### 显示左菜单
```objc
#import "XLSlideMenu.h"
```
#### 显示右菜单
```objc
#import "XLSlideMenu.h"
```
#### 显示主界面
```objc
#import "XLSlideMenu.h"
```
#### 获取菜单宽度
```objc
#import "XLSlideMenu.h"
```
#### 获取留白宽度
```objc
#import "XLSlideMenu.h"
```
#### 跳转新界面
```objc
#import "XLSlideMenu.h"
```


