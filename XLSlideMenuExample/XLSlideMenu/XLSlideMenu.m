//
//  XLSlideMenu.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//



#import "XLSlideMenu.h"

static CGFloat MenuWidthScale = 0.8f;

@interface XLSlideMenu ()
{
    XLSlideDirection _slideDirection;
    CGPoint _originalPoint;
}
@end

@implementation XLSlideMenu

-(instancetype)initWithRootViewController:(UIViewController*)rootViewController{
    if (self = [super init]) {
        _rootViewController = rootViewController;
        [self addChildViewController:_rootViewController];
        [self.view addSubview:_rootViewController.view];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_rootViewController.view addGestureRecognizer:pan];
}

#pragma mark -
#pragma mark Setter

-(void)setLeftViewController:(UIViewController *)leftViewController{
    _leftViewController = leftViewController;
    [self addChildViewController:_leftViewController];
    [self.view insertSubview:_leftViewController.view atIndex:0];
}

-(void)setRightViewController:(UIViewController *)rightViewController{
    _rightViewController = rightViewController;
    [self addChildViewController:_rightViewController];
    [self.view insertSubview:_rightViewController.view atIndex:0];
}

#pragma mark -
#pragma mark 拖拽方法
-(void)pan:(UIPanGestureRecognizer*)pan{
    CGPoint translation = [pan translationInView:self.view];
    NSLog(@"pan.x = %f",translation.x);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            //记录起始位置 方便拖拽移动
            _originalPoint = _rootViewController.view.center;
            break;
        case UIGestureRecognizerStateChanged:
            //滑动到边缘位置后不可以继续滑动
            if (CGRectGetMinX(_rootViewController.view.frame) > [self menuViewWidth]) {return;}
            if (CGRectGetMaxX(_rootViewController.view.frame) < self.view.bounds.size.width - [self menuViewWidth]) {return;}
            _rootViewController.view.center = CGPointMake(_originalPoint.x + translation.x, _originalPoint.y);
            //判断显示左菜单还是右菜单
            if (CGRectGetMinX(_rootViewController.view.frame) > 0) {
                [self.view sendSubviewToBack:_rightViewController.view];
            }else if (CGRectGetMinX(_rootViewController.view.frame) < 0){
                [self.view sendSubviewToBack:_leftViewController.view];
            }
            break;
        case UIGestureRecognizerStateEnded:
        {
            //滑动结束后自动归位
            if (CGRectGetMinX(_rootViewController.view.frame) > [self menuViewWidth]/2) {
                [self showLeftViewController];
            }else if (CGRectGetMaxX(_rootViewController.view.frame) < [self menuViewWidth]/2 + self.view.bounds.size.width - [self menuViewWidth]){
                [self showRightViewController];
            }else{
                [self showRootViewController];
            }
        }
            break;
            
        default:
            break;
    }
}


#pragma mark -
#pragma mark 显示/隐藏方法
-(void)showRootViewController{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _rootViewController.view.frame;
        frame.origin.x = 0;
        _rootViewController.view.frame = frame;
    }];
}

-(void)showLeftViewController{
    [self.view sendSubviewToBack:_rightViewController.view];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _rootViewController.view.frame;
        frame.origin.x = [self menuViewWidth];
        _rootViewController.view.frame = frame;
    }];
}

-(void)showRightViewController{
    [self.view sendSubviewToBack:_leftViewController.view];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _rootViewController.view.frame;
        frame.origin.x = -[self menuViewWidth];
        _rootViewController.view.frame = frame;
    }];
}

#pragma mark -
#pragma mark 其它方法
-(CGFloat)menuViewWidth{
    return MenuWidthScale * self.view.bounds.size.width;
}

-(BOOL)shouldAutorotate{
    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
