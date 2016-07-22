//
//  DCSUserPersonalInfo.m
//  DaCaiShen
//
//  Created by haohao on 16/3/8.
//  Copyright © 2016年 某某某. All rights reserved.
//

#import "QDBUserInfo.h"
#import "AppDelegate.h"

@implementation QDBUserInfo

SingletonM(UserInfo)


+(UIViewController*)getTopVC{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

//获取当前最上层控制器
+(UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


@end
