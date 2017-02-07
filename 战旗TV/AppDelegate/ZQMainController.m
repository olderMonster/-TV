//
//  ZQMainController.m
//  战旗TV
//
//  Created by 印聪 on 2016/12/28.
//  Copyright © 2016年 monster. All rights reserved.
//

#import "ZQMainController.h"

#import "OMTabbar.h"
#import "YCNavigationViewController.h"
#import "ZQGameController.h"
#import "ZQEntertainController.h"
#import "ZQSubscriptionController.h"
#import "ZQUserController.h"


#define kTabbarHeight 44

@interface ZQMainController ()<UINavigationControllerDelegate,OMTabbarDelegate>

@property (nonatomic , strong)OMTabbar *zqTabbar;

@end

@implementation ZQMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ZQGameController *gameVC = [[ZQGameController alloc] init];
    YCNavigationViewController *gameNav = [[YCNavigationViewController alloc]initWithRootViewController:gameVC];
    gameNav.delegate = self;
    [self addChildViewController:gameNav];
    
    ZQEntertainController *recreationVC = [[ZQEntertainController alloc] init];
    YCNavigationViewController *recreationNav = [[YCNavigationViewController alloc]initWithRootViewController:recreationVC];
    recreationNav.delegate = self;
    [self addChildViewController:recreationNav];
    
    ZQSubscriptionController *subscriptionVC = [[ZQSubscriptionController alloc] init];
    YCNavigationViewController *subscriptionNav = [[YCNavigationViewController alloc]initWithRootViewController:subscriptionVC];
    subscriptionNav.delegate = self;
    [self addChildViewController:subscriptionNav];
    
    ZQUserController *userVC = [[ZQUserController alloc] init];
    YCNavigationViewController *userNav = [[YCNavigationViewController alloc]initWithRootViewController:userVC];
    userNav.delegate = self;
    [self addChildViewController:userNav];
    
    
    [self.view addSubview:self.zqTabbar];
    
    [self.zqTabbar addItemWithIcon:@"tabbar_home" selctedIcon:@"tabbar_home_sel" title:@"游戏"];
    [self.zqTabbar addItemWithIcon:@"tabbar_entertain" selctedIcon:@"tabbar_entertain_sel" title:@"娱乐"];
    [self.zqTabbar addItemWithIcon:@"tabbar_subscribe" selctedIcon:@"tabbar_subscribe_sel" title:@"订阅"];
    [self.zqTabbar addItemWithIcon:@"tabbar_me" selctedIcon:@"tabbar_me_sel" title:@"我的"];
    
}


#pragma mark -- OMTabbarDelegate
- (void)tabbar:(OMTabbar *)tabbar itemSelectedFrom:(int)from to:(int)to{
    if (to < 0 || to > self.childViewControllers.count){
        return;
    }
    
    //取得旧的控制器
    UIViewController *oldVC = self.childViewControllers[from];
    [oldVC.view removeFromSuperview];
    
    
    //取得将要显示的控制器的
    UIViewController *showVC = self.childViewControllers[to];
    
    //设置将要显示的控制器的view的大小
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height - kTabbarHeight;
    showVC.view.frame = CGRectMake(0, 0, width, height);
    
    //将要显示的view添加到控制器
    [self.view addSubview:showVC.view];
    
}


#pragma mark -- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //取得当前导航控制器的根控制器
    UINavigationController *rootVC = navigationController.viewControllers[0];
    if (rootVC != viewController){
        //将要显示的控制器非根控制器,此时隐藏下方的tabbar
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].bounds.size.height;
        navigationController.view.frame = frame;
        
        
        //添加tabbar到根控制器上，以实现在跳转时让tabbar跟随移动的效果
        [self.zqTabbar removeFromSuperview];
        CGRect tabbarFrame = self.zqTabbar.frame;
        tabbarFrame.origin.y = rootVC.view.frame.size.height - self.zqTabbar.frame.size.height;
        if ([rootVC.view isKindOfClass:[UIScrollView class]]){
            UIScrollView *scrollView = (UIScrollView *)rootVC.view;
            [scrollView addSubview:self.zqTabbar];
            [UIView beginAnimations:nil context:nil];
            tabbarFrame.origin.y += scrollView.contentOffset.y;
            [UIView commitAnimations];
        }
        self.zqTabbar.frame = tabbarFrame;
        [rootVC.view addSubview:self.zqTabbar];
    }
    
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //获取当前导航控制器的根控制器
    UINavigationController *rootVC = navigationController.viewControllers[0];
    if (rootVC == viewController){
        //当前显示的控制器是根控制器，此时需要显示tabbar
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].bounds.size.height;
        navigationController.view.frame = frame;
        
        //添加tabbar到mainView上
        [self.zqTabbar removeFromSuperview];
        CGRect tabbarFrame = self.zqTabbar.frame;
        //调整tabbar的高度
        tabbarFrame.origin.y = self.view.bounds.size.height - self.zqTabbar.bounds.size.height;
        self.zqTabbar.frame = tabbarFrame;
        [self.view addSubview:self.zqTabbar];
    }
}


#pragma mark -- getters and setters
- (OMTabbar *)zqTabbar{
    if (_zqTabbar == nil) {
        _zqTabbar = [[OMTabbar alloc]init];
        _zqTabbar.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        _zqTabbar.frame = CGRectMake(0, self.view.bounds.size.height - kTabbarHeight, self.view.bounds.size.width, kTabbarHeight);
        _zqTabbar.selctedTextColor = [UIColor whiteColor];
        _zqTabbar.delegate = self;
    }
    return _zqTabbar;
}

@end
