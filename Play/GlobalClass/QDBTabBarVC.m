//
//  QDBTabBarVC.m
//
//
//  Created by zhongad on 15/12/19.
//  Copyright © 2015年 zhongad. All rights reserved.
//

#import "QDBTabBarVC.h"
#import "QDBNavController.h"
#import "ViewController.h"
#import "SecondVC.h"

@interface QDBTabBarVC ()

@end

@implementation QDBTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    self.tabBar.tintColor = GlobalNavColor;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    //0.首页
    ViewController * home = [[ViewController alloc]init];
    SecondVC* second = [[SecondVC alloc]init];
    
    
    
    [self setupChildViewController:home title:@"第一页" imageName:@"1" selectedImageName:@"1"];

    [self setupChildViewController:second title:@"第二页" imageName:@"1" selectedImageName:@"1"];

    
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 1.设置控制器的属性
    //当self.navigationItem.title，self.tabBarItem.title没有赋值情况下值和self.title一致。
    childVc.title = title;  //设置tabbar 的title
    childVc.navigationItem.title = @"";  //导航title
    
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装一个导航控制器
    QDBNavController *nav = [[QDBNavController alloc] initWithRootViewController:childVc];
    childVc.view.backgroundColor = GlobalBackgroundColor;
    nav.view.backgroundColor = GlobalBackgroundColor;
    [self addChildViewController:nav];
}

@end
