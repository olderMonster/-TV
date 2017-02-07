//
//  NavigationViewController.m
//  YRJJApp
//
//  Created by luwelong on 14/12/2.
//  Copyright (c) 2014年 luwelong. All rights reserved.
//

#import "YCNavigationViewController.h"

@interface YCNavigationViewController ()

@end

@implementation YCNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获得所有导航栏外观的设置权限
    UINavigationBar *bar = [UINavigationBar appearance];
    //设置属性
    NSDictionary *barAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    
    //设置所有导航栏文字
    [bar setTitleTextAttributes:barAttributes];
    
    // bg.png为自己ps出来的想要的背景颜色。
    [bar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }

    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //重写返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    //背景图片
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    //点击事件
    [backBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    if (viewController.navigationItem.leftBarButtonItem == nil&&self.viewControllers.count > 1) {
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
}




- (void)backTo{
    [self popViewControllerAnimated:YES];
}

//颜色转图片
- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
