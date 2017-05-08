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
    [self.view addGestureRecognizer:pan];
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
            break;
        case UIGestureRecognizerStateChanged:
            _rootViewController.view.center = CGPointMake(_rootViewController.view.center.x + translation.x, _rootViewController.view.center.y);
            break;
        case UIGestureRecognizerStateEnded:
            _rootViewController.view.center = self.view.center;
            break;
            
        default:
            break;
    }
}


#pragma mark -
#pragma mark 显示/隐藏方法
-(void)showRootViewController{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _rootViewController.view.frame;
        frame.origin.x = 0;
        _rootViewController.view.frame = frame;
    }];
}

-(void)showLeftViewController{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _rootViewController.view.frame;
        frame.origin.x = [self menuViewWidth];
        _rootViewController.view.frame = frame;
    }];
}

-(void)showRightViewController{
    [UIView animateWithDuration:0.3 animations:^{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
