//
//  XLSlideMenu.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLSlideMenu.h"

//菜单的显示区域占屏幕宽度的百分比
static CGFloat MenuWidthScale = 0.8f;

@interface XLSlideMenu (){
    //记录起始位置
    CGPoint _originalPoint;
    //遮罩view
    UIView *_coverView;
}
@end

@implementation XLSlideMenu

-(instancetype)initWithRootViewController:(UIViewController*)rootViewController{
    if (self = [super init]) {
        _rootViewController = rootViewController;
        [self addChildViewController:_rootViewController];
        [self.view addSubview:_rootViewController.view];
        [_rootViewController didMoveToParentViewController:self];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_rootViewController.view addGestureRecognizer:pan];
    
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_coverView];
    _coverView.hidden = true;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self updateLeftMenuFrame];
    
    [self updateRightMenuFrame];
}

#pragma mark -
#pragma mark Setter

-(void)setLeftViewController:(UIViewController *)leftViewController{
    _leftViewController = leftViewController;
    [self addChildViewController:_leftViewController];
    [self.view insertSubview:_leftViewController.view atIndex:0];
    [_leftViewController didMoveToParentViewController:self];
}

-(void)setRightViewController:(UIViewController *)rightViewController{
    _rightViewController = rightViewController;
    [self addChildViewController:_rightViewController];
    [self.view insertSubview:_rightViewController.view atIndex:0];
    [_rightViewController didMoveToParentViewController:self];
}

#pragma mark -
#pragma mark 拖拽方法
-(void)pan:(UIPanGestureRecognizer*)pan{
    switch (pan.state) {
            //记录起始位置 方便拖拽移动
        case UIGestureRecognizerStateBegan:
            _originalPoint = _rootViewController.view.center;
            break;
        case UIGestureRecognizerStateChanged:
            [self panChanged:pan];
            break;
            //滑动结束后自动归位
        case UIGestureRecognizerStateEnded:
            if (CGRectGetMinX(_rootViewController.view.frame) > self.menuWidth/2) {
                [self showLeftViewController];
            }else if (CGRectGetMaxX(_rootViewController.view.frame) < self.menuWidth/2 + self.emptyWidth){
                [self showRightViewController];
            }else{
                [self showRootViewController];
            }
            break;
            
        default:
            break;
    }
}

//拖拽方法
-(void)panChanged:(UIPanGestureRecognizer*)pan{
    //拖拽的距离
    CGPoint translation = [pan translationInView:self.view];
    //移动主控制器
    _rootViewController.view.center = CGPointMake(_originalPoint.x + translation.x, _originalPoint.y);
    //判断是否设置了左右菜单
    if (!_rightViewController && CGRectGetMinX(_rootViewController.view.frame) <= 0 ) {
        _rootViewController.view.frame = self.view.bounds;
    }
    if (!_leftViewController && CGRectGetMinX(_rootViewController.view.frame) >= 0) {
        _rootViewController.view.frame = self.view.bounds;
    }
    //滑动到边缘位置后不可以继续滑动
    if (CGRectGetMinX(_rootViewController.view.frame) > self.menuWidth) {
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 + self.menuWidth, _rootViewController.view.center.y);
    }
    if (CGRectGetMaxX(_rootViewController.view.frame) < self.emptyWidth) {
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 - self.menuWidth, _rootViewController.view.center.y);
    }
    //判断显示左菜单还是右菜单
    if (CGRectGetMinX(_rootViewController.view.frame) > 0) {
        //显示左菜单
        [self.view sendSubviewToBack:_rightViewController.view];
        //更新左菜单位置
        [self updateLeftMenuFrame];
    }else if (CGRectGetMinX(_rootViewController.view.frame) < 0){
        //显示右菜单
        [self.view sendSubviewToBack:_leftViewController.view];
        //更新右侧菜单的位置
        [self updateRightMenuFrame];
    }
}


#pragma mark -
#pragma mark 显示/隐藏方法
//显示主视图
-(void)showRootViewController{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _rootViewController.view.frame;
        frame.origin.x = 0;
        _rootViewController.view.frame = frame;
        [self updateLeftMenuFrame];
        [self updateRightMenuFrame];
    }];
}
//显示左侧菜单
-(void)showLeftViewController{
    if (!_leftViewController) {return;}
    [self.view sendSubviewToBack:_rightViewController.view];
    [UIView animateWithDuration:0.25 animations:^{
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 + self.menuWidth, _rootViewController.view.center.y);
        _leftViewController.view.frame = self.view.bounds;
    }];
}
//显示右侧菜单
-(void)showRightViewController{
    if (!_rightViewController) {return;}
    [self.view sendSubviewToBack:_leftViewController.view];
    [UIView animateWithDuration:0.25 animations:^{
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 - self.menuWidth, _rootViewController.view.center.y);
        _rightViewController.view.frame = self.view.bounds;
    }];
}

#pragma mark -
#pragma mark 其它方法

//更新左侧菜单位置
-(void)updateLeftMenuFrame{
    _leftViewController.view.center = CGPointMake((CGRectGetMinX(_rootViewController.view.frame) + self.emptyWidth)/2, _leftViewController.view.center.y);
}

//更新右侧菜单位置
-(void)updateRightMenuFrame{
    _rightViewController.view.center = CGPointMake((self.view.bounds.size.width + CGRectGetMaxX(_rootViewController.view.frame) - self.emptyWidth)/2, _rightViewController.view.center.y);
}

//菜单宽度
-(CGFloat)menuWidth{
    return MenuWidthScale * self.view.bounds.size.width;
}
//空白宽度
-(CGFloat)emptyWidth{
    return self.view.bounds.size.width - self.menuWidth;
}

//取消自动旋转
-(BOOL)shouldAutorotate{
    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
