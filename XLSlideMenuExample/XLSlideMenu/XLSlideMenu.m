//
//  XLSlideMenu.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//  GitHub:https://github.com/mengxianliang/XLSlideMenu

#import "XLSlideMenu.h"

//菜单的显示区域占屏幕宽度的百分比
static CGFloat MenuWidthScale = 0.8f;
//遮罩层最高透明度
static CGFloat MaxCoverAlpha = 0.3;
//快速滑动最小触发速度
static CGFloat MinActionSpeed = 500;

@interface XLSlideMenu ()<UIGestureRecognizerDelegate>{
    //记录起始位置
    CGPoint _originalPoint;
}

//遮罩view
@property (nonatomic, strong) UIView *coverView;
//拖拽手势
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    _pan.delegate = self;
    [self.view addGestureRecognizer:_pan];
    
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0;
    _coverView.hidden = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_coverView addGestureRecognizer:tap];
    [_rootViewController.view addSubview:_coverView];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self updateLeftMenuFrame];
    
    [self updateRightMenuFrame];
}

#pragma mark -
#pragma mark Setter&&Getter

-(void)setLeftViewController:(UIViewController *)leftViewController{
    _leftViewController = leftViewController;
    //提前设置ViewController的viewframe，为了懒加载view造成的frame问题，所以通过setter设置了新的view
    _leftViewController.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self menuWidth], self.view.bounds.size.height)];
    //自定义View需要主动调用viewDidLoad
    [_leftViewController viewDidLoad];
    [self addChildViewController:_leftViewController];
    [self.view insertSubview:_leftViewController.view atIndex:0];
    [_leftViewController didMoveToParentViewController:self];
}

-(void)setRightViewController:(UIViewController *)rightViewController{
    _rightViewController = rightViewController;
    //提前设置ViewController的viewframe，为了懒加载view造成的frame问题，所以通过setter设置了新的view
    _rightViewController.view = [[UIView alloc] initWithFrame:CGRectMake([self emptyWidth], 0, [self menuWidth], self.view.bounds.size.height)];
    //自定义View需要主动调用viewDidLoad
    [_rightViewController viewDidLoad];
    [self addChildViewController:_rightViewController];
    [self.view insertSubview:_rightViewController.view atIndex:0];
    [_rightViewController didMoveToParentViewController:self];
}

-(void)setSlideEnabled:(BOOL)slideEnabled{
    _pan.enabled = slideEnabled;
}

-(BOOL)slideEnabled{
    return _pan.isEnabled;
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
        case UIGestureRecognizerStateEnded:
            //滑动结束后自动归位
            [self panEnd:pan];
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
        //更新遮罩层的透明度
        _coverView.hidden = false;
        [_rootViewController.view bringSubviewToFront:_coverView];
        _coverView.alpha = CGRectGetMinX(_rootViewController.view.frame)/self.menuWidth * MaxCoverAlpha;
    }else if (CGRectGetMinX(_rootViewController.view.frame) < 0){
        //显示右菜单
        [self.view sendSubviewToBack:_leftViewController.view];
        //更新右侧菜单的位置
        [self updateRightMenuFrame];
        //更新遮罩层的透明度
        _coverView.hidden = false;
        [_rootViewController.view bringSubviewToFront:_coverView];
        _coverView.alpha = (CGRectGetMaxX(self.view.frame) - CGRectGetMaxX(_rootViewController.view.frame))/self.menuWidth * MaxCoverAlpha;
    }
}

//拖拽结束
- (void)panEnd:(UIPanGestureRecognizer*)pan {
    
    //处理快速滑动
    CGFloat speedX = [pan velocityInView:pan.view].x;
    if (ABS(speedX) > MinActionSpeed) {
        [self dealWithFastSliding:speedX];
        return;
    }
    //正常速度
    if (CGRectGetMinX(_rootViewController.view.frame) > self.menuWidth/2) {
        [self showLeftViewControllerAnimated:true];
    }else if (CGRectGetMaxX(_rootViewController.view.frame) < self.menuWidth/2 + self.emptyWidth){
        [self showRightViewControllerAnimated:true];
    }else{
        [self showRootViewControllerAnimated:true];
    }
}

//处理快速滑动
- (void)dealWithFastSliding:(CGFloat)speedX {
    //向左滑动
    BOOL swipeRight = speedX > 0;
    //向右滑动
    BOOL swipeLeft = speedX < 0;
    //rootViewController的左边缘位置
    CGFloat roootX = CGRectGetMinX(_rootViewController.view.frame);
    if (swipeRight) {//向右滑动
        if (roootX > 0) {//显示左菜单
            [self showLeftViewControllerAnimated:true];
        }else if (roootX < 0){//显示主菜单
            [self showRootViewControllerAnimated:true];
        }
    }
    if (swipeLeft) {//向左滑动
        if (roootX < 0) {//显示右菜单
            [self showRightViewControllerAnimated:true];
        }else if (roootX > 0){//显示主菜单
            [self showRootViewControllerAnimated:true];
        }
    }
    return;
}

#pragma mark -
#pragma mark PanDelegate
//设置拖拽响应范围、设置Navigation子视图不可拖拽
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //设置Navigation子视图不可拖拽
    if ([_rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)_rootViewController;
        if (navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer.enabled) {
            return NO;
        }
    }
    //如果Tabbar的当前视图是UINavigationController，设置UINavigationController子视图不可拖拽
    if ([_rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController*)_rootViewController;
        UINavigationController *navigationController = tabbarController.selectedViewController;
        if ([navigationController isKindOfClass:[UINavigationController class]]) {
            if (navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer.enabled) {
                return NO;
            }
        }
    }
    //设置拖拽响应范围
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        //拖拽响应范围是距离边界是空白位置宽度
        CGFloat actionWidth = [self emptyWidth];
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x <= actionWidth || point.x > self.view.bounds.size.width - actionWidth) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

- (void)tap {
    [self showRootViewControllerAnimated:true];
}

#pragma mark -
#pragma mark 显示/隐藏方法
//显示主视图
-(void)showRootViewControllerAnimated:(BOOL)animated{
    
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        CGRect frame = _rootViewController.view.frame;
        frame.origin.x = 0;
        _rootViewController.view.frame = frame;
        [self updateLeftMenuFrame];
        [self updateRightMenuFrame];
        _coverView.alpha = 0;
    }completion:^(BOOL finished) {
        _coverView.hidden = true;
    }];
}

//显示左侧菜单
- (void)showLeftViewControllerAnimated:(BOOL)animated {
    if (!_leftViewController) {return;}
    [self.view sendSubviewToBack:_rightViewController.view];
    _coverView.hidden = false;
    [_rootViewController.view bringSubviewToFront:_coverView];
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 + self.menuWidth, _rootViewController.view.center.y);
        _leftViewController.view.frame = CGRectMake(0, 0, [self menuWidth], self.view.bounds.size.height);
        _coverView.alpha = MaxCoverAlpha;
    }];
}

//显示右侧菜单
- (void)showRightViewControllerAnimated:(BOOL)animated {
    if (!_rightViewController) {return;}
    _coverView.hidden = false;
    [_rootViewController.view bringSubviewToFront:_coverView];
    [self.view sendSubviewToBack:_leftViewController.view];
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 - self.menuWidth, _rootViewController.view.center.y);
        _rightViewController.view.frame = CGRectMake([self emptyWidth], 0, [self menuWidth], self.view.bounds.size.height);
        _coverView.alpha = MaxCoverAlpha;
    }];
}

#pragma mark -
#pragma mark 其它方法
//更新左侧菜单位置
- (void)updateLeftMenuFrame {
    _leftViewController.view.center = CGPointMake(CGRectGetMinX(_rootViewController.view.frame)/2, _leftViewController.view.center.y);
}

//更新右侧菜单位置
- (void)updateRightMenuFrame {
    _rightViewController.view.center = CGPointMake((self.view.bounds.size.width + CGRectGetMaxX(_rootViewController.view.frame))/2, _rightViewController.view.center.y);
}

//菜单宽度
- (CGFloat)menuWidth {
    return MenuWidthScale * self.view.bounds.size.width;
}

//空白宽度
- (CGFloat)emptyWidth {
    return self.view.bounds.size.width - self.menuWidth;
}

//动画时长
- (CGFloat)animationDurationAnimated:(BOOL)animated {
    return animated ? 0.25 : 0;
}

//取消自动旋转
- (BOOL)shouldAutorotate {
    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
