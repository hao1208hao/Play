//
//  QDBNavController.m
//  
//
//  Created by zhongad on 15/12/24.
//  Copyright © 2015年 zhongad. All rights reserved.
//

#import "QDBNavController.h"

#define NavBarTitleFont 18
#define NavBarTitleColor [UIColor whiteColor]

@implementation QDBNavController

/**
 * 每个控制器调用这个类就会初始化一次，且只初始化一次
 */
- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  系统在第一次使用这个类的时候调用(1个类只会调用一次)
 */
+ (void)initialize {
    // 1. 设置导航栏的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBarTintColor:[UIColor clearColor]];
    UIImage *img = QDBImage(@"Navigation_BG");
    // 设置标题文字颜色
//    [navBar setBackgroundImage:img forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    [navBar setShadowImage:[UIImage new]];
    attrs[NSForegroundColorAttributeName] = NavBarTitleColor;
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:NavBarTitleFont];
    [navBar setTitleTextAttributes:attrs];
    
}

/**
 *  拦截push跳转
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        // 如果不是根控制器创建返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navBack" highIcon:@"navBack" target:self action:@selector(backAction)];

        // 背景颜色
        viewController.view.backgroundColor = GlobalBackgroundColor;
        // 隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/**
 *  返回按钮(Pop)
 */
- (void)backAction {
    [self popViewControllerAnimated:YES];
}

@end
