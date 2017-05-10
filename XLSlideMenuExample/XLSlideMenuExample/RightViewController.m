//
//  RightViewController.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//  GitHub:https://github.com/mengxianliang/XLSlideMenu

#import "RightViewController.h"
#import "RightCollectionViewCell.h"
#import "XLSlideMenu.h"

@interface RightViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildTable];
}

-(void)buildTable
{
    CGFloat margin = [self itemMargin];
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.xl_sldeMenu.emptyWidth + margin, 20, 200, 30)];
    tipsLabel.text = @" XLSlideMenuTips";
    tipsLabel.font = [UIFont boldSystemFontOfSize:18];
    tipsLabel.textColor = [UIColor colorWithRed:36/255.0f green:41/255.0f blue:46/255.0f alpha:1];
    [self.view addSubview:tipsLabel];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = margin;
    flowLayout.minimumLineSpacing = margin;
    flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.xl_sldeMenu.emptyWidth, CGRectGetMaxY(tipsLabel.frame) + margin, self.xl_sldeMenu.menuWidth, self.view.bounds.size.height - CGRectGetMaxY(tipsLabel.frame) - margin) collectionViewLayout:flowLayout];
    [_collectionView registerClass:[RightCollectionViewCell class] forCellWithReuseIdentifier:@"RightCollectionViewCell"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource

-(NSArray *)titles{
    return @[@"显示主界面",@"显示左菜单",@"显示右菜单",@"设置滑动开关",@"获取菜单宽度",@"获取留白宽度",@"Push新界面"];
}

-(NSArray *)subTitles{
    return @[@"调用showRootViewControllerAnimated:方法",
             @"调用showLeftViewControllerAnimated:方法",
             @"调用showRightViewControllerAnimated:方法",
             @"设置SlideMenu的slideEnabled属性，默认打开，设置False即可关闭",
             @"SlideMenu的menuWidth属性是菜单宽度",
             @"SlideMenu的emptyWidth属性是留白宽度",
             @"第一步:判断RootViewController类型，如果是UINavigationController就直接push,如果是Tabbar就找到Tabbar的selectedViewController执行Push动作;\n第二步:执行显示主界面方法"
             ];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self titles].count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat margin = [self itemMargin];
    CGFloat itemWidth = (self.xl_sldeMenu.menuWidth - 3 * margin)/2.0f;
    CGSize itemSize = CGSizeMake(itemWidth, itemWidth);
    if (indexPath.row == [self titles].count - 1) {
        itemSize = CGSizeMake(self.xl_sldeMenu.menuWidth - 2 * margin, itemWidth);
    }
    return itemSize;
}

-(CGFloat)itemMargin{
    return 5.0f;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RightCollectionViewCell" forIndexPath:indexPath];
    cell.layer.borderWidth = 1.0f;
    cell.title = [self titles][indexPath.row];
    cell.subTitle = [self subTitles][indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self titles].count - 1) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = @"ViewController";
        vc.view.backgroundColor = [UIColor whiteColor];
        //获取RootViewController
        UINavigationController *nav = (UINavigationController*)self.xl_sldeMenu.rootViewController;
        [nav pushViewController:vc animated:false];
        //显示主视图
        [self.xl_sldeMenu showRootViewControllerAnimated:true];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
