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

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    _leftViewController.view.center = CGPointMake(self.emptyWidth/2, _leftViewController.view.center.y);
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
            _rootViewController.view.center = CGPointMake(_originalPoint.x + translation.x, _originalPoint.y);
            //滑动到边缘位置后不可以继续滑动
            if (CGRectGetMinX(_rootViewController.view.frame) > self.menuWidth) {
                _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 + self.menuWidth, _rootViewController.view.center.y);
            }
            if (CGRectGetMaxX(_rootViewController.view.frame) < self.emptyWidth) {
                _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 - self.menuWidth, _rootViewController.view.center.y);
            }
            //判断显示左菜单还是右菜单
            if (CGRectGetMinX(_rootViewController.view.frame) > 0) {
                [self.view sendSubviewToBack:_rightViewController.view];
                _leftViewController.view.center = CGPointMake(CGRectGetMinX(_rootViewController.view.frame)/2 + self.emptyWidth/2, _leftViewController.view.center.y);
            }else if (CGRectGetMinX(_rootViewController.view.frame) < 0){
                [self.view sendSubviewToBack:_leftViewController.view];
            }
            break;
        case UIGestureRecognizerStateEnded:
        {
            //滑动结束后自动归位
            if (CGRectGetMinX(_rootViewController.view.frame) > self.menuWidth/2) {
                [self showLeftViewController];
            }else if (CGRectGetMaxX(_rootViewController.view.frame) < self.menuWidth/2 + self.emptyWidth){
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
        
        _leftViewController.view.center = CGPointMake(self.emptyWidth/2, _leftViewController.view.center.y);
    }];
}

-(void)showLeftViewController{
    [self.view sendSubviewToBack:_rightViewController.view];
    [UIView animateWithDuration:0.25 animations:^{
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 + self.menuWidth, _rootViewController.view.center.y);
        _leftViewController.view.frame = self.view.bounds;
    }];
}

-(void)showRightViewController{
    [self.view sendSubviewToBack:_leftViewController.view];
    [UIView animateWithDuration:0.25 animations:^{
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 - self.menuWidth, _rootViewController.view.center.y);
    }];
}

#pragma mark -
#pragma mark 其它方法
//菜单宽度
-(CGFloat)menuWidth{
    return MenuWidthScale * self.view.bounds.size.width;
}
//空白宽度
-(CGFloat)emptyWidth{
    return self.view.bounds.size.width - self.menuWidth;
}

-(BOOL)shouldAutorotate{
    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
